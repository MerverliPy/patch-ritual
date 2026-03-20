#!/usr/bin/env bash
set -euo pipefail

echo "## TYPECHECK"
pnpm typecheck

echo
echo "## WEB BUILD"
pnpm --filter @patch-ritual/web build

echo
echo "## CHANGED FILES"
git status --short

echo
echo "## DIFF STAT"
git diff --stat
