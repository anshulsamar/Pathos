var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;
var fs = require('fs');

var url = 'http://words.bighugelabs.com/api/2/be791b9b2adb9f43e79cd86008d7d291/';

function callAPI(outputFile, word, headline, all){
    
     if (headline.length == 0 && word == null){
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
            
            callAPI(outputFile,nextWord,nextHeadline,all);
            return;
        } else        
            return;
    }

    console.log('API call for: ' + word);

    var request = new XMLHttpRequest();
    request.addEventListener('readystatechange',function(){
       if (request.readyState == 4){
           
           if (request.responseText.length > 0){
    
                var synonyms = [];
                for (var j in JSON.parse(request.responseText)){
                    synonyms += JSON.parse(request.responseText)[j].syn;
                }
                    
            
               if (synonyms.length > 0){
                synonyms = synonyms.split(',');
               console.log(synonyms);
               
                for (i = 0; i < synonyms.length; i++) {          
                    fs.appendFile(outputFile, ',' + synonyms[i]);
                }
               }
           }
                       
            setTimeout(function(){
                newWord = headline.shift();
                callAPI(outputFile, newWord, headline, all);
            },200);           
       
       }
    });
    
    request.open('GET', url + word + '/json', true);
    request.send();
        
}


if (process.argv.length !== 4){
    console.log('Not enough arguments.\nnode thesaurus.js inputFile.txt outputFile.txt');
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
       
       callAPI(outputFile, word, headline, all);
   }
});

