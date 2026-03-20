#!/usr/bin/env bash
set -euo pipefail

mkdir -p docs/archive
if [ -f docs/ops/phase-progress.md ]; then
  mv docs/ops/phase-progress.md docs/archive/phase-progress.md
  echo "Moved docs/ops/phase-progress.md -> docs/archive/phase-progress.md"
else
  echo "docs/ops/phase-progress.md not found"
fi
