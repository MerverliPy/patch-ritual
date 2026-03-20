#!/usr/bin/env bash
set -euo pipefail

HOOK_PATH="${1:-}"

if [ -z "$HOOK_PATH" ]; then
  echo "Usage: ./scripts/debug/02-open-hook-file.sh /path/to/hook-script"
  exit 1
fi

echo "## FILE: $HOOK_PATH"
echo '```'
sed -n '1,240p' "$HOOK_PATH"
echo '```'
