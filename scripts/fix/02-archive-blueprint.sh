#!/usr/bin/env bash
set -euo pipefail

mkdir -p docs/archive
if [ -f REPO_BLUEPRINT.md ]; then
  mv REPO_BLUEPRINT.md docs/archive/REPO_BLUEPRINT.phase-0.md
  echo "Moved REPO_BLUEPRINT.md -> docs/archive/REPO_BLUEPRINT.phase-0.md"
else
  echo "REPO_BLUEPRINT.md not found"
fi
