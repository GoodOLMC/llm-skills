# Changes

## 2026-07-21 — Initial repo scaffold, scribe-mode v1.0.0 release, Code symlink

- What changed: Created the repo from scratch — `scribe-mode/SKILL.md` (moved in from an ad hoc local folder, content unchanged), `.github/workflows/release.yml` (tag-triggered ZIP build + GitHub Release), `scripts/release.sh` (tag+push helper with validation), `README.md` (install/update instructions for both Claude Code and claude.ai). Cut and verified the first release, `scribe-mode-v1.0.0` — confirmed the published ZIP has the correct single-top-level-folder structure claude.ai's uploader requires. Symlinked `~/.claude/skills/scribe-mode` → `~/Documents/LLM Skills/scribe-mode` so Claude Code runs the live repo copy.
- Files/systems affected: New repo `GoodOLMC/llm-skills` (public, pushed to GitHub). Local machine: `~/.claude/skills/scribe-mode` symlink added (was previously empty/unset).
- Dependencies added/removed: None (uses `zip`, `gh` CLI, and `softprops/action-gh-release@v2` in CI — no other tooling).
- Surprises for future maintainers:
  - `anthropic-skills:scribe-mode` is a separate, pre-existing plugin-bundled skill in this Claude Code environment with an identical description to this repo's `scribe-mode` — not related to this repo, and not installed via the normal `~/.claude/plugins` mechanism (confirmed absent from `installed_plugins.json`). When a local skill and a plugin skill share a base name, the local one appears to shadow the plugin one in the available-skills list.
  - Claude Code picked up the newly-symlinked skill *mid-session*, without a restart — don't assume a new session is required after adding a skill.
  - claude.ai's Customize → Skills has no sync/webhook path back to this repo — updating the uploaded skill is always a manual download-then-reupload, confirmed to be a platform limitation rather than something this repo's design missed.
