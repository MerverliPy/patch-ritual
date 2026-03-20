#!/usr/bin/env bash
set -euo pipefail

echo "## STATUS"
git status --short

echo
echo "## DIFF STAT"
git diff --stat

echo
git add .
git commit -m "phase 1: close release import loop and verify go/no-go"
git push origin HEAD
