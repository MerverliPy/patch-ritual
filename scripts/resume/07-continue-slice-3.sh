#!/usr/bin/env bash
set -euo pipefail

echo "## CURRENT TARGET"
echo "Phase 1 Slice 3 — GitHub integration adapter"
echo

echo "## FILES TO EDIT FIRST"
printf "%s\n" \
  "apps/web/auth.ts" \
  "packages/github/src/index.ts" \
  "packages/domain/src/index.ts"
echo

echo "## REQUIRED WORK"
cat <<'OUT'
1. In apps/web/auth.ts:
   - add jwt callback
   - copy account.access_token into the JWT on sign-in
   - expose the token to server-side session usage as needed

2. In packages/github/src/index.ts:
   - add a minimal authenticated GitHub API client
   - add function to list repos for the signed-in user
   - add function to list releases for one selected repo

3. In packages/domain/src/index.ts:
   - only add shared types if the adapter needs them

4. Keep scope out of:
   - persistence
   - UI
   - ritual generation
   - publishing
   - analytics
OUT

echo
echo "## SUCCESS CHECK FOR THIS SLICE"
cat <<'OUT'
- authenticated GitHub API calls are possible
- repo list fetch works
- release list fetch works
- pnpm typecheck passes
- pnpm --filter @patch-ritual/web build passes
OUT
