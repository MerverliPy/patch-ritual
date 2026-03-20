#!/usr/bin/env bash
set -euo pipefail

echo "## VERIFY pnpm"
pnpm --version

echo
echo "## VERIFY install state"
pnpm install

echo
echo "## CREATE OR SWITCH TO SLICE BRANCH"
git switch -c phase-01-slice-03-github-adapter 2>/dev/null || git switch phase-01-slice-03-github-adapter

echo
echo "Ready to implement Phase 1 Slice 3:"
echo "- wire GitHub access token through Auth.js callbacks in apps/web/auth.ts"
echo "- build packages/github adapter for authenticated repo and release fetch"
echo "- keep scope inside Phase 1 Wave 2"
