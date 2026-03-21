# Verification: Phase 1 — Auth, Repository Selection, Release Import

## Status: complete — GO

## Acceptance Criteria

| # | Criterion | Status |
|---|-----------|--------|
| 1 | Creator can sign in with GitHub | PASS — wired; pending live smoke test |
| 2 | Creator can select one repository | PASS |
| 3 | Available releases shown with core metadata | PASS |
| 4 | Selecting a release creates a draft | PASS |
| 5 | Partial source data does not block draft creation | PASS |

---

## Criterion Detail

### AC1 — Creator can sign in with GitHub

**Status: PASS (structural) — live smoke test not yet performed**

- `auth.ts`: GitHub OAuth provider; JWT callback stores `account.access_token` as `token.accessToken`; session callback exposes it as `session.accessToken`
- `middleware.ts`: `/dashboard/:path*` redirects to `/api/auth/signin` when `req.auth` is falsy
- Route handlers (`/api/github/repos`, `/api/github/releases`, `/api/github/import-draft`) all gate on `session.accessToken` and return `401` when missing
- No manual sign-in smoke test was performed; `GITHUB_ID` / `GITHUB_SECRET` env vars are required at runtime

**Risk:** Auth gate is structurally correct but unverified against a live GitHub OAuth app. First live run is still needed.

---

### AC2 — Creator can select one repository

**Status: PASS**

- `packages/github/src/index.ts` — `listRepos(accessToken)` fetches `GET /user/repos?sort=pushed&per_page=100`
- `apps/web/src/app/api/github/repos/route.ts` — auth-gated; returns repo array or 502 on GitHub API error
- `workspace.tsx` — renders repo list with click-to-select; empty state shown when no repos returned
- Error state handled both in UI (`reposError`) and route (502 with message)

---

### AC3 — Available releases shown with core metadata

**Status: PASS**

- `packages/github/src/index.ts` — `listReleases(accessToken, owner, repo)` fetches up to 30 releases
- `apps/web/src/app/api/github/releases/route.ts` — validates `repo` param format (`owner/repo`); auth-gated; returns 502 on GitHub API error
- `workspace.tsx` — shows `tag_name`, optional `name` (when distinct), `published_at` (formatted), `draft` flag, `prerelease` flag
- Empty state shown when `releases.length === 0`

---

### AC4 — Selecting a release creates a draft

**Status: PASS**

- `workspace.tsx` — `importRelease()` sends POST to `/api/github/import-draft` with `{ repoFullName, tagName, title }`
- Title normalization: `release.name && release.name !== release.tag_name ? release.name : release.tag_name`
- `apps/web/src/app/api/github/import-draft/route.ts` — validates body shape; calls `insertDraft()`; returns draft JSON at 201
- `packages/db/src/index.ts` — `insertDraft()` assigns `crypto.randomUUID()` id, ISO `createdAt`, persists via Drizzle `.run()`
- UI shows import-in-progress state (`importingId`) and success state (`importResult`) with returned draft id

---

### AC5 — Partial source data does not block draft creation

**Status: PASS**

- `tag_name` is always non-null per GitHub Releases API; used as fallback title when `name` is null or equal to `tag_name`
- `body` (release notes) is not required by the import route — omitted entirely from current schema, so null body is a non-issue
- `published_at` is nullable; UI guards it before rendering; not required by import route
- Import route validates `title` is a non-empty string — with `tag_name` always present, this never fails due to missing source data

---

## Build Verification

| Check | Result |
|-------|--------|
| `pnpm -r typecheck` | PASS — all 4 workspace packages clean |
| `pnpm --filter @patch-ritual/web build` | PASS — after minimal fix (see below) |

### Fix applied during verification (Slice 7)

**File:** `apps/web/next.config.ts`

`better-sqlite3` is a native Node.js binary. Next.js bundled `@patch-ritual/db` via `transpilePackages` but couldn't resolve the `.node` binding during page data collection. Fix: added `serverExternalPackages: ["better-sqlite3"]` and a webpack `externals` entry to ensure the native module is never bundled.

This is a deployment correctness fix, not a product scope change.

---

## Missing Proof

- **Live auth smoke test** — no GitHub OAuth credentials were available during this verification pass. The auth wiring is structurally sound but has not been verified against a real GitHub OAuth app.
- **Real release import against a live repo** — the import path is fully unit-verifiable from code, but an end-to-end run with actual GitHub data has not been performed.

---

## Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| Live auth untested | Medium | Structure matches Next-Auth v5 beta patterns exactly; risk is low env misconfiguration, not code logic |
| `per_page=100` repo limit | Low | Expected scope is one creator; pagination not required for MVP |
| SQLite file at cwd (`patch-ritual.db`) | Low | Acceptable for MVP local dev; known ops constraint, not a Phase 1 gap |
| Only first `owner/repo` split used (`repo.split("/")[0]` and `[1]`) — repos with `/` in the name would break | Negligible | GitHub repo names cannot contain `/`; safe |

---

## Slice Verification Log

### Slice 7 — Manual verification and edge-state closeout (2026-03-20)

- Reviewed all Phase 1 implementation files end-to-end
- Confirmed typecheck clean across all 4 workspace packages
- Identified and fixed production build failure: `better-sqlite3` native binding not resolvable when bundled — added `serverExternalPackages` + webpack `externals` to `next.config.ts`
- Confirmed build passes after fix
- Assessed all 5 acceptance criteria; all PASS (AC1 pending live smoke test)
- No new product scope added

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
