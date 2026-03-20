# STATE.md

## Current Phase
Phase 1 — Auth, Repository Selection, Release Import

## Current Status
Phase 1 in progress — Slice 5 (repository selection and release list UI) complete.

## Last Completed
- Phase 0: repo skeleton, typecheck clean
- Phase 1 Slice 1: `packages/domain/src/index.ts` exports Creator, Project, Release, SourceItem — workspace typecheck passes
- Phase 1 Slice 2: next-auth@beta installed, GitHub OAuth configured, route handler and middleware created, typecheck and build clean
- Phase 1 Slice 3: GitHub access token threaded through Auth.js callbacks; authenticated GitHub adapter added in `packages/github`
- Phase 1 Slice 4: `packages/db` now provides SQLite-backed draft persistence via Drizzle with a `drafts` table and typed `insertDraft(...)` helper
- Phase 1 Slice 5: `/dashboard` now shows repository selection and release listing via authenticated API routes and workspace UI; workspace typecheck passes

## Next High-Leverage Actions
1. Slice 6: normalize selected GitHub release and persist draft via `insertDraft(...)`
2. Slice 7: complete empty/error states and manual verification for Phase 1

## Open Decisions
- storage provider for cover media
- completion metric definition for analytics

## Blockers
- selected release is not yet normalized into a persisted draft
- Phase 1 acceptance criterion for draft creation is not yet complete

## Risks
- overbuilding beyond fixed ritual format
- adding background workers too early
- mixing planning detail into root files

## Update Rule
Refresh this file after any meaningful planning milestone, phase completion, or architecture decision.
