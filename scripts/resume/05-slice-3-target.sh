#!/usr/bin/env bash
cat <<'OUT'
## Slice 3 target

Edit first:
- apps/web/auth.ts
- packages/github/src/index.ts
- packages/domain/src/index.ts (only if needed)

Do:
- thread GitHub access token through Auth.js callbacks
- add authenticated GitHub adapter
- add listRepos()
- add listReleases(owner, repo)

Do not do:
- persistence
- UI
- draft creation
- publishing
- analytics
- workers
- queues

Definition of done:
- authenticated GitHub API calls work
- repo list fetch works
- release list fetch works
- typecheck passes
- web build passes
OUT
