#!/usr/bin/env bash
set -euo pipefail

echo "## HOT PATH FILE SIZES"
for f in CLAUDE.md REQUIREMENTS.md ROADMAP.md STATE.md PHASE_HANDOFF.md PRD.md; do
  if [ -f "$f" ]; then
    echo "$f | lines=$(wc -l < "$f" | tr -d ' ') | bytes=$(wc -c < "$f" | tr -d ' ')"
  fi
done

echo
echo "## ACTIVE STALE REFERENCE CHECK (excluding docs/archive)"
for term in "PROJECT.md" "COMPACT_CONTEXT.md" "REPO_BLUEPRINT" "phase-progress.md"; do
  echo
  echo "# $term"
  find . \
    -path './docs/archive' -prune -o \
    -path './.git' -prune -o \
    -type f \( -name '*.md' -o -name '*.json' \) -print0 \
    | xargs -0 grep -nH "$term" 2>/dev/null || true
done

echo
echo "## ACTIVE PRD READ-PATH CHECK"
for f in CLAUDE.md .claude/agents/phase-planner.md .claude/skills/phase-plan/SKILL.md; do
  if [ -f "$f" ]; then
    grep -nH 'PRD.md' "$f" || true
  fi
done

echo
echo "## GIT DIFF STAT"
git diff --stat || true
