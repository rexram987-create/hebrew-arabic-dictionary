-- DRY RUN: all changes are rolled back. Run as ONE query, ideally on a staging branch.
-- DO NOT run 003 directly on main: it commits. This is a technical test, not linguistic approval.
-- If SQL fails, run ROLLBACK; separately to clear the session.

-- Phase 3: 35 additional common-word candidates (16 existing + 35 = 51 if starter scripts applied).
-- Original draft entries. Palestinian forms and Hebrew transliterations REQUIRE linguistic review;
-- Palestinian urban variants are provisional; local pronunciations differ (especially qaf).
-- Arabic fish is singular سمكة, not mass-noun سمك. Keep review_status='unreviewed'.
-- Maknuune v1.0.1 verified row IDs: sister 151, son 2425, girl 2341,
-- man 13123, hair 16356, fish 14964, tree 15643, flower 13269,
-- cat 1442, horse 6229, sea 812.
-- Rain: source ID 30854 مَطَرَة is glossed rain; ID 30855 is water_bottle.
-- Source ID 30853 مَطَر is glossed airport;airfield (likely homograph
-- or source error); do not cite it as confirmation of the rain sense.
-- User-preferred Palestinian مَطَر is retained provisionally pending
-- a separate dialect-specific source check; MSA مَطَر is standard rain.
-- Maknuune ID 15638 شِتَا is winter; ID 15637 شِتَاء is winter;rain.
-- بنت can mean both daughter and girl; source row 2341 explicitly glosses girl.
-- Some urban Palestinian pronunciations have final -e for feminine ta marbuta.
-- Palestinian feminine endings follow individual source entries: fish سَمَكِة (-e),
-- tree شَجَرَة (-a), flower زَهْرَة (-a). Do not generalize endings.
-- IMPORTANT: WHERE NOT EXISTS prevents updating existing dialect rows. If a previous
-- version was imported, review and migrate existing rows separately; do not rerun
-- this file expecting earlier forms to be corrected.
-- CAPHI++ cross-check: friend ID 17472 s. aa 7 i b (Hebrew i, not e);
-- eye ID 22266 3 ee n (Hebrew ey, not ay). Maknuune uses عَين
-- as CODA orthography while CAPHI++ encodes the spoken vowel.
-- Madrasah cross-check: ear وِدِن / וִדֵן (body-part list); mouth تم / תֻםّ
-- (word list). Heart قَلْب = לב (body-part list); Madrasah writes קַלְבּ,
-- while earlier draft אַלְבּ is a regional urban pronunciation. Friend
-- صَاحْبِة / צַאחְבֵּה is attested in Madrasah as female friend.
-- Rain مَطَر / מַטַר is directly attested in Madrasah; شِتَى is ALSO
-- glossed rain there (winter-derived), contrary to our earlier blanket
-- exclusion; retain مَطَر as the basic translation.
-- Source comparisons are first-pass only: other forms and meanings remain unreviewed.
-- Sense split: existing אדמה means land/ground (أرض); new אדמה (חומר הקרקע)
-- means soil (تربة), Maknuune v1.0.1 ID 2912. Hebrew search אדמה returns both.
-- Source provenance is preliminary: only mapped Palestinian senses have row IDs.
-- Do NOT execute in Neon until all entries and transliterations are reviewed.
BEGIN;
INSERT INTO dictionary_entries(entry_key,hebrew,hebrew_search,review_status)
VALUES
('he-expansion-01','אמא','אמא','unreviewed'),
('he-expansion-02','אבא','אבא','unreviewed'),
('he-expansion-03','אח','אח','unreviewed'),
('he-expansion-04','אחות','אחות','unreviewed'),
('he-expansion-05','בן','בן','unreviewed'),
('he-expansion-06','בת','בת','unreviewed'),
('he-expansion-07','ילד','ילד','unreviewed'),
('he-expansion-08','ילדה','ילדה','unreviewed'),
('he-expansion-09','איש','איש','unreviewed'),
('he-expansion-10','אישה','אישה','unreviewed'),
('he-expansion-11','חבר','חבר','unreviewed'),
('he-expansion-12','חברה','חברה','unreviewed'),
('he-expansion-13','יד','יד','unreviewed'),
('he-expansion-14','ראש','ראש','unreviewed'),
('he-expansion-15','עין','עין','unreviewed'),
('he-expansion-16','אוזן','אוזן','unreviewed'),
('he-expansion-17','פה','פה','unreviewed'),
('he-expansion-18','לב','לב','unreviewed'),
('he-expansion-19','שן','שן','unreviewed'),
('he-expansion-20','שיער','שיער','unreviewed'),
('he-expansion-21','חתול','חתול','unreviewed'),
('he-expansion-22','כלב','כלב','unreviewed'),
('he-expansion-23','סוס','סוס','unreviewed'),
('he-expansion-24','דג','דג','unreviewed'),
('he-expansion-25','ציפור','ציפור','unreviewed'),
('he-expansion-26','עץ','עץ','unreviewed'),
('he-expansion-27','פרח','פרח','unreviewed'),
('he-expansion-28','ים','ים','unreviewed'),
('he-expansion-29','הר','הר','unreviewed'),
('he-expansion-30','אדמה','אדמה','unreviewed'),
('he-expansion-31','שמים','שמים','unreviewed'),
('he-expansion-32','גשם','גשם','unreviewed'),
('he-expansion-33','רוח','רוח','unreviewed'),
('he-expansion-34','אש','אש','unreviewed'),
('he-expansion-35','אדמה (חומר הקרקע)','אדמה','unreviewed')
ON CONFLICT(entry_key) DO NOTHING;

