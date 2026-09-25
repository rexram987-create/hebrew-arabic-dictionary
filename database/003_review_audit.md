# Review gate for database/003_expansion_candidates.sql

Status: **NOT APPROVED FOR IMPORT**. This is an audit, not an attestation that 34 forms were checked against Maknuune.

## Source access
- Maknuune project: https://sites.google.com/nyu.edu/palestine-lexicon/lexicon
- Research paper: https://aclanthology.org/2022.wanlp-1.13/
- Public GitHub repository https://github.com/CAMeL-Lab/maknuune_lexicon contains PDF-generation code and letter sections; the accessible repository tree does **not** include a TSV/CSV lexicon sheet. The project site advertises a TSV download, but its actual downloadable records have not been retrieved and compared here.
- Consequently **zero of the 34 entries are marked source-verified** in this review. Prior conversational correction counts are edit counts, not independently validated lexemes.

## Priority review items
1. Entry 24 fish: Arabic سَمَكِة in the draft needs a lexical source check; previous سَمَكَة is a standard singular. Do not claim changing the final vowel mark proves Palestinian pronunciation.
2. Entries 26/27 tree/flower: شَجَرِة / زَهْرِة are tentative orthographic representations of final -e, not confirmed Maknuune spellings. Compare both vowelized orthography and phonological transcription.
3. Entry 18 heart: Arabic قَلْب and Hebrew אַלְבּ encode an urban glottal-qaf pronunciation without specifying dialect region. Verify regional variant and label it explicitly.
4. Entry 10 woman: مَرَة may have ambiguity/usage connotations; confirm gloss and context.
5. Entries 06 and 08 daughter/girl: both بنت; make the shared Arabic headword and differing Hebrew glosses explicit.
6. Entry 25 bird: طَيْر is generic; distinguish عصفور small bird/sparrow, not a blanket synonym.
7. Entry 32 rain: شِتَا has weather/winter sense as well as rain in colloquial usage; verify gloss/context.
8. All 68 Arabic forms: compare Arabic vowelization, Hebrew transliteration, meaning, dialect and TTS playback before publishing.

## Safe workflow
Obtain the source lexicon TSV from the project site's official download, record source version and license, check each Palestinian candidate against its diacritized Arabic form + phonological transcription + English gloss, and add per-entry provenance. If source spelling differs, resolve rather than silently replacing it. Then run SQL against a staging database, check counts and searches, and only then import into production.

**Do not run database/003_expansion_candidates.sql in Neon yet.**

## Retrieval update (2026-09-25)
- Confirmed official lexicon page advertises **Download TSV**: https://sites.google.com/nyu.edu/palestine-lexicon/lexicon . The link's underlying file is not exposed in the text-only page view, so the TSV rows were **not** obtained.
- Identified a secondary dataset mirror at https://huggingface.co/datasets/arbml/Maknuune (about 36.3k rows, Parquet format), but its dataset card lacks license and field documentation. Do not assume it is a verified version of the official TSV or reuse it in the production dictionary without checking provenance/license.
- The 2022 paper https://aclanthology.org/2022.wanlp-1.13/ explicitly says the initial Maknuune collection emphasizes West Bank subdialects; do not generalize every pronunciation to all Palestinian Arabic speakers.
- **Actual row-level comparison performed: 0 / 34.** Do not increment the verification count based on discovering dataset links. Await actual TSV/Parquet access, then record matched source rows and unresolved mismatches.

## Source/license check (2026-09-25, follow-up)
- NYU Abu Dhabi's own resource page describes Maknuune as downloadable and confirms diacritized orthography, phonological transcription and English glosses: https://nyuad.nyu.edu/en/research/faculty-labs-and-projects/computational-approaches-to-modeling-language-lab/resources.html
- An independent Arabic NLP resource index labels Maknuune CC BY-SA 4.0: https://github.com/NNLP-IL/Arabic-Resources ; **this is secondary evidence, not confirmation of the exact release's license file**. Confirm license in the official TSV/release before incorporating its data, and preserve attribution and share-alike obligations if applicable: https://creativecommons.org/licenses/by-sa/4.0/
- The Hugging Face mirror's README leaves the licensing section unspecified: https://huggingface.co/datasets/arbml/Maknuune/blob/main/README.md . Do not silently attribute the mirror's data to a specific official release.
- Attempts to retrieve official embedded TSV through the public text view and mirror file tree through the web reader did not return downloadable records. **No lexeme has been source-verified**; do not make additional speculative spelling edits to SQL while the comparison source is unavailable.

