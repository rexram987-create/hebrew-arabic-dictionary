-- Batch 2: 10 additional Hebrew entries, 20 Arabic forms. Use after batch 004.
-- First-pass Palestinian sense matches from user-supplied Maknuune v1.0.1 TSV.
-- Pronunciation and TTS must still be checked in the app. Regional forms vary.
-- The girl entry uses بنت, which can also mean daughter depending on context.
-- No existing entries are deleted. Run once on the intended Neon production branch.
BEGIN;
INSERT INTO dictionary_entries(entry_key,hebrew,hebrew_search,review_status)
VALUES
('he-expansion-04','אחות','אחות','unreviewed'),
('he-expansion-08','ילדה','ילדה','unreviewed'),
('he-expansion-09','איש','איש','unreviewed'),
('he-expansion-15','עין','עין','unreviewed'),
('he-expansion-20','שיער','שיער','unreviewed'),
('he-expansion-21','חתול','חתול','unreviewed'),
('he-expansion-24','דג','דג','unreviewed'),
('he-expansion-26','עץ','עץ','unreviewed'),
('he-expansion-27','פרח','פרח','unreviewed'),
('he-expansion-31','שמים','שמים','unreviewed')
ON CONFLICT(entry_key) DO NOTHING;

UPDATE dictionary_entries SET notes='ילדה במשמעות girl; בِنْت משמשת גם לבת של אדם.'
WHERE entry_key='he-expansion-08';

INSERT INTO arabic_forms(entry_id,dialect,arabic_vocalized,arabic_search,hebrew_transliteration)
SELECT e.id,v.dialect,v.vocalized,v.search,v.transliteration
FROM (VALUES
('he-expansion-04','msa','أُخْت','أخت','אֻח׳ת'),
('he-expansion-04','palestinian','أُخُت','أخت','אֻח׳ֻת'),
('he-expansion-08','msa','بِنْت','بنت','בִּנְת'),
('he-expansion-08','palestinian','بِنِت','بنت','בִּנִת'),
('he-expansion-09','msa','رَجُل','رجل','רַג׳ֻל'),
('he-expansion-09','palestinian','زَلَمِة','زلمة','זַלַמֶה'),
('he-expansion-15','msa','عَيْن','عين','עַיְן'),
('he-expansion-15','palestinian','عَين','عين','עֵין'),
('he-expansion-20','msa','شَعْر','شعر','שַעְר'),
('he-expansion-20','palestinian','شَعَر','شعر','שַעַר'),
('he-expansion-21','msa','قِطّ','قط','קִטּ'),
('he-expansion-21','palestinian','بِسّ','بس','בִּסּ'),
('he-expansion-24','msa','سَمَكَة','سمكة','סַמַכַּה'),
('he-expansion-24','palestinian','سَمَكِة','سمكة','סַמַכֶּה'),
('he-expansion-26','msa','شَجَرَة','شجرة','שַג׳ַרַה'),
('he-expansion-26','palestinian','شَجَرَة','شجرة','שַג׳ַרַה'),
('he-expansion-27','msa','زَهْرَة','زهرة','זַהְרַה'),
('he-expansion-27','palestinian','زَهْرَة','زهرة','זַהְרַה'),
('he-expansion-31','msa','سَمَاء','سماء','סַמַאא׳'),
('he-expansion-31','palestinian','سَمَا','سما','סַמַא')
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
('he-expansion-04','151'),
('he-expansion-08','2341'),
('he-expansion-09','13123'),
('he-expansion-15','22266'),
('he-expansion-20','16356'),
('he-expansion-21','1442'),
('he-expansion-24','14964'),
('he-expansion-26','15643'),
('he-expansion-27','13269'),
('he-expansion-31','15012')
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
