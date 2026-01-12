# MixVault API – Local Development

This document is for running the MixVault Rails API locally during development.

---

## Prerequisites

- Docker Desktop (running)
- Ruby (managed via rbenv)
- Bundler installed
- Node is NOT required for the API

---

## First-time setup

From `backend/mixvault_api`:

```bash
bundle install
docker compose up -d
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```
## Daily Development
```bash
docker compose up -d
docker ps # sanity check
bin/rails s
```
Then open
GraphiQL: http://localhost:3000/graphiql

## Database Access (Docker)
``` bash
docker exec -it mixvault_db psql -U postgres -d mixvault_development
```
``` sql
\dt         # list tables
\d tracks   # describe table
\q          # exit
```

## Common Issues
```bash
ActiveRecord::ConnectionNotEstablished
connection to server at 127.0.0.1:5432 failed
```
Run
```bash
docker compose up -d
```

## Stop Services
```bash
Ctrl + C   # stop Rails
docker compose down
```

## Mental Model

MixVault follows a clean, layered architecture:

Database → Models → GraphQL → Client

### 1. Database (PostgreSQL)
The database stores the source of truth.

Core tables:
- labels
- tracks
- mixes
- mix_tracks (join table)

Relationships:
- A Label has many Tracks
- A Track belongs to one Label
- A Mix has many Tracks through MixTracks
- MixTrack stores timing metadata (position, start_seconds, etc.)

---

### 2. Rails Models (Domain Layer)
Rails models map directly to database tables and express business rules.

Examples:
- `Track` enforces label ownership
- `MixTrack` enforces ordering and timing
- Validations live here (presence, uniqueness, constraints)

This layer answers:
> “Is this data valid and meaningful?”

---

### 3. GraphQL Types (API Layer)
GraphQL types define **what data is exposed**, not how it’s stored.

Examples:
- `MixType` exposes tracks, duration, formatted timecodes
- `MixTrackType` exposes timing-derived fields
- Computed fields live here (e.g. `duration`, `startTimecode`)

GraphQL:
- Does NOT replace models
- Reads from models
- Shapes data for the client

This layer answers:
> “What does the client need, and in what shape?”

---

### 4. Client (Future: Next.js / Mobile)
The client never talks to the database directly.

It:
- Queries GraphQL
- Receives already-shaped data
- Does not compute business rules

This mirrors iOS architecture:
- Core Data → Models → Codable → SwiftUI

## Troubleshooting Decision Tree

Use this flow when something breaks.

---

### ❌ Rails won’t start / GraphQL errors immediately
**Check:**
```bash
docker ps
```

### ❌ mixvault_db missing → run
``` bash
docker compose up -d
```

### ❌ ActiveRecord::ConnectionNotEstablished
**Cause: Postgres not running or not reachable**
**Fix:**
``` bash
docker compose up -d
docker ps
```

### ❌ GraphQL field doesn’t exist
**Ask:**
	1.	Is the field defined in the GraphQL Type?
	2.	Is the file saved?
	3.	Was Rails restarted?

**If added a new field:**
``` bash
Ctrl + C
bin/rails s
```

### ❌ “undefined method field” or validates errors
**Cause:**
	•	Code written outside a class
	•	Missing class definition
	•	Wrong file location

**Fix:**
	•	Ensure GraphQL files look like:

``` ruby
module Types
  class SomethingType < Types::BaseObject
    field :example, String, null: false
  end
end
```
	•	Ensure models inherit from ApplicationRecord

### ❌ Data exists but doesn’t show in GraphQL

**Check:**
	•	Is the association defined in the model?
	•	Is the association exposed in the GraphQL type?
	•	Is the field name camelCase in GraphQL?

**Example:**
	•	Rails: start_seconds
	•	GraphQL: startSeconds

### ❌ Weird behavior after changes
**Default fix:**
``` bash
Ctrl + C
bin/rails s
```

**If still broken:**
``` bash
docker compose down
docker compose up -d
bin/rails s
```

### ❌ Unsure if database structure is correct
**Inspect directly:**
``` bash
docker exec -it mixvault_db psql -U postgres -d mixvault_development
```

**Then:**
``` sql
\dt
\d mix_tracks
```