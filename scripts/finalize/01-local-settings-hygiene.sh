#!/usr/bin/env bash
set -euo pipefail

echo "## LOCAL SETTINGS HYGIENE"

touch .gitignore

if grep -qxF '.claude/settings.local.json' .gitignore; then
  echo "Already ignored: .claude/settings.local.json"
else
  echo '.claude/settings.local.json' >> .gitignore
  echo "Added to .gitignore: .claude/settings.local.json"
fi

echo
if git ls-files --error-unmatch .claude/settings.local.json >/dev/null 2>&1; then
  echo "WARNING: .claude/settings.local.json is tracked by git"
  echo "Run this if you want to stop tracking it:"
  echo "  git rm --cached .claude/settings.local.json"
else
  echo "OK: .claude/settings.local.json is not tracked by git"
fi
