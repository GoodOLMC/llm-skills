# LLM Skills

Personal Claude skills, versioned with git tags. Each skill lives in its own top-level folder and is released independently.

**Status:** `scribe-mode` and `document-work` are both released at `v1.0.0` and symlinked into Claude Code (`~/.claude/skills/<name>` → `<name>/`). Only `scribe-mode` has been uploaded to claude.ai so far. See [`docs/decisions/2026-07-21-skill-repo-versioning.md`](docs/decisions/2026-07-21-skill-repo-versioning.md) for why the repo is structured this way, and [`CHANGES.md`](CHANGES.md) for the history.

```
scribe-mode/
  SKILL.md
document-work/
  SKILL.md
```

## Install

### Claude Code

Clone the repo once, then symlink whichever skill(s) you want into `~/.claude/skills/`:

```bash
git clone https://github.com/GoodOLMC/llm-skills.git ~/skills/llm-skills
ln -s ~/skills/llm-skills/scribe-mode ~/.claude/skills/scribe-mode
ln -s ~/skills/llm-skills/document-work ~/.claude/skills/document-work
```

To update: `git pull` inside the cloned repo — the symlink picks up changes immediately, no relinking needed. This tracks `main`, not a specific tagged release; if you want to pin to a known-good version instead, `git checkout <skill>-vX.Y.Z` before symlinking (or copy the folder instead of symlinking, and re-copy on update).

### claude.ai (app / web)

1. Go to the [Releases page](https://github.com/GoodOLMC/llm-skills/releases) and download the ZIP for the skill + version you want (e.g. `scribe-mode-v1.0.0.zip`).
2. In claude.ai: **Customize → Skills → Upload skill**, and select the downloaded ZIP.
3. To update: download the newer release ZIP and upload it again — this replaces the previous version.

Don't upload `Code`'s "Download ZIP" from the green GitHub button — that wraps the whole repo in a `llm-skills-main` folder, which the uploader rejects. Always use a release ZIP from the Releases page; it's scoped to a single skill folder.

## Releasing a new version

Versions are git tags only — nothing in `SKILL.md` encodes a version number, so there's no file to keep in sync.

```bash
scripts/release.sh scribe-mode 1.1.0
```

This tags `scribe-mode-v1.1.0`, pushes it, and GitHub Actions ([.github/workflows/release.yml](.github/workflows/release.yml)) builds a ZIP containing just the `scribe-mode/` folder and attaches it to a new GitHub Release. No local build step, no manual zipping.

## Adding a new skill

Drop a new top-level folder with its own `SKILL.md` (e.g. `my-new-skill/SKILL.md`), commit it, then release it the same way: `scripts/release.sh my-new-skill 1.0.0`.
