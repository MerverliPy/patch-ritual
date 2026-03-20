#!/usr/bin/env bash
set -euo pipefail

echo "## REPO"
echo "pwd: $(pwd)"
echo "branch: $(git branch --show-current 2>/dev/null || true)"
echo

echo "## GIT STATUS"
git status --short || true
echo

echo "## PACKAGE SCRIPTS"
node - <<'JS'
const fs = require('fs');
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
console.log('packageManager:', pkg.packageManager || '(none)');
for (const [k,v] of Object.entries(pkg.scripts || {})) {
  console.log(`${k}: ${v}`);
}
JS
echo

echo "## STATE SNAPSHOT"
awk '
  /^## Current Phase/ {show=1}
  /^## Open Decisions/ {show=0}
  show {print}
' STATE.md
echo

echo "## HANDOFF SNAPSHOT"
awk '
  /^## Resume From/ {show=1}
  /^## Files To Read First/ {show=0}
  show {print}
' PHASE_HANDOFF.md
echo

echo "## ACTIVE PHASE PLAN"
sed -n '1,220p' phases/phase-01-auth-release-import/PLAN.md
