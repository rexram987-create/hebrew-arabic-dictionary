-- Batch 3: colors, days, months, plus week/month.
-- Arabic forms are first-pass MSA/Palestinian entries and should be pronunciation-checked in the app.
BEGIN;

INSERT INTO dictionary_entries(entry_key,hebrew,hebrew_search,part_of_speech,review_status)
VALUES
('he-color-red','אדום','אדום','adjective','unreviewed'),
('he-color-blue','כחול','כחול','adjective','unreviewed'),
('he-color-green','ירוק','ירוק','adjective','unreviewed'),
('he-color-yellow','צהוב','צהוב','adjective','unreviewed'),
('he-color-black','שחור','שחור','adjective','unreviewed'),
('he-color-white','לבן','לבן','adjective','unreviewed'),
('he-color-orange','כתום','כתום','adjective','unreviewed'),
('he-color-purple','סגול','סגול','adjective','unreviewed'),
('he-color-pink','ורוד','ורוד','adjective','unreviewed'),
('he-color-brown','חום','חום','adjective','unreviewed'),
('he-color-gray','אפור','אפור','adjective','unreviewed'),
('he-day-sunday','יום ראשון','יום ראשון','noun','unreviewed'),
('he-day-monday','יום שני','יום שני','noun','unreviewed'),
('he-day-tuesday','יום שלישי','יום שלישי','noun','unreviewed'),
('he-day-wednesday','יום רביעי','יום רביעי','noun','unreviewed'),
('he-day-thursday','יום חמישי','יום חמישי','noun','unreviewed'),
('he-day-friday','יום שישי','יום שישי','noun','unreviewed'),
('he-day-saturday','שבת','שבת','noun','unreviewed'),
('he-month-january','ינואר','ינואר','noun','unreviewed'),
('he-month-february','פברואר','פברואר','noun','unreviewed'),
('he-month-march','מרץ','מרץ','noun','unreviewed'),
('he-month-april','אפריל','אפריל','noun','unreviewed'),
('he-month-may','מאי','מאי','noun','unreviewed'),
('he-month-june','יוני','יוני','noun','unreviewed'),
('he-month-july','יולי','יולי','noun','unreviewed'),
('he-month-august','אוגוסט','אוגוסט','noun','unreviewed'),
('he-month-september','ספטמבר','ספטמבר','noun','unreviewed'),
('he-month-october','אוקטובר','אוקטובר','noun','unreviewed'),
('he-month-november','נובמבר','נובמבר','noun','unreviewed'),
('he-month-december','דצמבר','דצמבר','noun','unreviewed'),
('he-week','שבוע','שבוע','noun','unreviewed'),
('he-month','חודש','חודש','noun','unreviewed')
ON CONFLICT(entry_key) DO NOTHING;

