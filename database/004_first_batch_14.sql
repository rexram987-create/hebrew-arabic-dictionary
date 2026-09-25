-- First manageable batch: 14 entries, 28 forms. Existing 16 entries are not deleted.
-- These Palestinian headword senses have first-pass Maknuune v1.0.1 row matches.
-- Dialect/phonetic variants and all MSA vocalization have not undergone full audio review.
-- No bulk Maknuune import; only selected adapted entries. Attribution is retained.
-- Run ONLY on Neon main after confirming the selected branch. Backup branch remains untouched.
BEGIN;
INSERT INTO dictionary_entries(entry_key,hebrew,hebrew_search,review_status)
VALUES
('he-expansion-01','אמא','אמא','unreviewed'),
('he-expansion-02','אבא','אבא','unreviewed'),
('he-expansion-03','אח','אח','unreviewed'),
('he-expansion-05','בן','בן','unreviewed'),
('he-expansion-07','ילד','ילד','unreviewed'),
('he-expansion-13','יד','יד','unreviewed'),
('he-expansion-14','ראש','ראש','unreviewed'),
('he-expansion-19','שן','שן','unreviewed'),
('he-expansion-22','כלב','כלב','unreviewed'),
('he-expansion-23','סוס','סוס','unreviewed'),
('he-expansion-28','ים','ים','unreviewed'),
('he-expansion-29','הר','הר','unreviewed'),
('he-expansion-33','רוח','רוח','unreviewed'),
('he-expansion-34','אש','אש','unreviewed')
ON CONFLICT(entry_key) DO NOTHING;

INSERT INTO arabic_forms(entry_id,dialect,arabic_vocalized,arabic_search,hebrew_transliteration)
SELECT e.id,v.dialect,v.vocalized,v.search,v.transliteration
FROM (VALUES
('he-expansion-01','msa','أُمّ','أم','אֻםּ'),
('he-expansion-01','palestinian','إِمّ','إم','אִםּ'),
('he-expansion-02','msa','أَب','أب','אַבּ'),
('he-expansion-02','palestinian','أَب','أب','אַבּ'),
('he-expansion-03','msa','أَخ','أخ','אַח׳'),
('he-expansion-03','palestinian','أَخ','أخ','אַח׳'),
('he-expansion-05','msa','اِبْن','ابن','אִבְּן'),
('he-expansion-05','palestinian','اِبِن','ابن','אִבִּן'),
('he-expansion-07','msa','وَلَد','ولد','וַלַד'),
('he-expansion-07','palestinian','وَلَد','ولد','וַלַד'),
('he-expansion-13','msa','يَد','يد','יַד'),
('he-expansion-13','palestinian','إِيد','إيد','אִיד'),
('he-expansion-14','msa','رَأْس','رأس','רַאְס'),
('he-expansion-14','palestinian','رَاس','راس','רַאס'),
('he-expansion-19','msa','سِنّ','سن','סִןּ'),
('he-expansion-19','palestinian','سِنّ','سن','סִןּ'),
('he-expansion-22','msa','كَلْب','كلب','כַּלְבּ'),
('he-expansion-22','palestinian','كَلْب','كلب','כַּלְבּ'),
('he-expansion-23','msa','حِصَان','حصان','חִצַאן'),
('he-expansion-23','palestinian','حْصَان','حصان','חְצַאן'),
('he-expansion-28','msa','بَحْر','بحر','בַּחְר'),
('he-expansion-28','palestinian','بَحَر','بحر','בַּחַר'),
('he-expansion-29','msa','جَبَل','جبل','ג׳ַבַּל'),
('he-expansion-29','palestinian','جَبَل','جبل','ג׳ַבַּל'),
('he-expansion-33','msa','رِيح','ريح','רִיח'),
('he-expansion-33','palestinian','رِيح','ريح','רִיח'),
('he-expansion-34','msa','نَار','نار','נַאר'),
('he-expansion-34','palestinian','نَار','نار','נַאר')
) AS v(entry_key,dialect,vocalized,search,transliteration)
JOIN dictionary_entries e ON e.entry_key=v.entry_key
WHERE NOT EXISTS (
 SELECT 1 FROM arabic_forms af WHERE af.entry_id=e.id AND af.dialect=v.dialect
)
ON CONFLICT(entry_id,dialect,arabic_vocalized) DO NOTHING;

INSERT INTO dictionary_sources(code,title,homepage,license_id,license_url,attribution)
VALUES ('maknuune-v1.0.1','Maknuune Palestinian Arabic Lexicon v1.0.1',
'https://sites.google.com/nyu.edu/palestine-lexicon/download',
'CC BY-SA 4.0','https://creativecommons.org/licenses/by-sa/4.0/',
'Maknuune Palestinian Arabic Lexicon v1.0.1; selected source-row sense checks, adapted with Hebrew glosses')
ON CONFLICT(code) DO NOTHING;

INSERT INTO entry_sources(entry_id,source_id,source_record_id,change_notes)
SELECT e.id,src.id,v.record_id,
'First-pass Palestinian lemma/gloss match; MSA and audio pronunciation not source-verified'
FROM (VALUES
('he-expansion-01','529'),
('he-expansion-02','11'),
('he-expansion-03','162'),
('he-expansion-05','2425'),
('he-expansion-07','36009'),
('he-expansion-13','36210'),
('he-expansion-14','10896'),
('he-expansion-19','15087'),
('he-expansion-22','28213'),
('he-expansion-23','6229'),
('he-expansion-28','812'),
('he-expansion-29','3559'),
('he-expansion-33','12519'),
('he-expansion-34','33728')
) AS v(entry_key,record_id)
JOIN dictionary_entries e ON e.entry_key=v.entry_key
JOIN dictionary_sources src ON src.code='maknuune-v1.0.1'
ON CONFLICT(entry_id,source_id) DO UPDATE SET
source_record_id=EXCLUDED.source_record_id,
change_notes=EXCLUDED.change_notes;
COMMIT;
SELECT (SELECT COUNT(1) FROM dictionary_entries) AS total_words,
(SELECT COUNT(1) FROM arabic_forms) AS arabic_forms,
(SELECT COUNT(1) FROM dictionary_entries WHERE entry_key LIKE 'he-expansion-%') AS expansion_words;
