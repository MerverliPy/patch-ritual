#!/usr/bin/env bash
set -euo pipefail

git status --short
echo
git diff --stat
echo
git add .
git commit -m "phase 1 slice 6: import selected release into persisted draft"
git push origin HEAD
