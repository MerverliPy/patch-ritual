#!/usr/bin/env bash
set -euo pipefail

git status --short
echo
git diff --stat
echo
git add .
git commit -m "phase 1 slice 5: add repository selection and release list UI"
git push origin HEAD
