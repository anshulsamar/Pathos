/* Script: angryFrequency.js
------------------------------
For each line in the input file, queries NYTimes for the number of pages in the API call that include that word and 'angry.' For example the NYTimes might return 10 pages of headlines for 'angry' and 'Montana' and 8 pages for 'angry' and 'lives.' The corresponding line in the output file contains the sum of page counts for each word in the line of the input file.
*/


var request = require('request');
var fs = require('fs');


function callAPI(page, count, outputFile, word, headline, all){
    
     if (headline.length == 0 && word == null){
     console.log(count);
         fs.appendFile(outputFile, count);
        if (all.length){
            var nextHeadline = all.shift();
            
            for (i = 0; i < nextHeadline.length; i++){
                var j = punctuation.indexOf(nextHeadline[i]);
                if (j >= 0)
                    nextHeadline = nextHeadline.substr(0,i) + nextHeadline.substr(i+1, nextHeadline.length);
            }
            
            for (prep in commonPrep){
               nextHeadline = nextHeadline.toLowerCase().replace(commonPrep[prep] + ' ', '');  
              nextHeadline = nextHeadline.toLowerCase().replace(' ' + commonPrep[prep], '');   
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
    
    var url = 'http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=headline:(\"anger\"AND\"' + word + '\")&begin_date=20130101&end_date=20131210&page=' + encodeURIComponent(page) + '&fl=headline,lead_paragraph&api-key=fe1412f1ee8ed3c6f6e3f7a2d90c066c:8:67781992';

    request(url, function (error, response, body) {
                         
                if (!error && response.statusCode == 200) {
                    obj = JSON.parse(body);
                    if (obj.response.docs.length > 0 && page < 2){
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

var punctuation = [',','\'','\"','!','.','#', '\''];
var commonPrep = ['about','above','across','after','against','around','at','before','behind','below','beneath','beside','besides','between','beyond','by','down','during','except','for','from','in','inside','into','like','near','of','off','on','out','outside','over','since','through','troughout','till','to','toward','under','until','upup','on','with','without','according to','because of','iby way of','in addition','to in front of','in place of','in regard to','in spite of','instead of','on account of','out of','the','how','who','what','where','when','why','has','be','is','been','had','and','but','him','her','it'];

fs.readFile(inputFile, 'utf8', function(error, data){
    
   if (error){
       console.log(error);
   } else {
       data = data.substring(0,data.length - 1);

       console.log(data);
       
       var all = data.split('\n');
       var headline = all.shift();

        for (i = 0; i < headline.length; i++){
            var j = punctuation.indexOf(headline[i]);
            if (j >= 0)
                headline = headline.substr(0,i) + headline.substr(i+1, headline.length);
        }
       
        for (prep in commonPrep){
            headline = headline.toLowerCase().replace(commonPrep[prep] + ' ', '');  
              headline = headline.toLowerCase().replace(' ' + commonPrep[prep], ''); 
        }
       
     
       headline = headline.split(' ');
       var word = headline.shift();
       
       callAPI(0, 0, outputFile, word, headline, all);
   }
});

