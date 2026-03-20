# REQUIREMENTS.md

## Goals
- Prove the creator-to-audience ritual loop
- Keep the MVP fast enough for real release behavior
- Make the output feel branded and memorable without overbuilding the system
- Keep implementation easy to resume in fresh Claude Code contexts

## Non-Goals
- multi-project administration
- team workflows
- multiple ritual formats
- real-time launch events
- enterprise account management

## Core Constraints
- one creator
- one repository
- one release
- one ritual format
- one public ritual page
- lightweight audience response
- manual creator review before publish
- short consumption time
- fast creator workflow

## Requirement Map

### R1 Authentication
Creator signs in with GitHub.

### R2 Repository Context
Creator selects one repository.

### R3 Release Discovery
Creator can view and select releases.

### R4 Release Import
System imports available release metadata and summaries into a draft.

### R5 Creator Framing
Creator adds title, why-it-matters, optional note, theme, optional cover image.

### R6 Ritual Generation
System generates:
- opening hook
- key changes
- closing prompt

### R7 Creator Review
Creator previews and edits draft.

### R8 Publishing
Creator publishes to a public URL and can republish after edits.

### R9 Audience Experience
Audience consumes the ritual on desktop and mobile web.

### R10 Reactions
Audience leaves lightweight reactions.

### R11 Comments
Audience leaves a simple comment.

### R12 Analytics
Creator sees views, reactions, comments, and a basic engagement signal.

### R13 Workflow Quality
Typical flow from release selection to publish stays under 5 minutes.

## Deferred Work
- creator archive
- better social cards
- saved creator defaults
- voice note input
- scheduled publish
- richer analytics
- extra themes
- richer media moments

## Definition of Done for MVP
- creator can sign in with GitHub and select a repository
- creator can import a release draft
- creator can add framing inputs
- system can generate a fixed-format ritual draft
- creator can edit, preview, and publish
- audience can open, react, and comment
- creator can see basic metrics
- publish workflow stays constrained and fast
