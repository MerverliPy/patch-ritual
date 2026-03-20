#!/usr/bin/env bash
set -euo pipefail

echo "## STALE REFERENCE SCAN"
for term in "PROJECT.md" "COMPACT_CONTEXT.md" "infra/" "phase-progress.md" "PRD.md"; do
  echo
  echo "# $term"
  grep -Rni --include='*.md' --include='*.json' "$term" . 2>/dev/null || true
done
