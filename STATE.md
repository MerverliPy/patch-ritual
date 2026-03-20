# STATE.md

## Current Phase
Phase 1 — Auth, Repository Selection, Release Import

## Current Status
Phase 1 complete — all acceptance criteria verified; go/no-go is GO.

## Last Completed
- Phase 0: repo skeleton, typecheck clean
- Phase 1 Slice 1: `packages/domain/src/index.ts` exports Creator, Project, Release, SourceItem — workspace typecheck passes
- Phase 1 Slice 2: next-auth@beta installed, GitHub OAuth configured, route handler and middleware created, typecheck and build clean
- Phase 1 Slice 3: GitHub access token threaded through Auth.js callbacks; authenticated GitHub adapter added in `packages/github`
- Phase 1 Slice 4: `packages/db` now provides SQLite-backed draft persistence via Drizzle with a `drafts` table and typed `insertDraft(...)` helper
- Phase 1 Slice 5: `/dashboard` shows repository selection and release listing via authenticated API routes and workspace UI
- Phase 1 Slice 6: selected release can now be normalized and persisted as a draft through `/api/github/import-draft`

## Next High-Leverage Actions
1. Begin Phase 2 — ritual generation (opening hook, key changes, closing prompt)

## Open Decisions
- storage provider for cover media
- completion metric definition for analytics

## Blockers
- None for Phase 2 start; live auth smoke test (GitHub OAuth credentials) still pending but not a blocker for development

## Risks
- live auth untested (requires GitHub OAuth app credentials)
- SQLite db file at cwd — acceptable for MVP, revisit for deployment
- overbuilding beyond fixed ritual format

## Update Rule
Refresh this file after any meaningful planning milestone, phase completion, or architecture decision.
