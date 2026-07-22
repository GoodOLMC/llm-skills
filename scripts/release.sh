#!/usr/bin/env bash
# Cut a release for one skill: tag it and push, which triggers
# .github/workflows/release.yml to build the ZIP and publish it.
#
# Usage: scripts/release.sh <skill-folder> <version>
#   e.g. scripts/release.sh scribe-mode 1.0.0

set -euo pipefail

SKILL="${1:-}"
VERSION="${2:-}"

if [ -z "$SKILL" ] || [ -z "$VERSION" ]; then
  echo "Usage: $0 <skill-folder> <version>" >&2
  echo "  e.g. $0 scribe-mode 1.0.0" >&2
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ ! -d "$REPO_ROOT/$SKILL" ]; then
  echo "Error: no folder named '$SKILL' at repo root ($REPO_ROOT)" >&2
  exit 1
fi

if [ ! -f "$REPO_ROOT/$SKILL/SKILL.md" ]; then
  echo "Error: $SKILL/SKILL.md not found" >&2
  exit 1
fi

if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: version must look like X.Y.Z (got '$VERSION')" >&2
  exit 1
fi

TAG="${SKILL}-v${VERSION}"

if git -C "$REPO_ROOT" rev-parse "$TAG" >/dev/null 2>&1; then
  echo "Error: tag '$TAG' already exists" >&2
  exit 1
fi

if [ -n "$(git -C "$REPO_ROOT" status --porcelain)" ]; then
  echo "Error: working tree has uncommitted changes — commit or stash first" >&2
  exit 1
fi

git -C "$REPO_ROOT" tag "$TAG"
git -C "$REPO_ROOT" push origin "$TAG"

echo "Pushed tag $TAG — GitHub Actions will build the ZIP and publish the release."
echo "Watch it at: $(git -C "$REPO_ROOT" remote get-url origin | sed -E 's#git@github.com:#https://github.com/#; s#\.git$##')/actions"