## Actual Maknuune TSV v1.0.1 audit (uploaded by user)
- Source: user-supplied `maknuune-v1.0.1.tsv`; 36,302 data records, with ID, LEMMA, FORM, CAPHI++, GLOSS, etc. The user also supplied LICENSE.txt confirming CC BY-SA 4.0.
- Confirmed source examples (ID → Arabic form / English gloss): 529 إِمّ mother; 11 أَب father; 162 أَخ brother; 151 أُخُت sister; 2425 اِبِن son;child; 2341 بِنِت girl; 13123 زَلَمِة man; 30368 مَرَة woman; 17472 صَاحِب friend;companion; 36210 إِيد hand; 10896 رَاس head; 22266 عَين eye; 15087 سِنّ tooth; 16356 شَعَر hair; 14964 سَمَكِة fish; 19781 طَير bird; 15643 شَجَرَة tree; 13269 زَهْرَة flower; 15012 سَمَا sky; 15638 شِتَا winter.
- Corrections needed in candidate draft: Palestinian sister should be compared to أُخُت, son to اِبِن, girl/daughter to بِنِت, man to زَلَمِة, hair to شَعَر, fish سَمَكِة is **supported** by source ID 14964; tree شَجَرِة is **not supported** by source ID 15643 (شَجَرَة, CAPHI++ sh a J a r a), flower زَهْرِة is **not supported** by source ID 13269 (زَهْرَة, CAPHI++ z a h r a).
- Serious semantic conflict: draft Palestinian rain شِتَا, but source ID 15638 glosses it **winter**. Keep this word out of a rain entry pending review of a suitable Palestinian rain term. Source ID 26506 قَلْب is glossed **stomach**, not heart; do not cite it as confirmation of the heart gloss. Female friend صَاحْبِة and ear وِدْن were not found as exact normalized headwords in this first pass.
- Source matching is not identical to approval: this is a **first-pass audit**, with dialect variation and semantics still requiring review. Do not import 003 to Neon yet.

## CAPHI++ and source-row correction (2026-09-25)
- Verified directly against user-uploaded Maknuune v1.0.1 TSV: ID 17472 صَاحِب, CAPHI++ s. aa 7 i b, gloss friend;companion. Hebrew transliteration corrected from צַאחֶבּ to צַאחִבּ.
- ID 22266 عَين, CAPHI++ 3 ee n, gloss eye, MSA gloss عَيْن. Palestinian Hebrew transliteration corrected from עַיְן to עֵין; CODA orthography and actual spoken vowel must not be conflated.
- Rain-source correction: ID 30854 مَطَرَة = rain, ID 30855 مَطَرَة = water_bottle, ID 30853 مَطَر = airport;airfield. The TSV does NOT supply a noun entry مَطَر glossed rain, so do not label the Palestinian noun form مَطَر source-verified by this TSV. Standard Arabic مَطَر means rain; retain Palestinian usage provisionally until corroborated elsewhere.
- ID 26506 قَلْب = stomach (MSA gloss معدة); not evidence for heart. Other heart-related phrases exist but do not resolve standalone headword sense.
- NOTE: earlier audit line claiming source ID 30854 had airport gloss is INCORRECT; the airport gloss is ID 30853. This section supersedes that line.

