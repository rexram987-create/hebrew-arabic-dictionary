-- Phase 2: original, manually authored starter vocabulary.
-- Run in Neon SQL Editor; safe to run again.
-- This is not an import from Madrasa or any third-party dictionary.
BEGIN;
INSERT INTO dictionary_entries(entry_key,hebrew,hebrew_search,review_status)
VALUES
('he-shemesh','שמש','שמש','unreviewed'),
('he-yareach','ירח','ירח','unreviewed'),
('he-lechem','לחם','לחם','unreviewed'),
('he-kafe','קפה','קפה','unreviewed'),
('he-tea','תה','תה','unreviewed'),
('he-sefer','ספר','ספר','unreviewed'),
('he-delet','דלת','דלת','unreviewed'),
('he-rechov','רחוב','רחוב','unreviewed'),
('he-beit-sefer','בית ספר','בית ספר','unreviewed'),
('he-mechonit','מכונית','מכונית','unreviewed'),
('he-boker','בוקר','בוקר','unreviewed'),
('he-layla','לילה','לילה','unreviewed')
ON CONFLICT(entry_key) DO NOTHING;

INSERT INTO arabic_forms(entry_id,dialect,arabic_vocalized,arabic_search,hebrew_transliteration)
SELECT e.id,v.dialect,v.vocalized,v.search,v.transliteration
FROM (VALUES
('he-shemesh','msa','شَمْس','شمس','שַמְס'),
('he-shemesh','palestinian','شَمْس','شمس','שַמְס'),
('he-yareach','msa','قَمَر','قمر','קַמַר'),
('he-yareach','palestinian','قَمَر','قمر','אַמַר'),
('he-lechem','msa','خُبْز','خبز','חֻ׳בְּז'),
('he-lechem','palestinian','خُبْز','خبز','חֻ׳בְּז'),
('he-kafe','msa','قَهْوَة','قهوة','קַהְוַה'),
('he-kafe','palestinian','قَهْوِة','قهوة','אַהְוֶה'),
('he-tea','msa','شَاي','شاي','שַאי'),
('he-tea','palestinian','شَاي','شاي','שַאי'),
('he-sefer','msa','كِتَاب','كتاب','כִּתַאבּ'),
('he-sefer','palestinian','كْتَاب','كتاب','כְּתַאבּ'),
('he-delet','msa','بَاب','باب','בַּאבּ'),
('he-delet','palestinian','بَاب','باب','בַּאבּ'),
('he-rechov','msa','شَارِع','شارع','שַארִע'),
('he-rechov','palestinian','شَارِع','شارع','שַארֶע'),
('he-beit-sefer','msa','مَدْرَسَة','مدرسة','מַדְרַסַה'),
('he-beit-sefer','palestinian','مَدْرَسِة','مدرسة','מַדְרַסֶה'),
('he-mechonit','msa','سَيَّارَة','سيارة','סַיַּארַה'),
('he-mechonit','palestinian','سَيَّارَة','سيارة','סַיַּארַה'),
('he-boker','msa','صَبَاح','صباح','צַבַּאח'),
('he-boker','palestinian','صُبْح','صبح','צֻבְּח'),
('he-layla','msa','لَيْل','ليل','לַיְל'),
('he-layla','palestinian','لَيْل','ليل','לֵיל')
) AS v(entry_key,dialect,vocalized,search,transliteration)
JOIN dictionary_entries e ON e.entry_key=v.entry_key
ON CONFLICT(entry_id,dialect,arabic_vocalized) DO NOTHING;

INSERT INTO entry_sources(entry_id,source_id)
SELECT e.id,s.id FROM dictionary_entries e CROSS JOIN dictionary_sources s
WHERE e.entry_key IN (
'he-shemesh','he-yareach','he-lechem','he-kafe','he-tea','he-sefer',
'he-delet','he-rechov','he-beit-sefer','he-mechonit','he-boker','he-layla'
) AND s.code='manual-demo'
ON CONFLICT(entry_id,source_id) DO NOTHING;
COMMIT;

SELECT (SELECT COUNT(*) FROM dictionary_entries) AS entries,
       (SELECT COUNT(*) FROM arabic_forms) AS forms;
