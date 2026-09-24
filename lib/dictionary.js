import entries from "../data/sample.json" with { type: "json" };

const diacritics = /[\u064B-\u065F\u0670\u06D6-\u06ED]/g;
export function normalize(input = "") {
  return String(input).normalize("NFKC").toLowerCase().replace(diacritics, "").replace(/[\u0591-\u05C7]/g, "").replace(/[\u0640]/g, "").replace(/\s+/g, " ").trim();
}
export function searchDictionary(q, limit = 20) {
  const term = normalize(q);
  if (!term) return [];
  return entries.filter(e => [e.hebrew, e.arabic?.msa?.text, e.arabic?.palestinian?.text].some(v => normalize(v).includes(term))).slice(0, Math.min(Math.max(Number(limit)||20,1),50));
}
export function statistics() { return {entries:entries.length, sources:["manual-demo"], stage:"prototype", importedExternalEntries:0}; }
