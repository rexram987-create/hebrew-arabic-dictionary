-- READ-ONLY pre-import inspection for 003_expansion_candidates.sql.
-- Safe to run in Neon SQL editor: SELECT statements only; no writes.
-- This does not approve 003 for import.
-- Check existing candidate keys, forms and their provenance before importing.
SELECT e.entry_key,e.hebrew,e.hebrew_search,e.review_status,
       COUNT(DISTINCT af.dialect) AS dialect_count,
       COUNT(af.id) AS form_count
FROM dictionary_entries e
LEFT JOIN arabic_forms af ON af.entry_id=e.id
WHERE e.entry_key LIKE 'he-expansion-%'
GROUP BY e.id,e.entry_key,e.hebrew,e.hebrew_search,e.review_status
ORDER BY e.entry_key;

-- An earlier version of 003 may have assigned inaccurate manual-demo provenance.
SELECT e.entry_key,e.hebrew,s.code,s.title,es.source_record_id,es.change_notes
FROM dictionary_entries e
JOIN entry_sources es ON es.entry_id=e.id
JOIN dictionary_sources s ON s.id=es.source_id
WHERE e.entry_key LIKE 'he-expansion-%'
ORDER BY e.entry_key,s.code;

-- Detect missing forms or multiple forms per dialect, if candidates already exist.
SELECT e.entry_key,e.hebrew,
       COUNT(af.id) FILTER (WHERE af.dialect='msa') AS msa_forms,
       COUNT(af.id) FILTER (WHERE af.dialect='palestinian') AS palestinian_forms
FROM dictionary_entries e
LEFT JOIN arabic_forms af ON af.entry_id=e.id
WHERE e.entry_key LIKE 'he-expansion-%'
GROUP BY e.id,e.entry_key,e.hebrew
HAVING COUNT(af.id) FILTER (WHERE af.dialect='msa') <> 1
    OR COUNT(af.id) FILTER (WHERE af.dialect='palestinian') <> 1
ORDER BY e.entry_key;

-- Confirm both Hebrew senses can be retrieved by an exact normalized search.
SELECT e.entry_key,e.hebrew,e.hebrew_search,e.notes,
       af.dialect,af.arabic_vocalized,af.hebrew_transliteration
FROM dictionary_entries e
LEFT JOIN arabic_forms af ON af.entry_id=e.id
WHERE e.hebrew_search='אדמה'
ORDER BY e.entry_key,af.dialect;

-- Overall totals are informative only; they do not prove linguistic correctness.
SELECT (SELECT COUNT(*) FROM dictionary_entries) AS total_entries,
       (SELECT COUNT(*) FROM arabic_forms) AS total_forms,
       (SELECT COUNT(*) FROM dictionary_entries
        WHERE entry_key LIKE 'he-expansion-%') AS expansion_entries,
       (SELECT COUNT(*) FROM dictionary_entries
        WHERE entry_key LIKE 'he-expansion-%'
          AND review_status='reviewed') AS reviewed_expansion_entries;
