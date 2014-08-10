# node js script
#! /usr/bin/env node

var fs = require('fs');
var sWordFile = '/usr/share/dict/words';
var sAnagramOutFile = './out.txt';
var hAnagrams = {};
var sAnagrams = "";

exports.findAnagrams = function findAnagrams(result) {
    fs.readFile(sWordFile, 'utf8', function (err, data) {
        if (err) { console.error('Error: ' + err); result(false); }
        var arrData = data.toString().split("\n");
        for (var i=0; i < arrData.length; i++)
        {
            var sTempWord = arrData[i];
            if(! sTempWord.match(/\W+/))
            {
                var sWordParsed = sTempWord.toLowerCase().split("").sort().join("").toString();
                var arrTemp;

                if (hAnagrams[sWordParsed] !== undefined)
                    arrTemp = hAnagrams[sWordParsed];
                else
                    arrTemp = new Array();

                arrTemp.push(sTempWord);
                hAnagrams[sWordParsed] = arrTemp;
            }
        }

        var aSortedKeys = Object.keys(hAnagrams).sort(function (a, b) { 
            return hAnagrams[a].length - hAnagrams[b].length || hAnagrams[a][0].localeCompare(hAnagrams[b][0]);
        }).reverse();

        aSortedKeys.forEach(function (sSortedKey)
        {
            if (hAnagrams[sSortedKey].length > 1)
                sAnagrams += (hAnagrams[sSortedKey]) + "\n";
        });

        fs.writeFile(sAnagramOutFile, sAnagrams, function (err) { if (err) throw err; console.log('wrote to: ' + sAnagramOutFile) });
        result(true);
    });
}
