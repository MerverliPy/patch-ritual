#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-}"
if [ -z "$FILE" ]; then
  echo "Usage: ./scripts/debug/03-backup-settings-file.sh path/to/settings.json"
  exit 1
fi

cp "$FILE" "$FILE.bak.$(date +%Y%m%d-%H%M%S)"
echo "Backed up $FILE"
