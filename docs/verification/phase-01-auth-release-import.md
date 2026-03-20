# Verification: Phase 1 — Auth, Repository Selection, Release Import

## Status: in progress

## Acceptance Criteria

| # | Criterion | Status |
|---|-----------|--------|
| 1 | Creator can sign in with GitHub | wired — pending manual smoke test |
| 2 | Creator can select one repository | complete |
| 3 | Available releases shown with core metadata | complete |
| 4 | Selecting a release creates a draft | complete |
| 5 | Partial source data does not block draft creation | pending manual edge verification |

## Slice Verification Log

### Slice 6 — Release import: normalize → persist draft (2026-03-20)
- Files:
  - `apps/web/src/app/api/github/import-draft/route.ts`
  - `apps/web/src/app/dashboard/workspace.tsx`
  - `apps/web/tsconfig.json`
  - `apps/web/next.config.ts`
- Added:
  - authenticated draft import route
  - minimal normalization using `release.name ?? release.tag_name`
  - persisted draft creation via `insertDraft(...)`
  - UI feedback for import-in-progress and import success
- Checks:
  - workspace typecheck — passed clean
- Notes:
  - creator can now import a selected release into persisted draft storage
  - manual smoke test and edge verification still needed

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

### Slice 4 — DB schema + draft persistence boundary (2026-03-20)
- Files: `packages/db/package.json`, `packages/db/src/schema.ts`, `packages/db/src/client.ts`, `packages/db/src/index.ts`, root `package.json`
- Persistence:
  - Drizzle ORM
  - SQLite via `better-sqlite3`
  - one `drafts` table
  - typed `insertDraft(...)` helper
- Checks:
  - `pnpm -r typecheck` — passed clean

### Slice 3 — GitHub integration adapter (2026-03-20)
- Files: `apps/web/auth.ts`, `packages/github/src/index.ts`
- GitHub adapter:
  - `listRepos(accessToken)`
  - `listReleases(accessToken, repoFullName)`
- Checks:
  - `pnpm typecheck` — passed clean
  - `pnpm --filter @patch-ritual/web build` — passed clean

### Slice 2 — GitHub auth wiring (2026-03-20)
- Files: `apps/web/auth.ts`, `apps/web/src/app/api/auth/[...nextauth]/route.ts`, `apps/web/middleware.ts`
- Config: GitHub OAuth provider only; JWT session strategy; `/dashboard/*` protected
- Checks:
  - `pnpm typecheck` — passed clean
  - `pnpm --filter @patch-ritual/web build` — passed clean

### Slice 1 — Domain types (2026-03-20)
- File: `packages/domain/src/index.ts`
- Exports: Creator, Project, Release, SourceItem
- Check: `pnpm -r typecheck` — passed clean

## Remaining Slices
7. Empty/error states + manual verification
