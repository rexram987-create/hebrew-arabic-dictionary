# Hebrew–Arabic Dictionary Engine

A Hebrew–Arabic dictionary prototype for Vercel and Neon PostgreSQL. Supports Modern Standard Arabic and Palestinian Arabic with vowel marks and Hebrew transliteration.

## Current state
The search and health APIs now query the Neon database, not the local JSON sample. The initial schema contains four manually authored demo entries. Kaikki/Curras have not been imported. This is not yet an installable PWA, and speech synthesis has not been added.

## Setup
1. Run `database/001_initial_schema.sql` in the Neon SQL editor (already completed for the initial database).
2. Connect the Neon integration to the Vercel project, and ensure a server-side `DATABASE_URL`, `POSTGRES_URL` or `STORAGE_URL` variable exists for Production and Preview. Do not expose its value in client code or GitHub.
3. Redeploy after changing environment variables.

## API
- `GET /api/health` — checks the database and returns entry/form/source counts.
- `GET /api/search?q=שלום` — searches Hebrew and Arabic stored normalized forms, ignoring query vowel marks.
- `GET /` — a minimal test interface, not the final PWA.

## Local checks
`npm install && npm test` (Node.js 22+). Use `vercel dev` for local HTTP routes.

**Excluded:** Madrasah dictionary (at the owner's request). Qabas is not included. Do not assume external sources provide Hebrew translations or complete Palestinian vowel marks.
