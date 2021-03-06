/* Script: nytimes.js
--------------------
Description: Calls the NY Times api for headlines that match words in input file. Only gets articles before December 2013. Calls 40 pages for anger.
Command line: node nytimes.js inputFile.txt outputFile.txt numPage. Note: maximum value numPage can take is a 100.
*/

var request = require('request');
var fs = require('fs');

//Recursive function to ensure sequential request to avoid QPS limit

function callAPI(i, outputFile, word, API, pages){
      
    if (i >= pages){
        if (API.length){
            var nextWord = API.shift();
            if (nextWord == 'anger' || nextWord == 'angry')
                callAPI(0,outputFile,nextWord,API,20);
            else
                callAPI(0,outputFile,nextWord,API,pages);
            return;
        } else        
            return;
    }

    console.log('API call ' + (i+1) + ' for: ' + word);
    
    var oldHeadline = '';
    
    
        request('http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=headline:(\"' + word + '\")&page=' + encodeURIComponent(i) + '&fl=headline,lead_paragraph&end_date=20131130&api-key=fe1412f1ee8ed3c6f6e3f7a2d90c066c:8:67781992', function (error, response, body) {
                         
                if (!error && response.statusCode == 200) {
                    obj = JSON.parse(body);
                    for (var j = 0; j < obj.response.docs.length; j++){
                        
                        //NYTimes repeats headlines, this removes repetitions. Bug somewhere 
                        //as some repeated headlines still get through
                        
                        var newHeadline = obj.response.docs[j].headline.main;
                        
                        if (oldHeadline !== newHeadline){
	                        newHeadline = newHeadline.toLowerCase().replace(word, '');
                            fs.appendFile(outputFile, newHeadline + '\n');
                            oldHeadline = newHeadline;
                        }
                    }
                    
                }
            
                setTimeout(function(){
                    callAPI(i+1, outputFile, word, API, pages);
                },200);
            
            });
}

if (process.argv.length !== 5){
    console.log('Not enough arguments.\nnode nytimes.js inputFile.txt outputFile.txt numPage');
    return;
}

var inputFile = process.argv[2];
var outputFile = process.argv[3];
var pages = process.argv[4];

fs.readFile(inputFile, 'utf8', function(error, data){
    
   if (error){
       console.log(error);
   } else {
       data = data.substring(0,data.length - 1);
       var API = data.split(',');
       var word = API.shift();
       callAPI(0, outputFile, word, API, pages);
   }
});

