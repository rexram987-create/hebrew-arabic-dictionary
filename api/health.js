import { neon } from "@neondatabase/serverless";
export default async function handler(req, res) {
  res.setHeader("Cache-Control", "no-store");
  if (req.method !== "GET") return res.status(405).json({ error: "Method not allowed" });
  const connectionString = process.env.DATABASE_URL || process.env.POSTGRES_URL || process.env.STORAGE_URL;
  if (!connectionString) return res.status(503).json({ ok: false, service: "hebrew-arabic-dictionary", database: "not-configured" });
  try {
    const sql = neon(connectionString);
    const [counts] = await sql`
      SELECT (SELECT COUNT(*)::int FROM dictionary_entries) AS entries,
             (SELECT COUNT(*)::int FROM arabic_forms) AS forms,
             (SELECT COUNT(*)::int FROM dictionary_sources) AS sources
    `;
    return res.status(200).json({ ok: true, service: "hebrew-arabic-dictionary", database: "connected", ...counts });
  } catch (error) {
    console.error("Dictionary database health check failed", error);
    return res.status(503).json({ ok: false, service: "hebrew-arabic-dictionary", database: "unavailable" });
  }
}