INSERT INTO arabic_forms(entry_id,dialect,arabic_vocalized,arabic_search,hebrew_transliteration)
SELECT e.id,v.dialect,v.vocalized,v.search,v.transliteration
FROM (VALUES
('he-color-red','msa','أَحْمَر','أحمر','אַחְמַר'),
('he-color-red','palestinian','أَحْمَر','أحمر','אַחְמַר'),
('he-color-blue','msa','أَزْرَق','أزرق','אַזְרַק'),
('he-color-blue','palestinian','أَزْرَق','أزرق','אַזְרַק'),
('he-color-green','msa','أَخْضَر','أخضر','אַחְדַר'),
('he-color-green','palestinian','أَخْضَر','أخضر','אַחְדַר'),
('he-color-yellow','msa','أَصْفَر','أصفر','אַסְפַר'),
('he-color-yellow','palestinian','أَصْفَر','أصفر','אַסְפַר'),
('he-color-black','msa','أَسْوَد','أسود','אַסְוַד'),
('he-color-black','palestinian','أَسْوَد','أسود','אַסְוַד'),
('he-color-white','msa','أَبْيَض','أبيض','אַבְּיַד'),
('he-color-white','palestinian','أَبْيَض','أبيض','אַבְּיַד'),
('he-color-orange','msa','بُرْتُقَالِيّ','برتقالي','בֻּרְתֻקַאלִי'),
('he-color-orange','palestinian','بُرْتُقَالِي','برتقالي','בֻּרְתֻקַאלִי'),
('he-color-purple','msa','بَنَفْسَجِيّ','بنفسجي','בַּנַפְסַג׳ִי'),
('he-color-purple','palestinian','بَنَفْسَجِي','بنفسجي','בַּנַפְסַג׳ִי'),
('he-color-pink','msa','وَرْدِيّ','وردي','וַרְדִי'),
('he-color-pink','palestinian','زَهْرِي','زهري','זַהְרִי'),
('he-color-brown','msa','بُنِّيّ','بني','בֻּנִּי'),
('he-color-brown','palestinian','بُنِّي','بني','בֻּנִּי'),
('he-color-gray','msa','رَمَادِيّ','رمادي','רַמַאדִי'),
('he-color-gray','palestinian','رَمَادِي','رمادي','רַמַאדִי'),
('he-day-sunday','msa','الأَحَد','الأحد','אַלְאַחַד'),
('he-day-sunday','palestinian','الأَحَد','الأحد','אַלְאַחַד'),
('he-day-monday','msa','الاِثْنَيْن','الاثنين','אַלְאִתְ׳נֵין'),
('he-day-monday','palestinian','الاِثْنَيْن','الاثنين','אַלְאִתְ׳נֵין'),
('he-day-tuesday','msa','الثُّلَاثَاء','الثلاثاء','אַת׳-תֻּלַאת׳ַאא'),
('he-day-tuesday','palestinian','الثُّلَاثَا','الثلاثا','אַת׳-תֻּלַאת׳ַא'),
('he-day-wednesday','msa','الأَرْبِعَاء','الأربعاء','אַלְאַרְבִּעַאא'),
('he-day-wednesday','palestinian','الأَرْبِعَا','الأربعا','אַלְאַרְבִּעַא'),
('he-day-thursday','msa','الخَمِيس','الخميس','אַלְחַ׳מִיס'),
('he-day-thursday','palestinian','الخَمِيس','الخميس','אַלְחַ׳מִיס'),
('he-day-friday','msa','الجُمُعَة','الجمعة','אַלְגֻ׳מֻעַה'),
('he-day-friday','palestinian','الجُمْعَة','الجمعة','אַלְגֻ׳מְעַה'),
('he-day-saturday','msa','السَّبْت','السبت','אַס-סַבְּת'),
('he-day-saturday','palestinian','السَّبْت','السبت','אַס-סַבְּת'),
('he-month-january','msa','يَنَايِر','يناير','יַנַאיִר'),
('he-month-january','palestinian','كَانُون الثَّانِي','كانون الثاني','כַּאנוּן א-תַ׳אנִי'),
('he-month-february','msa','فِبْرَايِر','فبراير','פִבְּרַאיִר'),
('he-month-february','palestinian','شُبَاط','شباط','שֻׁבַּאט'),
('he-month-march','msa','مَارِس','مارس','מַארִס'),
('he-month-march','palestinian','آذَار','آذار','אַד׳ַאר'),
('he-month-april','msa','أَبْرِيل','أبريل','אַבְּרִיל'),
('he-month-april','palestinian','نَيْسَان','نيسان','נַיְסַאן'),
('he-month-may','msa','مَايُو','مايو','מַאיוּ'),
('he-month-may','palestinian','أَيَّار','أيار','אַיַּאר'),
('he-month-june','msa','يُونْيُو','يونيو','יוּנְיוּ'),
('he-month-june','palestinian','حَزِيرَان','حزيران','חַזִירַאן'),
('he-month-july','msa','يُولْيُو','يوليو','יוּלְיוּ'),
('he-month-july','palestinian','تَمُّوز','تموز','תַמּוּז'),
('he-month-august','msa','أَغُسْطُس','أغسطس','אַעֻ׳סְטֻס'),
('he-month-august','palestinian','آب','آب','אַבּ'),
('he-month-september','msa','سِبْتَمْبَر','سبتمبر','סִבְּתַמְבַּר'),
('he-month-september','palestinian','أَيْلُول','أيلول','אַיְלוּל'),
('he-month-october','msa','أُكْتُوبَر','أكتوبر','אֻכְּתוּבַּר'),
('he-month-october','palestinian','تِشْرِين الأَوَّل','تشرين الأول','תִשְׁרִין אלְאַוַּל'),
('he-month-november','msa','نُوفَمْبَر','نوفمبر','נוּפַמְבַּר'),
('he-month-november','palestinian','تِشْرِين الثَّانِي','تشرين الثاني','תִשְׁרִין א-תַ׳אנִי'),
('he-month-december','msa','دِيسَمْبَر','ديسمبر','דִיסַמְבַּר'),
('he-month-december','palestinian','كَانُون الأَوَّل','كانون الأول','כַּאנוּן אלְאַוַּל'),
('he-week','msa','أُسْبُوع','أسبوع','אֻסְבּוּע'),
('he-week','palestinian','أُسْبُوع','أسبوع','אֻסְבּוּע'),
('he-month','msa','شَهْر','شهر','שַׁהְר'),
('he-month','palestinian','شَهْر','شهر','שַׁהְר')
) AS v(entry_key,dialect,vocalized,search,transliteration)
JOIN dictionary_entries e ON e.entry_key=v.entry_key
WHERE NOT EXISTS (
 SELECT 1 FROM arabic_forms af
 WHERE af.entry_id=e.id AND af.dialect=v.dialect
)
ON CONFLICT(entry_id,dialect,arabic_vocalized) DO NOTHING;

COMMIT;

SELECT
  (SELECT COUNT(*) FROM dictionary_entries WHERE entry_key LIKE 'he-color-%') AS colors,
  (SELECT COUNT(*) FROM dictionary_entries WHERE entry_key LIKE 'he-day-%') AS days,
  (SELECT COUNT(*) FROM dictionary_entries WHERE entry_key LIKE 'he-month-%') AS named_months,
  (SELECT COUNT(*) FROM dictionary_entries WHERE entry_key IN ('he-week','he-month')) AS time_units;