UPDATE dictionary_entries SET notes='ארץ, שטח או קרקע; לא חומר האדמה שבעציץ.'
WHERE entry_key='he-expansion-30';
UPDATE dictionary_entries SET notes='חומר הקרקע, למשל אדמה בעציץ; לא ארץ או שטח.'
WHERE entry_key='he-expansion-35';
UPDATE dictionary_entries SET notes='בת במשמעות daughter; בِنْت משמשת גם לילדה. יש לברר משמעות לפי הקשר.'
WHERE entry_key='he-expansion-06';
UPDATE dictionary_entries SET notes='ילדה במשמעות girl; בِنْت משמשת גם לבת של אדם.'
WHERE entry_key='he-expansion-08';
UPDATE dictionary_entries SET notes='חבר במשמעות ידיד, לא חבר בארגון או בן זוג בהכרח.'
WHERE entry_key='he-expansion-11';
UPDATE dictionary_entries SET notes='חברה במשמעות ידידה, לא חברה עסקית; אין להסיק בהכרח בת זוג.'
WHERE entry_key='he-expansion-12';
UPDATE dictionary_entries SET notes='ציפור במובן כללי; לא בהכרח דרור או ציפור שיר קטנה.'
WHERE entry_key='he-expansion-25';
UPDATE dictionary_entries SET notes='הגיית ق משתנה בין ניבים; התעתיק אַלְבּ משקף הגייה עירונית, בעוד קַלְבּ משקף qaf כ־ק.'
WHERE entry_key='he-expansion-18';

