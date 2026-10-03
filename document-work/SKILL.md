---
name: document-work
description: Use when a work session is ending — the user says "wrap up", "end the session", "document this", or "invoke document-work", or a plan, phase, or development branch has just finished — and a future agent starting cold will need the decisions, changes, and current state.
---

# Document Work

## Overview

Capture context for future agents at the end of work sessions.

**Announce at start:** "Using document-work to capture context for future sessions."

Primary audience: a future Claude instance starting cold — not a human skimming a polished doc. Format is dense, structured, and optimized for machine comprehension. No narrative fluff.

## Where Context Lives

Each kind of context has exactly one home. Write each fact once, in its home.

| Layer | Holds | Role in this skill |
|-------|-------|--------------------|
| Project docs (change log, decision records, state doc) | What changed, why, current state | **Source of truth** — this skill writes them |
| Persistent memory (if the environment has one) | A pointer to the state doc; user preferences and feedback | Step 6 writes one pointer per project |
| Plan file / progress ledger | Live task-by-task progress during execution | Input to Step 1 — read it, don't copy it |
| Chat summary | This session's wrap-up message | Ephemeral — Step 7 |

## Step 1: Gather What Happened

Build the inventory from evidence, not recollection — long sessions lose detail to context summarization.

- `git log` and `git diff --stat` since the session started (every repo touched, if any)
- Plan files and progress ledgers touched this session
- The session's task list, if one was kept
- Decisions and surprises from the conversation

If nothing changed, nothing was decided, and nothing was learned: say so and stop.

## Step 2: Locate the Docs

Use the first rule that applies, separately for each of the three docs:

1. **No filesystem** (e.g. claude.ai chat): output the entries from Step 5 in the chat as one Markdown block for the user to save. Skip Steps 4 and 6.
2. **Project instructions** (CLAUDE.md, AGENTS.md, etc.) name a location: use it.
3. **An existing convention** is present (`CHANGES.md`, a `decisions/` folder, a context doc): follow it.
4. **Otherwise** use these defaults:
   - Change log: `docs/CHANGES.md`
   - Decision records: `docs/decisions/YYYY-MM-DD-<topic>.md`
   - State doc: `docs/CONTEXT.md` — or `docs/context/<project>.md` when the repo holds several projects. Never `README.md`; that file is for humans.
5. **Still unclear:** ask *"Where should documentation for this work live?"* with 2–3 options based on what's observable.

## Step 3: Classify Scope

| Scope | Examples | Produce |
|-------|----------|---------|
| Investigation | Diagnosis, research, exploration — no files changed | Change log entry, description suffixed "(investigation only)", recording findings |
| Minor | Bug fix, config tweak, small refactor, single-note update | Change log entry |
| Significant | New feature, system built, structural change, completed plan phase | Change log entry + state doc |

**Threshold:** Would a new agent need more than 2 minutes to reconstruct why this was built this way? If yes → significant.

**Decision record — any scope:** write one only when a real choice between named alternatives was made this session. Execution progress, review findings, and task lists go in the change log entry.

## Step 4: Check for Existing Entries

This skill can run more than once per session (a plan completes, then the branch finishes, then the user says "wrap up").

- Change log entry dated today covering this work → update it in place.
- Decision record already written today for this topic → update it in place.
- State doc → always updated in place.

## Step 5: Write the Docs

**Privacy:** these docs may be committed and pushed, and the repo may be public. Refer to private content (personal notes, contacts, customer data) by path or count. Write secrets and credentials as the name of the variable or file that holds them.

### Change Log Entry

Append-only running log, newest at the bottom unless the file's existing order says otherwise.

```
## YYYY-MM-DD — <brief description>

- What changed: <summary; include commit hashes>
- Files/systems affected: <list>
- Dependencies added/removed: <if any>
- Surprises for future maintainers: <anything non-obvious>
```

### Decision Record

One file per decision. When a field (e.g. tradeoffs) wasn't discussed, ask the user rather than inferring it. A prior decision is never edited after its session; a reversal gets a new record that links the one it supersedes.

```
## YYYY-MM-DD — <topic>

**Decision:** <what was decided>
**Alternatives considered:** <what else was evaluated>
**Why this won:** <reasoning>
**Tradeoffs accepted:** <what we gave up>
**To revisit if:** <conditions that would change this decision>
**Supersedes:** <link, if any>
```

### State Doc

Always reflects current state. A new agent reads this first.

- What this system/project is (one paragraph, current state)
- Current status, including the next step
- Key entry points / where to start
- What to read next (links to decision records, relevant plans)

## Step 6: Refresh the Memory Pointer

If the environment has persistent memory (e.g. Claude Code auto-memory), keep one memory per project. Update the existing one rather than creating another. Do this only when a state doc exists for the project; otherwise skip this step. Before replacing an older, longer memory body, confirm its facts are in the project docs and move any that aren't. The memory body is exactly three lines:

```
Status: <shipped | in progress | paused | blocked> as of YYYY-MM-DD
Next: <the single next action, or "none">
Read: <path to the state doc>
```

Everything else about the project lives in the state doc.

## Step 7: Report

End with a list of every file created or updated, one line each: path, then what was added.

## What This Skill Is Not

- Not a replacement for inline code comments
- Not a changelog for package releases
- Not a mid-task checkpoint — the plan file or progress ledger handles that
