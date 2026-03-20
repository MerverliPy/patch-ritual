#!/usr/bin/env bash
set -euo pipefail

for f in \
  STATE.md \
  PHASE_HANDOFF.md \
  docs/verification/phase-01-auth-release-import.md
do
  echo
  echo "## FILE: $f"
  echo '```'
  sed -n '1,240p' "$f"
  echo '```'
done
