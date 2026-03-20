#!/usr/bin/env bash
set -euo pipefail

echo "## AVAILABLE PHASE PLANS"
find phases -type f -name 'PLAN.md' | sort
echo

ACTIVE_PLAN="$(find phases -type f -name 'PLAN.md' | sort | head -n 2 | tail -n 1)"

if [ -n "${ACTIVE_PLAN:-}" ] && [ -f "$ACTIVE_PLAN" ]; then
  echo "## FILE: $ACTIVE_PLAN"
  echo '```md'
  cat "$ACTIVE_PLAN"
  echo '```'
fi

echo
echo "## VERIFICATION DOCS"
find docs/verification -type f 2>/dev/null | sort | while read -r f; do
  echo
  echo "## FILE: $f"
  echo '```md'
  cat "$f"
  echo '```'
done
