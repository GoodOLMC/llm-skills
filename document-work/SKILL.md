---
name: document-work
description: Automatic documentation at end of work sessions - captures decisions, changes, and current state for future agents. Invoked automatically per CLAUDE.md, or on demand ("wrap up", "invoke document-work").
---

# Document Work

## Overview

Capture context for future agents at the end of work sessions.

**Announce at start:** "Using document-work to capture context for future sessions."

Primary audience: a future Claude instance starting cold — not a human skimming a polished doc. Format is dense, structured, and optimized for machine comprehension. No narrative fluff.

## Step 1: Context Detection

Determine where documentation should live before doing anything else:

| Context | Doc Location |
|---------|-------------|
| Code project (git repo with source files) | In the repo — `docs/`, `.claude/context/`, or following existing project conventions |
| Non-code project (KB work, planning, research, Obsidian) | `docs/superpowers/` using existing pattern, or within the project's own structure if one exists |
| Ambiguous | Ask: *"Where should documentation for this work live?"* with 2–3 sensible options based on what's observable |

## Step 2: Scope Judgment

Classify the work before producing any documents:

**Minor** — bug fix, config tweak, small refactor, single-note KB update
→ Append one entry to the Change Summary only. No other documents.

**Significant** — new feature, architectural decision, system built from scratch, structural KB change, completed plan phase
→ Produce all three documents (Step 3).

**Threshold:** Would a new agent need more than 2 minutes to reconstruct why this was built this way? If yes → significant.

## Step 3: Produce Documents

### For Minor Work Only

Append one entry to the Change Summary (create it if it doesn't exist):

**Location:**
- Code: `CHANGES.md` or `docs/CHANGES.md`
- Non-code: `docs/superpowers/CHANGES.md`

**Entry format:**
```
## YYYY-MM-DD — <brief description>
- What changed: <summary>
- Files/systems affected: <list>
- Anything non-obvious: <if any>
```

Done. Do not produce the other two documents for minor work.

---

### For Significant Work — Produce All Three

#### Document 1: Decision Record

Append-only. Add a new dated entry. Never overwrite prior entries.

**Location:**
- Code: `docs/decisions/YYYY-MM-DD-<topic>.md` or appended to `DECISIONS.md`
- Non-code: `docs/superpowers/decisions/YYYY-MM-DD-<topic>.md`

**Entry format:**
```
## YYYY-MM-DD — <topic>

**Decision:** <what was decided>
**Alternatives considered:** <what else was evaluated>
**Why this won:** <reasoning>
**Tradeoffs accepted:** <what we gave up>
**To revisit if:** <conditions that would change this decision>
```

#### Document 2: Change Summary

Append-only running log. For non-code work: include what notes were created/modified, what structure changed, what conventions were established.

**Location:**
- Code: `CHANGES.md` or `docs/CHANGES.md`
- Non-code: `docs/superpowers/CHANGES.md`

**Entry format:**
```
## YYYY-MM-DD — <brief description>

- What changed: <summary>
- Files/systems affected: <list>
- Dependencies added/removed: <if any>
- Surprises for future maintainers: <anything non-obvious>
```

#### Document 3: State/Usage Doc

Updated in place if it exists; created fresh if it doesn't. Always reflects current state. A new agent reads this first.

**Location:**
- Code: `README.md` or `docs/CONTEXT.md`
- Non-code: project-specific (e.g., `docs/superpowers/context/<project>.md`)

**Contents:**
- What this system/project is (one paragraph, current state)
- Current status
- Key entry points / where to start
- What to read next (links to decision record, relevant plans)

## What This Skill Is Not

- Not a replacement for inline code comments
- Not integrated into `kb-process-daily-note` (that skill has its own output conventions)
- Not a changelog for package releases
