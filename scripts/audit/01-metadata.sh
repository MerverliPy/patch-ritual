#!/usr/bin/env bash
set -euo pipefail

echo "## REPO METADATA"
echo "- cwd: $(pwd)"
echo "- date: $(date -Iseconds)"
echo

echo "## ROOT OPERATING FILES"
for f in CLAUDE.md PRD.md REQUIREMENTS.md ROADMAP.md STATE.md PHASE_HANDOFF.md README.md REPO_BLUEPRINT.md; do
  if [ -f "$f" ]; then
    lines=$(wc -l < "$f" | tr -d ' ')
    bytes=$(wc -c < "$f" | tr -d ' ')
    echo "$f | lines=$lines | bytes=$bytes"
  fi
done
echo

echo "## OPS FILES"
find docs -type f 2>/dev/null \
  \( -name 'decision-log.md' -o -name 'known-issues.md' -o -name 'phase-progress.md' \) \
  | sort | while read -r f; do
    lines=$(wc -l < "$f" | tr -d ' ')
    bytes=$(wc -c < "$f" | tr -d ' ')
    echo "$f | lines=$lines | bytes=$bytes"
  done
echo

echo "## PHASE PLANS"
find phases -type f -name 'PLAN.md' 2>/dev/null | sort | while read -r f; do
  lines=$(wc -l < "$f" | tr -d ' ')
  bytes=$(wc -c < "$f" | tr -d ' ')
  echo "$f | lines=$lines | bytes=$bytes"
done
echo

echo "## AGENTS"
find .claude/agents -type f 2>/dev/null | sort | while read -r f; do
  lines=$(wc -l < "$f" | tr -d ' ')
  bytes=$(wc -c < "$f" | tr -d ' ')
  echo "$f | lines=$lines | bytes=$bytes"
done
echo

echo "## SKILLS"
find .claude/skills -type f -name 'SKILL.md' 2>/dev/null | sort | while read -r f; do
  lines=$(wc -l < "$f" | tr -d ' ')
  bytes=$(wc -c < "$f" | tr -d ' ')
  echo "$f | lines=$lines | bytes=$bytes"
done
echo

echo "## SETTINGS"
find .claude -maxdepth 1 -type f 2>/dev/null | sort | while read -r f; do
  lines=$(wc -l < "$f" | tr -d ' ')
  bytes=$(wc -c < "$f" | tr -d ' ')
  echo "$f | lines=$lines | bytes=$bytes"
done
