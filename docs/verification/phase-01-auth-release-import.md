# Verification: Phase 1 — Auth, Repository Selection, Release Import

## Status: in progress

## Acceptance Criteria

| # | Criterion | Status |
|---|-----------|--------|
| 1 | Creator can sign in with GitHub | wired — pending manual smoke test |
| 2 | Creator can select one repository | complete at UI level |
| 3 | Available releases shown with core metadata | complete at UI level |
| 4 | Selecting a release creates a draft | not started |
| 5 | Partial source data does not block draft creation | persistence boundary in place; import path not wired |

## Slice Verification Log

### Slice 5 — Repository selection + release list UI (2026-03-20)
- Files:
  - `packages/github/src/index.ts`
  - `apps/web/auth.ts`
  - dashboard UI files
  - GitHub API route files
  - `apps/web/tsconfig.json`
- Added:
  - authenticated repo listing endpoint
  - authenticated release listing endpoint
  - dashboard workspace UI for repo and release selection
  - empty/error states
- Checks:
  - workspace typecheck — passed clean
- Notes:
  - creator can now browse repos and releases
  - selecting a release does not yet create a persisted draft

### Slice 4 — DB schema + draft persistence boundary (2026-03-20)
- Files: `packages/db/package.json`, `packages/db/src/schema.ts`, `packages/db/src/client.ts`, `packages/db/src/index.ts`, root `package.json`
- Persistence:
  - Drizzle ORM
  - SQLite via `better-sqlite3`
  - one `drafts` table
  - typed `insertDraft(...)` helper
- Checks:
  - `pnpm -r typecheck` — passed clean
- Notes:
  - persistence boundary is ready

### Slice 3 — GitHub integration adapter (2026-03-20)
- Files: `apps/web/auth.ts`, `packages/github/src/index.ts`
- Auth.js:
  - JWT callback persists `account.access_token` into `token.accessToken`
  - session callback exposes `session.accessToken`
- GitHub adapter:
  - `listRepos(accessToken)`
  - `listReleases(accessToken, repoFullName)`
- Checks:
  - `pnpm typecheck` — passed clean
  - `pnpm --filter @patch-ritual/web build` — passed clean

### Slice 2 — GitHub auth wiring (2026-03-20)
- Files: `apps/web/auth.ts`, `apps/web/src/app/api/auth/[...nextauth]/route.ts`, `apps/web/middleware.ts`
- Packages: `next-auth@5.0.0-beta.30` (Auth.js v5)
- Config: GitHub OAuth provider only; JWT session strategy; `/dashboard/*` protected
- Env: `.env.example` at repo root
- Check: `pnpm typecheck` — passed clean; `pnpm --filter @patch-ritual/web build` — passed clean

### Slice 1 — Domain types (2026-03-20)
- File: `packages/domain/src/index.ts`
- Exports: Creator, Project, Release, SourceItem
- Check: `pnpm -r typecheck` — passed clean

## Remaining Slices
6. Release import: normalize → persist draft
7. Empty/error states + manual verification
