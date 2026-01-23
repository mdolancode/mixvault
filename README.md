# MixVault (Prototype)

MixVault is a prototype that models how a DJ uploads a finished
continuous mix and converts it into a structured, verified tracklist
with exact timing metadata.

Instead of treating a DJ mix as a single opaque audio file,
MixVault breaks it down into ordered tracks with start times,
durations, and attribution — making the mix explorable,
verifiable, and ready for downstream publishing workflows.

This project focuses on **domain modeling and API design** rather than
audio processing or real platform integrations.

---

## Why MixVault Exists

DJ mixes are central to electronic music culture, yet most platforms
treat them as unstructured audio with little visibility into
track attribution, timing, or rights.

MixVault explores what a **first-class mix data model** could look like:
- Explicit track ordering
- Precise timestamps
- Validation against a known promo pool
- Clear separation between submission and publishing

---

## Scope & Constraints

### In Scope
- Modeling real DJ mix workflows
- Enforcing track ordering and timing constraints
- Validating mixes against an approved track catalog
- Exposing clean GraphQL APIs for frontend consumption

### Explicitly Out of Scope
- Audio processing or waveform analysis
- Fingerprinting / Content ID
- Real Spotify / Apple Music delivery
- Royalty calculations or payouts

Publishing and verification are **simulated** to keep focus on core logic.

---

## Core Workflow

1. DJ creates a mix (metadata + duration)
2. DJ builds a tracklist using approved promo tracks only
3. Each track is assigned a position and start time
4. System validates ordering, timing, and duration bounds
5. Mix is marked ready for publishing (mocked)

---

## Tech Stack

### Backend
- Rails API
- PostgreSQL (Dockerized)
- GraphQL (graphql-ruby)
- Strong domain validation at the model layer

### Frontend
- Next.js (App Router)
- React + TypeScript
- Minimal UI focused on consuming GraphQL data

---

## Domain Model

- **Label**
- **Track** (belongs to Label)
- **Mix**
- **MixTrack** (join model with position & timing)

Key design choice:
> Timing and ordering rules live in the domain layer,
> not in the frontend.

---

## Domain Logic Implemented

- Enforced track ordering by position
- Start/end time validation between adjacent tracks
- Prevention of duplicate tracks in a mix
- Mix duration bounds enforced
- GraphQL mutations:
  - `createMix`
  - `addTrackToMix`
  - `updateTrackInMix`
  - `removeTrackFromMix`
- All logic validated via GraphiQL and frontend queries

---

## Known Gaps (Intentional)

These are **deliberately omitted** to keep the prototype focused:

- Automatic position re-normalization after deletions
- Cascading time recalculation on reorder
- Authentication / authorization

These would be natural next steps in a production system.

---

## Project Status

The backend domain model and API surface are complete enough
to support a real frontend and demonstrate production-style thinking.
The frontend is intentionally small and focused on API consumption.