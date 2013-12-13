% Anshul Samar
% File: headlines.m
% -----------------
% Requires user to run loadconstants.m first. SVM on 'anger' emotion.
% Assumes all headlines in training and testing have been parsed and that 
% training testing data sets have already been collected.

function[predicted_label,trainErrorMatrix,testErrorMatrix,lexicon,testlexicon] = SVM()

addpath('../Parse/');
addpath('../Lib/liblinear-1.93');

global angryHeadlinesParsedPath numAngryHeadlines nonAngryHeadlinesParsedPath numNonAngryHeadlines 

disp('Gathering All Data');

%training data

angryHeadlines = extractHeadlinesFromParsedTextFile(angryHeadlinesParsedPath, numAngryHeadlines);
angryLabels = ones(numAngryHeadlines,1);

nonAngryHeadlines = extractHeadlinesFromParsedTextFile(nonAngryHeadlinesParsedPath, numNonAngryHeadlines);
nonAngryLabels = zeros(numNonAngryHeadlines,1);

disp('Randomly permuting headlines for cross validation');

totalHeadlines = [angryHeadlines; nonAngryHeadlines];
totalLabels = [angryLabels; nonAngryLabels];
x = randperm(size(totalHeadlines,1));
totalHeadlines = totalHeadlines(x);
totalLabels = totalLabels(x);

disp('Beginning cross validation via SVM');

numHeadlines = numAngryHeadlines + numNonAngryHeadlines;
tenPercent = floor(numHeadlines/10);

for(i=0:9)

  startIndex = i .* tenPercent;
  if i == 9
    endIndex = numHeadlines;
  else
    endIndex = (i + 1) .* tenPercent;
  end

  testHeadlines = totalHeadlines((startIndex + 1):endIndex,:);
  testLabels = totalLabels((startIndex + 1):endIndex,:);

  if i == 0
     trainHeadlines = totalHeadlines(endIndex+1:numHeadlines);
     trainLabels = totalLabels(endIndex+1:numHeadlines);
  elseif i == 9
     trainHeadlines = totalHeadlines(1:startIndex);
     trainLabels = totalLabels(1:startIndex);
  else
      disp('Combining parts');
      trainHeadlines = [totalHeadlines(1:startIndex, :);  totalHeadlines((endIndex + 1):numHeadlines,:)];
      trainLabels = [totalLabels(1:startIndex, :);  totalLabels((endIndex + 1):numHeadlines,:)];
  end


  disp('Creating lexicon and map from training data');

  [map, lexicon] = createLexicon(trainHeadlines);

  disp('Creating Feature Matrix');

  [trainMatrix,trainErrorMatrix] = createFeatureMatrix(trainHeadlines, lexicon);
  [testMatrix,testErrorMatrix] = createFeatureMatrix(testHeadlines, lexicon);

  avgAccuracy = 0;
  avgPrecision = 0;
  avgRecall = 0;

  disp('Running SVM');

  [model] = svm_train(trainMatrix, trainLabels);
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

%  precision = precisionNumerator/precisionDenominator
 % recall = recallNumerator/recallDenominator
  %accuracy = accuracyNumerator/accuracyDenominator

  disp('Finished.');

end

end
