function theta = newtonTest(inputFilename, labelFilename, num, testFilename, labelTestFilename,testNum,numEmotions)

%training data
[headlines] = extractData(inputFilename,num);
[labels] = extractLabels(labelFilename,num,numEmotions);
[map, lexicon] = createLexicon(headlines);
[trainMatrix] = createTrainMatrix(headlines, lexicon);
[trainMatrixLabels] = createLabelMatrix(labels);

%testingData
[testHeadlines] = extractData(testFilename,testNum);
[testLabels] = extractLabels(labelTestFilename,testNum,numEmotions);
[testMap, testLexicon] = createLexicon(testHeadlines);
[testMatrix] = createTrainMatrix(testHeadlines, lexicon);
[testMatrixLabels] = createLabelMatrix(testLabels);

for emotionNum=1:numEmotions
theta = newton(trainMatrix, trainMatrixLabels(:,emotionNum))
theta
end
