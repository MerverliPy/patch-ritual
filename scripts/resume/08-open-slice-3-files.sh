#!/usr/bin/env bash
set -euo pipefail

show_file () {
  local f="$1"
  if [ -f "$f" ]; then
    echo
    echo "## FILE: $f"
    echo '```'
    sed -n '1,240p' "$f"
    echo '```'
  fi
}

show_file "apps/web/auth.ts"
show_file "packages/github/src/index.ts"
show_file "packages/domain/src/index.ts"
show_file "docs/verification/phase-01-auth-release-import.md"
