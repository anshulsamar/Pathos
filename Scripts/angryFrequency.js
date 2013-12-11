var request = require('request');
var fs = require('fs');


function callAPI(page, count, outputFile, word, headline, all){
    
     if (headline.length == 0 && word == null){
         fs.appendFile(outputFile, count);
        if (all.length){
            var nextHeadline = all.shift();
            
            for (i = 0; i < nextHeadline.length; i++){
                var j = punctuation.indexOf(nextHeadline[i]);
                if (j >= 0)
                    nextHeadline = nextHeadline.substr(0,i) + nextHeadline.substr(i+1, nextHeadline.length);
            }
            
            nextHeadline = nextHeadline.split(' ');
            var nextWord = nextHeadline.shift();
            
            fs.appendFile(outputFile,'\n');
            
            callAPI(0, 0, outputFile,nextWord,nextHeadline,all);
            return;
        } else        
            return;
    }

    console.log('API call for: ' + word);
    
    var url = 'http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=headline:(\"angry\"AND\"' + word + '\")&page=' + encodeURIComponent(page) + '&fl=headline,lead_paragraph&api-key=fe1412f1ee8ed3c6f6e3f7a2d90c066c:8:67781992';

    request(url, function (error, response, body) {
                         
                if (!error && response.statusCode == 200) {
                    obj = JSON.parse(body);
                    if (obj.response.docs.length > 0 && page < 100){
                        count += obj.response.docs.length;
                        setTimeout(function(){
                            callAPI(page+1, count, outputFile, word, headline, all);
                        },200);
                    } else {
                        setTimeout(function(){
                            newWord = headline.shift();
                            callAPI(0, count, outputFile, newWord, headline, all);
                        },200);
                        
                    }
                        
                    
                }
            
            });

        
}


if (process.argv.length !== 4){
    console.log('Not enough arguments.\nnode angryFrequency.js inputFile.txt outputFile.txt');
    return;
}

var inputFile = process.argv[2];
var outputFile = process.argv[3];

var punctuation = [',','\'','\"','!','.','#'];

fs.readFile(inputFile, 'utf8', function(error, data){
    
   if (error){
       console.log(error);
   } else {
       data = data.substring(0,data.length - 1);
       var all = data.split('\n');
       var headline = all.shift();

        for (i = 0; i < headline.length; i++){
            var j = punctuation.indexOf(headline[i]);
            if (j >= 0)
                headline = headline.substr(0,i) + headline.substr(i+1, headline.length);
        }

       
       headline = headline.split(' ');
       var word = headline.shift();
       
       callAPI(0, 0, outputFile, word, headline, all);
   }
});

