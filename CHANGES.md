# Changes

## 2026-10-03 — document-work v1.1.1

- What changed: Added a state-doc index. When state docs live in a folder, that folder's `INDEX.md` lists every project in Active and Done sections, each row with status, date, next step and a one-sentence summary. The index is updated whenever a state doc is created or changes status. It gives a cold agent an entry point that needs no project name or date, closing the gap where records were findable only by date (change log) or by name (state docs).
- Files/systems affected: `document-work/SKILL.md` (layer table, Step 2 default, Step 3 Significant row, Step 4, new "Index Row" section), `README.md` status line.
- Dependencies added/removed: None.
- Surprises for future maintainers: The first application, building an index of 30 existing state docs in a knowledge-base repo, needed no extra rules. A doc with no status line gets `reference` plus its last-modified date.

## 2026-10-03 — document-work v1.1.0

- What changed: Reworked `document-work/SKILL.md` after reviewing ~6 months of its output in a personal knowledge-base repo (90 change entries, 56 decision records, 30 state docs). Added: a "Where Context Lives" layer table (project docs = source of truth, persistent memory = 3-line pointer, plan ledger = input only); Step 1 evidence gathering from git/plans/tasks; a no-filesystem path (claude.ai → emit entries in chat); per-doc location resolution (project instructions → existing convention → `docs/` defaults, never `README.md`); an Investigation scope tier; decision records only when a real choice between named alternatives was made; an idempotency check (re-runs update today's entry in place); a privacy rule for committed/public docs; a final file report. Removed host-specific paths and skill names. Description rewritten as triggers only.
- Files/systems affected: `document-work/SKILL.md`, `README.md` status line, new `docs/decisions/2026-10-03-document-work-memory-pointer.md`.
- Dependencies added/removed: None.
- Surprises for future maintainers: (1) Verified by a fresh Sonnet paper test on 3 scenarios (second invocation in one session, claude.ai with no filesystem, investigation-only); it passed all of them and found 4 gaps (partial location config, pointer with no state doc, stale long memory bodies, invented decision fields), which were fixed before the release. (2) Host-specific locations (e.g. a vault's `docs/superpowers/`) now belong in that host's CLAUDE.md, because Step 2 checks project instructions first.

## 2026-07-21 — document-work v1.0.0 release, second skill added

- What changed: Added `document-work/SKILL.md`, moved in unchanged from `~/.claude/skills/document-work` (which is now a symlink into this repo, same pattern as `scribe-mode`). Cut and verified `document-work-v1.0.0` — no changes needed to `.github/workflows/release.yml` or `scripts/release.sh`, confirming the multi-skill-repo design (tag name → skill name derivation) scales to a second skill as intended. This resolves the "to revisit if a second skill is added" note in the decision record.
- Files/systems affected: This repo (`document-work/` folder, new release). Local machine: `~/.claude/skills/document-work` converted from a real directory to a symlink.
- Dependencies added/removed: None.
- Surprises for future maintainers: None — release process worked exactly as designed on the first try.

## 2026-07-21 — Initial repo scaffold, scribe-mode v1.0.0 release, Code symlink

- What changed: Created the repo from scratch — `scribe-mode/SKILL.md` (moved in from an ad hoc local folder, content unchanged), `.github/workflows/release.yml` (tag-triggered ZIP build + GitHub Release), `scripts/release.sh` (tag+push helper with validation), `README.md` (install/update instructions for both Claude Code and claude.ai). Cut and verified the first release, `scribe-mode-v1.0.0` — confirmed the published ZIP has the correct single-top-level-folder structure claude.ai's uploader requires. Symlinked `~/.claude/skills/scribe-mode` → `~/Documents/LLM Skills/scribe-mode` so Claude Code runs the live repo copy.
- Files/systems affected: New repo `GoodOLMC/llm-skills` (public, pushed to GitHub). Local machine: `~/.claude/skills/scribe-mode` symlink added (was previously empty/unset).
- Dependencies added/removed: None (uses `zip`, `gh` CLI, and `softprops/action-gh-release@v2` in CI — no other tooling).
- Surprises for future maintainers:
  - `anthropic-skills:scribe-mode` is a separate, pre-existing plugin-bundled skill in this Claude Code environment with an identical description to this repo's `scribe-mode` — not related to this repo, and not installed via the normal `~/.claude/plugins` mechanism (confirmed absent from `installed_plugins.json`). When a local skill and a plugin skill share a base name, the local one appears to shadow the plugin one in the available-skills list.
  - Claude Code picked up the newly-symlinked skill *mid-session*, without a restart — don't assume a new session is required after adding a skill.
  - claude.ai's Customize → Skills has no sync/webhook path back to this repo — updating the uploaded skill is always a manual download-then-reupload, confirmed to be a platform limitation rather than something this repo's design missed.
