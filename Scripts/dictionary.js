var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

var urlFirstHalf = 'http://www.dictionaryapi.com/api/v1/references/collegiate/xml/'
var urlSecondHalf = '?key=8af1bbd6-95ed-4ca8-8634-2defe56dd4fe';

var request = new XMLHttpRequest();
request.addEventListener('readystatechange',function(){
   if (request.readyState == 4){
         console.log(request.responseText);
   }    
});

request.open('GET', urlFirstHalf + 'kill' + urlSecondHalf, true);
request.send();