INSERT INTO arabic_forms(entry_id,dialect,arabic_vocalized,arabic_search,hebrew_transliteration)
SELECT e.id,v.dialect,v.vocalized,v.search,v.transliteration
FROM (VALUES
('he-expansion-01','msa','أُمّ','أم','אֻםּ'),
('he-expansion-01','palestinian','إِمّ','إم','אִםּ'),
('he-expansion-02','msa','أَب','أب','אַבּ'),
('he-expansion-02','palestinian','أَب','أب','אַבּ'),
('he-expansion-03','msa','أَخ','أخ','אַח׳'),
('he-expansion-03','palestinian','أَخ','أخ','אַח׳'),
('he-expansion-04','msa','أُخْت','أخت','אֻח׳ת'),
('he-expansion-04','palestinian','أُخُت','أخت','אֻח׳ֻת'),
('he-expansion-05','msa','اِبْن','ابن','אִבְּן'),
('he-expansion-05','palestinian','اِبِن','ابن','אִבִּן'),
('he-expansion-06','msa','بِنْت','بنت','בִּנְת'),
('he-expansion-06','palestinian','بِنِت','بنت','בִּנִת'),
('he-expansion-07','msa','وَلَد','ولد','וַלַד'),
('he-expansion-07','palestinian','وَلَد','ولد','וַלַד'),
('he-expansion-08','msa','بِنْت','بنت','בִּנְת'),
('he-expansion-08','palestinian','بِنِت','بنت','בִּנִת'),
('he-expansion-09','msa','رَجُل','رجل','רַג׳ֻל'),
('he-expansion-09','palestinian','زَلَمِة','زلمة','זַלַמֶה'),
('he-expansion-10','msa','اِمْرَأَة','امرأة','אִמְרַאַה'),
('he-expansion-10','palestinian','مَرَة','مرة','מַרַה'),
('he-expansion-11','msa','صَدِيق','صديق','צַדִיק'),
('he-expansion-11','palestinian','صَاحِب','صاحب','צַאחִבּ'),
('he-expansion-12','msa','صَدِيقَة','صديقة','צַדִיקַה'),
('he-expansion-12','palestinian','صَاحْبِة','صاحبة','צַאחְבֶּה'),
('he-expansion-13','msa','يَد','يد','יַד'),
('he-expansion-13','palestinian','إِيد','إيد','אִיד'),
('he-expansion-14','msa','رَأْس','رأس','רַאְס'),
('he-expansion-14','palestinian','رَاس','راس','רַאס'),
('he-expansion-15','msa','عَيْن','عين','עַיְן'),
('he-expansion-15','palestinian','عَين','عين','עֵין'),
('he-expansion-16','msa','أُذُن','أذن','אֻד׳ֻן'),
('he-expansion-16','palestinian','وِدِن','ودن','וִדֵן'),
('he-expansion-17','msa','فَم','فم','פַם'),
('he-expansion-17','palestinian','تُمّ','تم','תֻםּ'),
('he-expansion-18','msa','قَلْب','قلب','קַלְבּ'),
('he-expansion-18','palestinian','قَلْب','قلب','אַלְבּ'),
('he-expansion-19','msa','سِنّ','سن','סִןּ'),
('he-expansion-19','palestinian','سِنّ','سن','סִןּ'),
('he-expansion-20','msa','شَعْر','شعر','שַעְר'),
('he-expansion-20','palestinian','شَعَر','شعر','שַעַר'),
('he-expansion-21','msa','قِطّ','قط','קִטּ'),
('he-expansion-21','palestinian','بِسّ','بس','בִּסּ'),
('he-expansion-22','msa','كَلْب','كلب','כַּלְבּ'),
('he-expansion-22','palestinian','كَلْب','كلب','כַּלְבּ'),
('he-expansion-23','msa','حِصَان','حصان','חִצַאן'),
('he-expansion-23','palestinian','حْصَان','حصان','חְצַאן'),
('he-expansion-24','msa','سَمَكَة','سمكة','סַמַכַּה'),
('he-expansion-24','palestinian','سَمَكِة','سمكة','סַמַכֶּה'),
('he-expansion-25','msa','طَائِر','طائر','טַאאִר'),
('he-expansion-25','palestinian','طَيْر','طير','טֵיר'),
('he-expansion-26','msa','شَجَرَة','شجرة','שַג׳ַרַה'),
('he-expansion-26','palestinian','شَجَرَة','شجرة','שַג׳ַרַה'),
('he-expansion-27','msa','زَهْرَة','زهرة','זַהְרַה'),
('he-expansion-27','palestinian','زَهْرَة','زهرة','זַהְרַה'),
('he-expansion-28','msa','بَحْر','بحر','בַּחְר'),
('he-expansion-28','palestinian','بَحَر','بحر','בַּחַר'),
('he-expansion-29','msa','جَبَل','جبل','ג׳ַבַּל'),
('he-expansion-29','palestinian','جَبَل','جبل','ג׳ַבַּל'),
('he-expansion-30','msa','أَرْض','أرض','אַרְדֿ'),
('he-expansion-30','palestinian','أَرْض','أرض','אַרְדֿ'),
('he-expansion-31','msa','سَمَاء','سماء','סַמַאא׳'),
('he-expansion-31','palestinian','سَمَا','سما','סַמַא'),
('he-expansion-32','msa','مَطَر','مطر','מַטַר'),
('he-expansion-32','palestinian','مَطَر','مطر','מַטַר'),
('he-expansion-33','msa','رِيح','ريح','רִיח'),
('he-expansion-33','palestinian','رِيح','ريح','רִיח'),
('he-expansion-34','msa','نَار','نار','נַאר'),
('he-expansion-34','palestinian','نَار','نار','נַאר'),
('he-expansion-35','msa','تُرْبَة','تربة','תֻרְבַּה'),
('he-expansion-35','palestinian','تُرْبِة','تربة','תֻרְבֶּה')
) AS v(entry_key,dialect,vocalized,search,transliteration)
JOIN dictionary_entries e ON e.entry_key=v.entry_key
WHERE NOT EXISTS (
 SELECT 1 FROM arabic_forms af WHERE af.entry_id=e.id AND af.dialect=v.dialect
)
ON CONFLICT(entry_id,dialect,arabic_vocalized) DO NOTHING;

