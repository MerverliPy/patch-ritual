#!/usr/bin/env bash
set -euo pipefail

git status --short
echo
git diff --stat
echo
git add .
git commit -m "phase 1 slice 4: add draft persistence boundary in packages/db"
git push origin HEAD
