/* Script: yearlyHeadlines.js
--------------------
Description: Calls the NY Times api for random assortment of yearlyHeadlines. 

Command line: node yearlyHeadlines.js inputFile.txt outputFile.txt numPage. 

For example: 'node yearlyHeadlines.js inputYears.txt randomHeadlines.txt 100'. inputFile.txt is a comma seperated file with a list of years to query the API for. Writes headlines to file outputFile.txt, with headlines seperated by the new line. The maximum value numPage can take is 100.
*/

var request = require('request');
var fs = require('fs');

//Recursive function to ensure sequential request to avoid QPS limit

function callAPI(i, outputFile, date, API, pages){
      
    if (i == -1){
        if (API.length){
            var nextDate = API.shift();
            callAPI(0,outputFile,nextDate,API,pages);
            return;
        } else        
            return;
    }

    console.log('API call ' + (i+1) + ' for: ' + date);
    
    var oldHeadline = '';
        
        request('http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=pub_date:(\"' + date + '\")&page=' + encodeURIComponent(i) + '&fl=headline,snippet,lead_paragraph,pub_date,keywords&api-key=fe1412f1ee8ed3c6f6e3f7a2d90c066c:8:67781992', function (error, response, body) {
            obj = [];
                if (!error && response.statusCode == 200) {
                    obj = JSON.parse(body);
                    for (var j = 0; j < obj.response.docs.length; j++){
                        
                        //NYTimes repeats headlines, this removes repetitions. Bug somewhere 
                        //as some repeated headlines still get through
                        
                        var newHeadline = obj.response.docs[j].headline.main;
                        
                        if (oldHeadline !== newHeadline){               
                            fs.appendFile(outputFile, newHeadline + '\n');
                            oldHeadline = newHeadline;
                        }
                    }
                    
                }
            
                setTimeout(function(){
                    if (obj.response.docs.length == 0)
                        callAPI(-1, outputFile, date, API);
                    else
                        callAPI(i+1, outputFile, date, API);
                },200);
            
            });
}

if (process.argv.length !== 4){
    console.log('Not enough arguments.\nnode nytimes.js inputFile.txt outputFile.txt');
    return;
}

var inputFile = process.argv[2];
var outputFile = process.argv[3];

fs.readFile(inputFile, 'utf8', function(error, data){
    
   if (error){
       console.log(error);
   } else {
       data = data.substring(0,data.length - 1);
       var API = data.split('\n');
       var word = API.shift();
       callAPI(0, outputFile, word, API);
   }
});

