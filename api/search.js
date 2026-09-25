import { neon } from "@neondatabase/serverless";
import { normalize, formatResults } from "../lib/dictionary.js";

export default async function handler(req, res) {
  res.setHeader("Cache-Control", "public, max-age=0, s-maxage=60");
  if (req.method !== "GET") return res.status(405).json({ error: "Method not allowed" });
  const q = typeof req.query.q === "string" ? req.query.q.slice(0, 100) : "";
  const term = normalize(q);
  if (!term) return res.status(400).json({ error: "Missing query parameter q" });
  const connectionString = process.env.DATABASE_URL || process.env.POSTGRES_URL || process.env.STORAGE_URL;
  if (!connectionString) return res.status(503).json({ error: "Database connection is not configured", code: "DATABASE_NOT_CONFIGURED" });
  const limit = Math.min(Math.max(Number.parseInt(req.query.limit, 10) || 20, 1), 50);
  try {
    const sql = neon(connectionString);
    const rows = await sql`
      SELECT e.id, e.hebrew, e.part_of_speech, e.review_status,
             f.dialect, f.arabic_vocalized, f.hebrew_transliteration,
             f.notes AS form_notes
      FROM (
        SELECT e.id, e.hebrew, e.part_of_speech, e.review_status
        FROM dictionary_entries e
        WHERE strpos(e.hebrew_search, ${term}) > 0
           OR EXISTS (
             SELECT 1 FROM arabic_forms af
             WHERE af.entry_id = e.id AND strpos(af.arabic_search, ${term}) > 0
           )
        ORDER BY CASE WHEN e.hebrew_search = ${term} THEN 0 ELSE 1 END, e.id
        LIMIT ${limit}
      ) e
      LEFT JOIN arabic_forms f ON f.entry_id = e.id
      ORDER BY e.id, CASE f.dialect WHEN 'msa' THEN 0 ELSE 1 END, f.id
    `;
    return res.status(200).json({ query: q, results: formatResults(rows), sourceStatus: "neon-postgres" });
  } catch (error) {
    console.error("Dictionary database search failed", error);
    return res.status(503).json({ error: "Database search unavailable", code: "DATABASE_QUERY_FAILED" });
  }
}
