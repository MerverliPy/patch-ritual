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
  else
    echo
    echo "## FILE: $f"
    echo "[missing]"
  fi
}

show_file "CLAUDE.md"
show_file "STATE.md"
show_file "PHASE_HANDOFF.md"
show_file "phases/phase-01-auth-release-import/PLAN.md"
show_file "docs/verification/phase-01-auth-release-import.md"
show_file "packages/github/src/index.ts"
show_file "packages/db/src/index.ts"
show_file "packages/domain/src/index.ts"
