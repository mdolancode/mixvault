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

## Status
Early exploration / learning project.
