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
bin/rails s
```
Then open
GraphiQL: http://localhost:3000/graphiql

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