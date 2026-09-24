import test from "node:test";
import assert from "node:assert/strict";
import {normalize,searchDictionary,statistics} from "../lib/dictionary.js";
test("Arabic search is diacritic insensitive",()=> assert.equal(searchDictionary("سلام")[0]?.hebrew,"שלום"));
test("Hebrew search",()=>assert.equal(searchDictionary("מים")[0]?.hebrew,"מים"));
test("Palestinian search",()=>assert.equal(searchDictionary("بدي")[0]?.hebrew,"אני רוצה"));
test("source provenance",()=>assert.equal(statistics().importedExternalEntries,0));
test("normalize whitespace",()=>assert.equal(normalize("  בַּיִת  "),"בית"));
