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
