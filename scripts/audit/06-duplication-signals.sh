#!/usr/bin/env bash
set -euo pipefail

FILES=(
  "CLAUDE.md"
  "PRD.md"
  "REQUIREMENTS.md"
  "ROADMAP.md"
  "STATE.md"
  "PHASE_HANDOFF.md"
  "REPO_BLUEPRINT.md"
  "docs/decisions/decision-log.md"
  "docs/ops/known-issues.md"
  "docs/ops/phase-progress.md"
)

echo "## HEADINGS BY FILE"
for f in "${FILES[@]}"; do
  if [ -f "$f" ]; then
    echo
    echo "# $f"
    grep -nE '^(#|##|###) ' "$f" || true
  fi
done

echo
echo "## KEYWORD OCCURRENCE COUNTS"
for kw in "current phase" "next steps" "blockers" "verification" "architecture" "requirements" "roadmap" "handoff"; do
  echo
  echo "# keyword: $kw"
  grep -Rni --include='*.md' "$kw" \
    CLAUDE.md PRD.md REQUIREMENTS.md ROADMAP.md STATE.md PHASE_HANDOFF.md REPO_BLUEPRINT.md docs phases 2>/dev/null || true
done
