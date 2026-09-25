import test from "node:test";
import assert from "node:assert/strict";
import { normalize, formatResults } from "../lib/dictionary.js";
test("Arabic search is diacritic insensitive", () => assert.equal(normalize("سَلَام"), "سلام"));
test("Hebrew search ignores vowel marks", () => assert.equal(normalize("  בַּיִת  "), "בית"));
test("Palestinian form normalization", () => assert.equal(normalize("بِدِّي"), "بدي"));
test("database rows map into both Arabic dialects", () => {
  const rows = [
    {id:"1",hebrew:"מים",dialect:"msa",arabic_vocalized:"مَاء",hebrew_transliteration:"מַאא׳"},
    {id:"1",hebrew:"מים",dialect:"palestinian",arabic_vocalized:"مَيّ",hebrew_transliteration:"מַיּ"}
  ];
  const results = formatResults(rows);
  assert.equal(results.length, 1);
  assert.equal(results[0].arabic.msa.text, "مَاء");
  assert.equal(results[0].arabic.palestinian.text, "مَيّ");
});
