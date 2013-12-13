% Anshul Samar
% File: headlines.m
% -----------------
% Requires user to run loadconstants.m first. SVM on 'anger' emotion.
% Assumes all headlines in training and testing have been parsed and that 
% training testing data sets have already been collected.


function[predicted_label,trainErrorMatrix,testErrorMatrix,lexicon,testlexicon] = headlinesSVM()

addpath('../Parse/');
addpath('../Lib/liblinear-1.93');

global angryHeadlinesParsedPath numAngryHeadlines nonAngryHeadlinesParsedPath numNonAngryHeadlines testHeadlinesParsedPath numTestHeadlines testLabelsPath numEmotions

fid = fopen('trainingData.mat');

if fid == -1

  disp('Gathering Training Data');

  %training data

  [trainAngryHeadlines] = extractHeadlinesFromParsedTextFile(angryHeadlinesParsedPath, numAngryHeadlines);
  trainAngryLabels = ones(numAngryHeadlines,1);

  trainNonAngryHeadlines = extractHeadlinesFromParsedTextFile(nonAngryHeadlinesParsedPath, numNonAngryHeadlines);
  trainNonAngryLabels = zeros(numNonAngryHeadlines,1);

  trainHeadlines = [trainAngryHeadlines; trainNonAngryHeadlines];
  trainLabels = [trainAngryLabels; trainNonAngryLabels];

  disp('Creating lexicon and map from training data');

  [map, lexicon] = createLexicon(trainHeadlines);

  disp('Creating Feature Matrix');

  [trainMatrix,trainErrorMatrix] = createFeatureMatrix(trainHeadlines, lexicon);

  disp('Saving to file: trainingData.dat for faster load next time');
  save('trainingData','trainMatrix','lexicon', 'trainLabels');

else

  disp('Loading trainMatrix and lexicon from file trainingData.mat');
  load('trainingData','trainMatrix','lexicon','trainLabels');

end

disp('Gathering evaluation data');

%evaluation data

[testHeadlines] = extractHeadlinesFromParsedTextFile(testHeadlinesParsedPath, numTestHeadlines);
[testLabels] = extractSemevalLabels(testLabelsPath, numTestHeadlines, numEmotions);
[testlexicon] = createLexicon(testHeadlines);
testLabels = createLabelMatrix(testLabels);
[testMatrix,testErrorMatrix] = createFeatureMatrix(testHeadlines, lexicon);

avgAccuracy = 0;
avgPrecision = 0;
avgRecall = 0;

disp('Running SVM');

fid = fopen('model.mat');

if fid == -1

  [model] = svm_train(trainMatrix, trainLabels);
  save('model','model');

else

  disp('Loading model from file model.mat');
  load('model');

end

[predicted_label, accuracy, decision] = svm_test(testLabels(:,1), testMatrix, model);

disp('Determining precision and recall.');

precisionNumerator = 0;
precisionDenominator = 0;
recallNumerator = 0;
recallDenominator = 0;
accuracyNumerator = 0;
accuracyDenominator = 0;

for i=1:size(testLabels(:,1),1)

  if (testLabels(i,1) == 1 && predicted_label(i) == 1)
     accuracyNumerator = accuracyNumerator + 1;
     accuracyDenominator = accuracyDenominator + 1;
  else
    accuracyDenominator = accuracyDenominator + 1;
    end

  if (testLabels(i,1) == 1)
    recallDenominator = recallDenominator + 1;
    if (predicted_label(i) == 1)
      recallNumerator = recallNumerator + 1;
    end
  end

  if (predicted_label(i) == 1)
    precisionDenominator = precisionDenominator + 1;
    if (testLabels(i,1) == 1)
      precisionNumerator = precisionNumerator + 1;
    end
  end
end

precision = precisionNumerator/precisionDenominator
recall = recallNumerator/recallDenominator
accuracy = accuracyNumerator/accuracyDenominator

disp('Finished.');

end


