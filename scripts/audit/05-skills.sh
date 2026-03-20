#!/usr/bin/env bash
set -euo pipefail

find .claude/skills -type f -name 'SKILL.md' 2>/dev/null | sort | while read -r f; do
  echo
  echo "## FILE: $f"
  echo '```md'
  cat "$f"
  echo '```'
done
