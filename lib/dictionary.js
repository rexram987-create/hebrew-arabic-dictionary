const diacritics = /[\u064B-\u065F\u0670\u06D6-\u06ED]/g;
export function normalize(input = "") {
  return String(input).normalize("NFKC").toLowerCase()
    .replace(diacritics, "").replace(/[\u0591-\u05C7]/g, "")
    .replace(/\u0640/g, "").replace(/\s+/g, " ").trim();
}
export function escapeLike(input) {
  return input.replace(/[\\%_]/g, "\\$&");
}
export function formatResults(rows) {
  const entries = new Map();
  for (const row of rows) {
    if (!entries.has(row.id)) {
      entries.set(row.id, {
        id: row.id, hebrew: row.hebrew, part_of_speech: row.part_of_speech,
        review_status: row.review_status,
        arabic: { msa: null, palestinian: null },
        sources: []
      });
    }
    const entry = entries.get(row.id);
    if (row.dialect && !entry.arabic[row.dialect]) {
      entry.arabic[row.dialect] = {
        text: row.arabic_vocalized,
        transliteration_he: row.hebrew_transliteration,
        notes: row.form_notes
      };
    }
  }
  return [...entries.values()];
}
