# MixVault (Prototype)

MixVault is a small prototype that models how a DJ uploads a finished
continuous mix, builds a verified tracklist from a promo pool,
and submits it for distribution to streaming platforms.

This app does NOT integrate with real Spotify or Apple Music APIs.
Publishing is simulated.

## Goals
- Model real DJ mix workflows
- Enforce promo pool track eligibility
- Generate attribution reports
- Demonstrate Rails + GraphQL + React fundamentals

## Out of Scope
- Real audio processing
- Real platform delivery
- Fingerprinting / Content ID
- Real royalty accounting

## Core Workflow
1. DJ uploads a finished mix (URL + duration)
2. DJ builds a tracklist using promo pool tracks only
3. DJ submits mix
4. Admin verifies and publishes (mock)

## Tech
- Rails API
- GraphQL
- Postgres (Docker)
- Next.js frontend

## Project Status

MixVault backend foundation is in place.

### Implemented
- PostgreSQL database (Docker)
- Rails 8 API
- Core domain models:
  - Label
  - Track
  - Mix
  - MixTrack (join table)
- Proper relational modeling:
  - Labels → Tracks
  - Mixes ↔ Tracks (many-to-many)
- GraphQL API using graphql-ruby
- GraphQL types and root queries
- GraphiQL enabled for local development
- Seed data for local testing

### In Progress / Planned
- Track timing & timecode representation
- Computed GraphQL fields (duration formatting)
- Mutations (creating mixes, assigning tracks)
- Authentication & authorization

## Domain Logic Implemented
- MixTrack timing validation (start times enforced by position)
- Prevent duplicate tracks in a mix
- Enforce mix duration bounds
- GraphQL mutations:
  - createMix
  - addTrackToMix
  - updateTrackInMix
- All logic validated via GraphiQL

## Known Domain Gaps (Intentional)
- Track removal from a mix (`removeTrackFromMix`)
- Position re-normalization after removal
- Timing adjustments cascading after deletion or reorder
