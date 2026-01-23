# MixVault Frontend

This is a minimal Next.js frontend for the MixVault prototype.
It demonstrates how a client consumes the MixVault GraphQL API.

## Tech Stack
- Next.js (App Router)
- React
- TypeScript
- Fetch-based GraphQL client (no Apollo)

## Purpose
- Display a single DJ mix
- Render a structured tracklist with timestamps
- Demonstrate clean data flow from GraphQL → UI

## Pages
- `/mix/[id]`
  - Fetches a single mix by ID
  - Displays mix metadata (title, DJ, duration)
  - Renders ordered tracklist with timecodes

## Data Flow
1. Page calls GraphQL via a lightweight helper (`lib/graphql.ts`)
2. Backend resolves mix + mixTracks
3. UI renders structured data (no client-side mutations yet)

## Local Development

```bash
npm install
npm run dev
```

## Environment Variables

The frontend expects the GraphQL API URL to be defined in `.env.local`:
```bash
NEXT_PUBLIC_API_URL=http://localhost:3000/graphql
```
This file is not committed and must be created locally.