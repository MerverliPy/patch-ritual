#!/usr/bin/env bash
set -euo pipefail

echo "## CHANGED FILES"
git status --short

echo
echo "## DIFF STAT"
git diff --stat

echo
echo "## STATE SNAPSHOT"
sed -n '1,220p' STATE.md

echo
echo "## HANDOFF SNAPSHOT"
sed -n '1,260p' PHASE_HANDOFF.md

echo
echo "## VERIFICATION SNAPSHOT"
sed -n '1,260p' docs/verification/phase-01-auth-release-import.md
