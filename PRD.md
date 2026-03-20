# PRD.md

> Narrative product framing only. Default execution and planning should use `REQUIREMENTS.md`, `ROADMAP.md`, `STATE.md`, and the active phase plan. Read this file only when extra product context is needed.

## Product
Patch Ritual

## Summary
Patch Ritual is a GitHub-connected release publishing tool for solo indie creators. It transforms a shipped update into a short, branded, public release experience that fans can explore and react to.

## One-line description
Turn patch notes into a launch moment.

## Problem
Patch notes and release posts are usually flat, forgettable, and overly technical. Creators who ship often need a faster way to make each update feel memorable without turning release day into extra admin work.

## Primary User
Solo indie game creator with a small but engaged community.

## Primary Audience
Players, followers, or fans who want a fast and fun way to understand what changed.

## MVP Goal
Validate one loop:
ship update -> generate ritual -> publish -> share -> community reacts

## Core Value Proposition
Instead of posting static patch notes, creators publish a short interactive release moment that feels exciting, memorable, and shareable.

## Jobs To Be Done
When I ship an update, I want to:
- make it feel exciting
- show what changed in a way people remember
- keep my community engaged
- avoid writing dead-feeling patch notes from scratch

## In Scope
- GitHub sign-in
- select one repository
- import one release
- import release title, tag/version, publish date, notes, and available commit/PR summaries
- creator input:
  - ritual title
  - why-this-update-matters
  - optional creator note
  - theme selection
  - optional cover image
- fixed ritual format:
  - opening hook
  - key changes
  - closing prompt
- creator preview and edit before publish
- public ritual page at a shareable URL
- lightweight reactions
- simple comments / guestbook
- basic analytics:
  - views
  - reactions
  - comments
  - simple completion or reach signal
- ritual consumption target: 60 to 120 seconds
- creator workflow target: under 5 minutes from import to publish

## Explicitly Out of Scope
- live launch rooms
- Discord-native real-time launches
- Jira, Linear, Notion integrations
- team collaboration
- advanced moderation systems
- collectible systems
- quests, achievements, badges
- drag-and-drop ritual builders
- video generation
- template marketplace
- white-label enterprise features
- multi-language localization
- mobile app

## MVP UX Flow

### Creator Flow
1. Sign in with GitHub
2. Select one repository
3. Choose one release
4. Add title, why-it-matters, theme, optional creator note, optional cover image
5. Review generated ritual draft
6. Edit draft
7. Publish
8. Share
9. Review analytics

### Audience Flow
1. Open ritual URL
2. Experience opening hook
3. Read key changes
4. React and optionally comment
5. Leave understanding why the update matters

## Product Requirements

### Creator Authentication and Project Setup
- GitHub-only sign-in for MVP
- One active project context
- Clear empty states for no repositories or no releases

### Release Import
- Release data becomes a draft, never auto-publishes
- Partial import still works when source data is incomplete
- Imported material must be normalized into one release object

### Ritual Generation
- Audience-facing language, not commit-dump output
- Fixed structure only
- Human-editable before publish
- Short enough to fit the experience constraint

### Publishing
- Publish produces a public URL
- Republish updates the same URL
- Publish failure preserves draft

### Audience Engagement
- Reactions must be friction-light
- Comments must stay simple
- No deep discussion or social graph in MVP

### Analytics
- Surface whether using the ritual was worthwhile
- Keep metrics simple and tied to one ritual

## Non-Goals
- Build a generic CMS
- Build a social network
- Build a full storytelling engine
- Replace existing release management workflows

## Success Metrics

### Primary
- repeat publishing rate

### Secondary
- publish completion rate
- time from import to publish
- ritual view-to-reaction rate
- audience completion / scene reach
- creator share rate
- creator sentiment: "this feels better than patch notes"

## Failure Signals
- creators publish once and do not return
- flow takes too long
- rituals feel generic
- audience engagement is negligible
- creators still prefer plain release posts

## Recommended Technical Direction
- frontend + server app: Next.js + TypeScript
- relational data store for creators, releases, rituals, reactions, comments, analytics
- object storage for cover media
- server-side ritual generation in MVP
- add background job processing only if generation latency or asset handling requires it
- keep AI assistive and editable, never fully autonomous
