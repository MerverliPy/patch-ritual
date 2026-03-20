# COMPACT_CONTEXT.md

Patch Ritual is a release experience platform for solo indie creators.

MVP loop:
GitHub sign-in -> select one repo -> select one release -> add vibe input -> generate ritual -> edit -> publish -> audience reacts -> creator reviews analytics.

MVP constraints:
- one creator
- one repo
- one release
- one ritual format
- GitHub only
- no live events
- no team features
- no extra integrations
- short ritual
- fast publish workflow

Fixed ritual structure:
1. opening hook
2. key changes
3. closing prompt

Repo operating model:
- compact `CLAUDE.md`
- file-based state
- phase plans under `phases/`
- thin orchestrator + few subagents
- skills for repeatable workflows
- verification files per phase

Default build posture:
- TypeScript-first
- Next.js app in `apps/web`
- shared packages only where they reduce coupling
- keep AI assistive and editable
- no worker until Phase 4 pressure proves the need
