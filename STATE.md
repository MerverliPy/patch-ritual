# STATE.md

## Current Phase
Phase 1 — Auth, Repository Selection, Release Import

## Current Status
Phase 1 in progress — Slice 4 (DB schema and draft persistence boundary) complete.

## Last Completed
- Phase 0: repo skeleton, typecheck clean
- Phase 1 Slice 1: `packages/domain/src/index.ts` exports Creator, Project, Release, SourceItem — workspace typecheck passes
- Phase 1 Slice 2: next-auth@beta installed, GitHub OAuth configured, route handler and middleware created, typecheck and build clean
- Phase 1 Slice 3: GitHub access token threaded through Auth.js callbacks; authenticated GitHub adapter added in `packages/github` with repo and release listing — typecheck and web build clean
- Phase 1 Slice 4: `packages/db` now provides SQLite-backed draft persistence via Drizzle with a `drafts` table and typed `insertDraft(...)` helper — workspace typecheck clean

## Next High-Leverage Actions
1. Slice 5: wire repository selection and release list into creator workspace UI
2. Slice 6: normalize selected GitHub release and persist draft via `insertDraft(...)`

## Open Decisions
- storage provider for cover media
- completion metric definition for analytics

## Blockers
- repository selection UI not yet wired
- release import flow not yet connected to persistence

## Risks
- overbuilding beyond fixed ritual format
- adding background workers too early
- mixing planning detail into root files

## Update Rule
Refresh this file after any meaningful planning milestone, phase completion, or architecture decision.
