# Hebrew–Arabic Dictionary Engine

A bilingual Hebrew–Arabic dictionary API prototype for Vercel. The goal is Modern Standard Arabic and Palestinian spoken Arabic, with vowel marks, Hebrew transliteration and source attribution.

## Current state
This is **only a four-entry, manually authored demo**, not the imported Kaikki/Curras database or a PWA. No external dictionary contents have been copied.

## API
- `GET /api/health` — prototype state and entry count.
- `GET /api/search?q=שלום` — Hebrew/Arabic substring search, ignoring Arabic vowel marks.
- `GET /` — a minimal API test interface, **not** the final PWA.

## Local checks
`node --test tests/*.test.js` (Node.js 22+). Use `vercel dev` for local HTTP routes.

## Planned architecture
1. Validate and download source snapshots separately; document each dataset license, edition, attribution and changes.
2. Normalize Hebrew/Arabic lemmas, sense IDs, dialect, vowel marks and transliteration; flag unverified or ambiguous results.
3. Import approved records to PostgreSQL (prefer Vercel Marketplace Neon), with license/source provenance per record.
4. Replace demo JSON queries with parameterized database queries. Keep DB credentials in Vercel environment variables.
5. Add Tatoeba sentence examples with per-example license and audio licensing checks.
6. Add speech synthesis in the PWA as a separate layer, with device voice/dialect limitations clearly labeled.

**Excluded:** Madrasah dictionary (at the owner's request). Qabas is not included.

Do not assume the imported datasets offer Hebrew translations or complete Palestinian vowel marks for all words.