-- The expansion is not a set of original demonstration entries. Do not attach
-- manual-demo to these entries. Source links below record ONLY first-pass matched
-- Maknuune senses; they do not imply that Hebrew translations, MSA forms, regional
-- pronunciation or the full entry have been independently reviewed.
INSERT INTO dictionary_sources(code,title,homepage,license_id,license_url,attribution)
VALUES ('maknuune-v1.0.1','Maknuune Palestinian Arabic Lexicon v1.0.1',
        'https://sites.google.com/nyu.edu/palestine-lexicon/download',
        'CC BY-SA 4.0','https://creativecommons.org/licenses/by-sa/4.0/',
        'Maknuune Palestinian Arabic Lexicon, v1.0.1; source-row sense checks, adapted with Hebrew glosses')
ON CONFLICT(code) DO NOTHING;

INSERT INTO entry_sources(entry_id,source_id,source_record_id,change_notes)
SELECT e.id,src.id,v.record_id,
       'First-pass Palestinian lemma/gloss comparison only; see database/003_review_audit.md'
FROM (VALUES
 ('he-expansion-01','529'),('he-expansion-02','11'),
 ('he-expansion-03','162'),('he-expansion-04','151'),
 ('he-expansion-05','2425'),('he-expansion-07','36009'),
 ('he-expansion-08','2341'),('he-expansion-09','13123'),
 ('he-expansion-10','30368'),('he-expansion-11','17472'),
 ('he-expansion-13','36210'),('he-expansion-14','10896'),
 ('he-expansion-15','22266'),('he-expansion-19','15087'),
 ('he-expansion-20','16356'),('he-expansion-21','1442'),
 ('he-expansion-22','28213'),('he-expansion-23','6229'),
 ('he-expansion-24','14964'),('he-expansion-25','19781'),
 ('he-expansion-26','15643'),('he-expansion-27','13269'),
 ('he-expansion-28','812'),('he-expansion-29','3559'),
 ('he-expansion-30','255'),('he-expansion-31','15012'),
 ('he-expansion-33','12519'),('he-expansion-34','33728'),
 ('he-expansion-35','2912')
) AS v(entry_key,record_id)
JOIN dictionary_entries e ON e.entry_key=v.entry_key
JOIN dictionary_sources src ON src.code='maknuune-v1.0.1'
ON CONFLICT(entry_id,source_id) DO UPDATE SET
 source_record_id=EXCLUDED.source_record_id,
 change_notes=EXCLUDED.change_notes;
-- Verify expansion within transaction, then undo everything.
SELECT COUNT(*) AS proposed_entries_present FROM dictionary_entries WHERE entry_key LIKE 'he-expansion-%';
SELECT af.dialect,COUNT(*) AS proposed_forms_present FROM arabic_forms af JOIN dictionary_entries e ON e.id=af.entry_id WHERE e.entry_key LIKE 'he-expansion-%' GROUP BY af.dialect ORDER BY af.dialect;
SELECT e.entry_key,e.hebrew,e.review_status,COUNT(af.id) AS form_count,COUNT(DISTINCT af.dialect) AS dialect_count FROM dictionary_entries e LEFT JOIN arabic_forms af ON af.entry_id=e.id WHERE e.entry_key LIKE 'he-expansion-%' GROUP BY e.id,e.entry_key,e.hebrew,e.review_status ORDER BY e.entry_key;
SELECT (SELECT COUNT(*) FROM dictionary_entries) AS entries_during_test,(SELECT COUNT(*) FROM arabic_forms) AS forms_during_test,(SELECT COUNT(*) FROM dictionary_sources) AS sources_during_test;
ROLLBACK;
