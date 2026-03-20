#!/usr/bin/env bash
set -euo pipefail

cat <<'OUT'
## Slice 3 Target

Build the GitHub integration adapter in packages/github.

### Do first
1. Inspect apps/web/auth.ts
2. Add JWT/session callback handling so the GitHub access token is available to server-side code
3. Keep auth provider as GitHub OAuth only

### Then build in packages/github
4. Add minimal authenticated GitHub client
5. Add function to list repos for the authenticated user
6. Add function to list releases for a selected repo
7. Keep return shapes small and aligned with Phase 1 requirements

### Do not do yet
- no worker
- no queue
- no extra integrations
- no ritual generation
- no publishing flow
- no analytics work

### Definition of progress for this slice
- authenticated GitHub API calls are possible
- repo list fetch works
- release list fetch works
- typecheck passes
- web build passes
OUT
