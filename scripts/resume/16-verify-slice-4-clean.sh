#!/usr/bin/env bash
set -euo pipefail

echo "## pnpm version"
pnpm --version

echo
echo "## workspace typecheck"
pnpm -r typecheck

echo
echo "## repo status"
git status --short

echo
echo "## diff stat"
git diff --stat
