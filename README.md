Determining emotion in a piece of text is a difficult subset of "sentiment
analysis" which has largely focused on a binary classification of text as 
positive or negative. Classifying sentences in one of six major emotion
categories (anger, disgust, fear, joy, sadness, and surprise) can
significantly contribute to fields including political polling, marketing, 
and economics. In Project Pathos, we create a model to classify 'angry' news
headlines from the SemEval 2007 Affective Text Task.

Project Pathos has 2 basic parts:

First, data collection and parsing. Pathos uses the NYTimes API to gather
headlines from two lexicons, angryLexicon.txt and nonangryLexicon.txt. It
runs these headlines as well as headlines from our evaluation set through
a parser. Run the script collectAndParse.sh to collect training data and parse
training and testing data. 

Second, we classify. To do this we create a bag of words model from our
training data and run it through an SVM and use it to classify our
evaluation headlines.