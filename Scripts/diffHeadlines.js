/* Script: diffHeadlines.js
--------------------
Takes two files of headlines, one of all headlines, and one of the headlines within that file that are specifically known to be angry. The output file consists (inputFile1 - inputFile2), namely all of the non angry headlines from the first file.
*/


var fs = require('fs');

if (process.argv.length != 5){
    console.log('Not enough arguments.\nnode nytimes.js inputFile.txt outputFile.txt');
    return;
}

var inputFile1 = process.argv[2];
var inputFile2 = process.argv[3];
var outputFile = process.argv[4];

fs.readFile(inputFile1, 'utf8', function(error, data1){
    
   if (error){
       console.log(error);
   } else {
       
       fs.readFile(inputFile2, 'utf8', function(error, data2){
       
          	var headlinesAngry = data2.split('\n');
			for (var i = 0; i < headlinesAngry.length; i++){
				var index = data1.search(headlinesAngry[i]);
				if (index == -1) 
					console.log(headlinesAngry[i]);
				else{
					data1 = data1.replace(headlinesAngry[i], ''); 
				}
	        }
	        
			fs.writeFile(outputFile, data1);
       		
       			
		});
              
   }
});

