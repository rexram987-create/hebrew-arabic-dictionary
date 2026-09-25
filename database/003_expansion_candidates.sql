-- Phase 3: 34 additional common-word candidates (16 existing + 34 = 50 if starter scripts applied).
-- Original draft entries. Palestinian forms and Hebrew transliterations REQUIRE linguistic review;
-- Palestinian urban variants are provisional; local pronunciations differ (especially qaf).
-- Arabic fish is singular سمكة, not mass-noun سمك. Keep review_status='unreviewed'.
-- Execute in Neon SQL Editor only after reviewing the vocabulary. Idempotent inserts.
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
('he-expansion-04','msa','أُخْت','أخت','אֻח׳ת'),
('he-expansion-04','palestinian','أُخْت','أخت','אֻח׳ת'),
('he-expansion-05','msa','اِبْن','ابن','אִבְּן'),
('he-expansion-05','palestinian','اِبْن','ابن','אִבְּן'),
('he-expansion-06','msa','بِنْت','بنت','בִּנְת'),
('he-expansion-06','palestinian','بِنْت','بنت','בִּנְת'),
('he-expansion-07','msa','وَلَد','ولد','וַלַד'),
('he-expansion-07','palestinian','وَلَد','ولد','וַלַד'),
('he-expansion-08','msa','بِنْت','بنت','בִּנְת'),
('he-expansion-08','palestinian','بِنْت','بنت','בִּנְת'),
('he-expansion-09','msa','رَجُل','رجل','רַג׳ֻל'),
('he-expansion-09','palestinian','رَجُل','رجل','רַג׳ֻל'),
('he-expansion-10','msa','اِمْرَأَة','امرأة','אִמְרַאַה'),
('he-expansion-10','palestinian','اِمْرَأَة','امرأة','אִמְרַאַה'),
('he-expansion-11','msa','صَدِيق','صديق','צַדִיק'),
('he-expansion-11','palestinian','صَدِيق','صديق','צַדִיק'),
('he-expansion-12','msa','صَدِيقَة','صديقة','צַדִיקַה'),
('he-expansion-12','palestinian','صَدِيقَة','صديقة','צַדִיקַה'),
('he-expansion-13','msa','يَد','يد','יַד'),
('he-expansion-13','palestinian','إِيد','إيد','אִיד'),
('he-expansion-14','msa','رَأْس','رأس','רַאְס'),
('he-expansion-14','palestinian','رَاس','راس','רַאס'),
('he-expansion-15','msa','عَيْن','عين','עַיְן'),
('he-expansion-15','palestinian','عَيْن','عين','עַיְן'),
('he-expansion-16','msa','أُذُن','أذن','אֻד׳ֻן'),
('he-expansion-16','palestinian','وِدْن','ودن','וִדְן'),
('he-expansion-17','msa','فَم','فم','פַם'),
('he-expansion-17','palestinian','تِمّ','تم','תִםּ'),
('he-expansion-18','msa','قَلْب','قلب','קַלְבּ'),
('he-expansion-18','palestinian','قَلْب','قلب','אַלְבּ'),
('he-expansion-19','msa','سِنّ','سن','סִןּ'),
('he-expansion-19','palestinian','سِنّ','سن','סִןּ'),
('he-expansion-20','msa','شَعْر','شعر','שַעְר'),
('he-expansion-20','palestinian','شَعْر','شعر','שַעְר'),
('he-expansion-21','msa','قِطّ','قط','קִטּ'),
('he-expansion-21','palestinian','بِسَّة','بسة','בִּסַּה'),
('he-expansion-22','msa','كَلْب','كلب','כַּלְבּ'),
('he-expansion-22','palestinian','كَلْب','كلب','כַּלְבּ'),
('he-expansion-23','msa','حِصَان','حصان','חִצַאן'),
('he-expansion-23','palestinian','حِصَان','حصان','חִצַאן'),
('he-expansion-24','msa','سَمَكَة','سمكة','סַמַכַּה'),
('he-expansion-24','palestinian','سَمَكَة','سمكة','סַמַכַּה'),
('he-expansion-25','msa','طَائِر','طائر','טַאאִר'),
('he-expansion-25','palestinian','عُصْفُور','عصفور','עֻצְפוּר'),
('he-expansion-26','msa','شَجَرَة','شجرة','שַג׳ַרַה'),
('he-expansion-26','palestinian','شَجَرَة','شجرة','שַג׳ַרַה'),
('he-expansion-27','msa','زَهْرَة','زهرة','זַהְרַה'),
('he-expansion-27','palestinian','زَهْرَة','زهرة','זַהְרַה'),
('he-expansion-28','msa','بَحْر','بحر','בַּחְר'),
('he-expansion-28','palestinian','بَحْر','بحر','בַּחְר'),
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
('he-expansion-34','palestinian','نَار','نار','נַאר')
) AS v(entry_key,dialect,vocalized,search,transliteration)
JOIN dictionary_entries e ON e.entry_key=v.entry_key
WHERE NOT EXISTS (
 SELECT 1 FROM arabic_forms af WHERE af.entry_id=e.id AND af.dialect=v.dialect
)
ON CONFLICT(entry_id,dialect,arabic_vocalized) DO NOTHING;

INSERT INTO entry_sources(entry_id,source_id)
SELECT e.id,s.id FROM dictionary_entries e CROSS JOIN dictionary_sources s
WHERE e.entry_key LIKE 'he-expansion-%' AND s.code='manual-demo'
ON CONFLICT(entry_id,source_id) DO NOTHING;
COMMIT;
SELECT (SELECT COUNT(*) FROM dictionary_entries) AS entries,
       (SELECT COUNT(*) FROM arabic_forms) AS forms;
