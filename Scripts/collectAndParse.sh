#Gathers training data (this does not get 100 calls for specific words)

node nytimes.js ~/CS229/Pathos/Lexicons/angerLexicon.txt angerHeadlines.txt 10
node nytimes.js ~/CS229/Pathos/Lexicons/nonangerLexicon.txt nonangryHeadlines.txt 10

#Runs data through parser

./Parser/parse.sh angryHeadlines.txt ../Matlab/Training/angryHeadlinesParsed.txt train
./Parser/parse.sh nonangryHeadlines.txt ../Matlab/Training/nonangryHeadlinesParsed.txt train

#Run data through parser

./Parser/parse.sh ../Evaluation/testHeadlines.txt ../Evaluation/testHeadlinesParsed.txt test