## Complete first-pass lemma scan, Maknuune v1.0.1 (2026-09-25)
Compared all 34 Palestinian draft headwords to normalized LEMMA and FORM columns, then manually inspected the matching gloss and CAPHI++ rather than treating an orthographic match as proof of the intended sense. Relevant source IDs: mother 529, father 11, brother 162, sister 151, son 2425, girl 2341, boy 36009, man 13123, woman 30368, friend 17472, hand 36210, head 10896, eye 22266, tooth 15087, hair 16356, cat 1442, dog 28213, horse 6229, fish 14964, bird 19781, tree 15643, flower 13269, sea 812, mountain 3559, land 255, sky 15012, wind 12519, fire 33728.

**Unresolved or false matches**:
- Female friend صَاحْبِة: no exact undiacritized LEMMA or FORM match صاحبة. Must not mark verified.
- Ear وِدْن: no exact undiacritized LEMMA or FORM match ودن. Seek another spelling/source.
- Mouth تِمّ: exact تم matches only verb 'complete;remain;stay' (IDs 3191,3195); no mouth gloss in these matches. Seek alternate Palestinian term or independent source.
- Heart قَلْب: exact noun match ID 26506 glosses **stomach**, not heart. Do not infer heart sense from this entry.
- Rain مَطَر: exact noun ID 30853 glosses **airport;airfield**, not rain; مَطَرَة ID 30854 glosses rain. The generic MSA meaning of مطر is rain but this TSV does not establish the Palestinian standalone noun's sense.
- Daughter and girl: بنت ID 2341 glosses girl, not explicitly daughter. Hebrew 'בת' requires additional sense corroboration.
- Earth/soil אדמה: أرض ID 255 glosses land;territory;land_plot, not necessarily soil. Distinguish 'land' from 'soil' in Hebrew gloss.
- Friend صَاحِب CAPHI s. aa 7 i b (צַאחִבּ) and eye عَين CAPHI 3 ee n (עֵין) checked.
- Cat بِسّ ID 1442 is cat; the older draft بِسَّة was not found as an exact normalized lemma/form. Horse حْصَان ID 6229; sea بَحَر ID 812.

This scan is NOT a full pronunciation/TTS or 68-form verification. Source match means this sense is attested in the dataset, not that all dialect speakers use it or that Hebrew transliteration is approved. Keep import blocked.

## Second-pass gloss search beyond exact Arabic spelling (2026-09-25)
Searched the user-supplied TSV's **English glosses** for the intended meaning, then inspected lemma, CAPHI++, and ID. This reveals alternate Palestinian forms that exact-form search missed:
- **ear**: ID 205 ذَان, CAPHI++ D aa n, gloss ear. This is *not* confirmation of draft وِدِن, which was cross-checked against Madrasah separately. Keep dialectal spelling/pronunciation evidence separate.
- **mouth**: ID 3433 ثِمّ, CAPHI++ T i m m, gloss mouth; ID 2617 بُوز, CAPHI++ b uu z, gloss mouth; ID 33847 نِيع, CAPHI++ n ii 3, gloss mouth. The earlier exact تم search only matched verbs; it did not prove that تُمّ is wrong. Madrasah's تُمّ must be cited independently, not attributed to Maknuune.
- **soil**: ID 2912 تُرْبِة, CAPHI++ t u r b e, gloss soil. Draft أَرْض (ID 255) means land/territory/land_plot. Hebrew אדמה is ambiguous: clarify whether intended sense is soil or land before replacing the translation.
- **rain**: ID 30854 مَطَرَة gloss rain; ID 15637 شِتَاء gloss winter;rain; ID 23063 غَيْث gloss rain. Do not conflate شِتَاء (ID 15637) with شِتَا (ID 15638, winter).
- **daughter**: no exact standalone 'daughter' gloss was found in the scanned lemma=headword records; بنت (ID 2341) gloss girl, and the daughter sense needs separate contextual verification.
- **female friend**: no exact standalone 'female_friend' gloss was found in this scan; Madrasah cross-check remains distinct.

Decision: no speculative bulk edits based solely on the English gloss search. Resolve אדמה's Hebrew intended sense and the dialect policy before finalizing the 34-row import.
