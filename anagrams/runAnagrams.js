#! /usr/bin/node env

var anagramObj = require('./anagrams.js');
anagramObj.findAnagrams(function (result) { console.log("anagrams found: " + result); });
