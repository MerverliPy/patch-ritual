#!/usr/bin/env bash
set -euo pipefail

git switch -c phase-01-slice-03-github-adapter 2>/dev/null || git switch phase-01-slice-03-github-adapter

echo "## Branch"
git branch --show-current

echo
echo "## Status"
git status --short
