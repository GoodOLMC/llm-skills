## 2026-07-21 — Repo structure, versioning, and release automation for distributing Claude skills

**Decision:** One multi-skill git repo (`GoodOLMC/llm-skills`, public), each skill in its own top-level folder (e.g. `scribe-mode/SKILL.md`). Versions live only in git tags, scoped per-skill: `<skill>-vX.Y.Z`. A GitHub Actions workflow (`.github/workflows/release.yml`), triggered on tag push, zips just that skill's folder and attaches it to a GitHub Release. `SKILL.md` frontmatter carries no version field.

**Alternatives considered:**
- Single-skill-per-repo — rejected: would repeat this entire scaffold (workflow, README, release script) for every future skill.
- Version number embedded in `SKILL.md` frontmatter — rejected per explicit constraint: it can drift from the actual released artifact, and git tags already serve as an unambiguous, tamper-evident version record.
- Local-only release script (no CI) producing the ZIP by hand — rejected in favor of GitHub Actions: removes the one manual step that's easy to get subtly wrong (correct top-level-folder ZIP structure), and works identically regardless of which machine/session cuts the release.

**Why this won:** Matches the two real distribution targets exactly — Claude Code wants a folder it can symlink/clone, claude.ai's uploader wants a folder-containing ZIP for one specific skill (not the whole repo, not a bare file). Tag-per-skill naming (`scribe-mode-v1.0.0`) lets skills release independently without version-number collisions across the repo. The GH Actions workflow derives skill name + version by splitting the tag on `-v`, validates the target folder exists, and fails loudly if not — see `.github/workflows/release.yml`.

**Tradeoffs accepted:**
- Getting a new edit into claude.ai is inherently a manual pull (download release ZIP → Customize → Skills → upload) — there is no push/webhook path from GitHub to claude.ai's skill store. Confirmed this is a platform gap, not a solvable step; mitigated with GitHub's native Watch → Releases-only notification rather than custom tooling, since the repo has one maintainer.
- `scripts/release.sh` intentionally does *not* poll the Actions run to completion or print the final Release URL — user (Mike) declined that addition ("not worried about me"), preferring to check manually if needed.
- Claude Code's local copy tracks whatever's on disk live (via symlink `~/.claude/skills/scribe-mode` → `scribe-mode/`), which means Code is always running the latest *committed-or-not* edit, not a specific tagged release. Documented in README as: pin to a tag with `git checkout <skill>-vX.Y.Z` if reproducibility matters more than always-latest.

**To revisit if:**
- Anthropic ships an API/webhook for updating an uploaded claude.ai skill programmatically — would remove the manual re-upload step entirely.
- A second skill is added — validates the multi-skill-repo and per-skill-tag design actually scales as intended (no changes to workflow logic anticipated, since it's already parameterized on the tag's skill-name segment).
- Mike ever wants a teammate/other consumer of this repo — the "no notification of new releases" tradeoff would need revisiting, since GitHub Watch only pages the person watching, not automatically everyone who's ever installed a skill from here.
