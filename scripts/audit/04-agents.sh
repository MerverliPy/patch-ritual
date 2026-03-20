#!/usr/bin/env bash
set -euo pipefail

find .claude/agents -type f 2>/dev/null | sort | while read -r f; do
  echo
  echo "## FILE: $f"
  echo '```md'
  cat "$f"
  echo '```'
done
