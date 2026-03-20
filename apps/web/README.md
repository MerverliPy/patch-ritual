# apps/web

Phase 0 bootstrap target:
- Next.js App Router
- TypeScript
- server-side rendering for creator and audience surfaces
- route groups for creator workspace and public ritual pages

Suggested internal layout:
- `app/(marketing)` for landing
- `app/(creator)` for workspace
- `app/r/[ritualSlug]` for public ritual pages
- `features/auth`
- `features/github`
- `features/releases`
- `features/rituals`
- `features/reactions`
- `features/comments`
- `features/analytics`
