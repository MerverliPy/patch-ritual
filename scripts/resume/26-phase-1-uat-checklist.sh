#!/usr/bin/env bash
cat <<'OUT'
## Phase 1 manual verification checklist

1. Sign in with GitHub
   - auth succeeds
   - /dashboard is reachable when signed in

2. Repository list
   - repositories load for signed-in user
   - empty state is reasonable if no repos are available
   - error state is visible if repo fetch fails

3. Release list
   - selecting a repo loads releases
   - releases show core metadata
   - empty state is reasonable if no releases exist
   - error state is visible if release fetch fails

4. Draft import
   - selecting a release and clicking Import succeeds
   - success UI shows returned draft id
   - repeated import behavior is understandable
   - invalid request path is rejected cleanly

5. Partial data / fallback checks
   - release with missing name still imports using tag_name fallback
   - missing or malformed body data is handled safely
   - missing session/token blocks import route cleanly

6. Narrow checks
   - pnpm -r typecheck
   - pnpm --filter @patch-ritual/web build

7. Verification output
   - mark each acceptance criterion pass/fail
   - record evidence
   - record defects or missing proof
   - decide go / no-go for Phase 1 completion
OUT
