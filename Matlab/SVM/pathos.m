% Anshul Samar
% File: headlines.m
% -----------------
% Requires user to run loadconstants.m first. SVM on 'anger' emotion.
% Assumes all headlines in training and testing have been parsed and that 
% training testing data sets have already been collected.

function[predicted_label,trainErrorMatrix,testErrorMatrix,lexicon,testlexicon] = pathos()

addpath('../Parse/');
addpath('../NB/');
addpath('../Lib/liblinear-1.93');

global angryHeadlinesParsedPath numAngryHeadlines nonAngryHeadlinesParsedPath numNonAngryHeadlines angryHeadlinesAPISumPath nonAngryHeadlinesAPISumPath totalAngryHeadlines totalNonAngryHeadlines

disp('Gathering All Data');

%Randomly shuffle angry headlines

angryHeadlines = extractHeadlinesFromParsedTextFile(angryHeadlinesParsedPath, totalAngryHeadlines);
x = randperm(size(angryHeadlines, 1));
angryHeadlines = angryHeadlines(x);

%Take select group of these

angryHeadlines = angryHeadlines(1:numAngryHeadlines,:);
angryLabels = ones(numAngryHeadlines,1);

%angryAPISum = extractFeaturesFromTextFile(angryHeadlinesAPISumPath, numAngryHeadlines);

%Randomly shuffle nonAngry headlines

nonAngryHeadlines = extractHeadlinesFromParsedTextFile(nonAngryHeadlinesParsedPath, totalNonAngryHeadlines);
x = randperm(size(nonAngryHeadlines, 1));

%Take select group of these

nonAngryHeadlines = nonAngryHeadlines(1:numAngryHeadlines,:);
nonAngryLabels = zeros(numNonAngryHeadlines,1);

%nonAngryAPISum = extractFeaturesFromTextFile(nonAngryHeadlinesAPISumPath, numNonAngryHeadlines);

disp('Randomly permuting headlines for cross validation');

totalHeadlines = [angryHeadlines; nonAngryHeadlines];
totalLabels = [angryLabels; nonAngryLabels];
x = randperm(size(totalHeadlines,1));
totalHeadlines = totalHeadlines(x);
totalLabels = totalLabels(x);

%totalAPISum = [angryAPISum; nonAngryAPISum];

disp('Beginning cross validation');

numHeadlines = numAngryHeadlines + numNonAngryHeadlines;
tenPercent = floor(numHeadlines/10);

statsMatrixSVM = zeros(10,3);
statsMatrixNB = zeros(10,3);

for(i=0:9)

   disp('CVALIDATION ' + i);

  startIndex = i .* tenPercent;
  if i == 9
    endIndex = numHeadlines;
  else
    endIndex = (i + 1) .* tenPercent;
  end

  testHeadlines = totalHeadlines((startIndex + 1):endIndex,:);
  testLabels = totalLabels((startIndex + 1):endIndex,:);
 % testAPISum = totalAPISum((startIndex + 1):endIndex,:);

  if i == 0
     trainHeadlines = totalHeadlines(endIndex+1:numHeadlines);
     trainLabels = totalLabels(endIndex+1:numHeadlines);
  %   trainAPISum = totalAPISum(endIndex+1:numHeadlines);
  elseif i == 9
     trainHeadlines = totalHeadlines(1:startIndex);
     trainLabels = totalLabels(1:startIndex);
   %  trainAPISum = totalAPISum(1:startIndex);
  else
      trainHeadlines = [totalHeadlines(1:startIndex, :);  totalHeadlines((endIndex + 1):numHeadlines,:)];
      trainLabels = [totalLabels(1:startIndex, :);  totalLabels((endIndex + 1):numHeadlines,:)];
    %  trainAPISum = [totalAPISum(1:startIndex, :);  totalAPISum((endIndex + 1):numHeadlines,:)];
  end

  [map, lexicon] = createLexicon(trainHeadlines);
  [trainMatrix,trainErrorMatrix] = createFeatureMatrix(trainHeadlines, lexicon);
  [testMatrix,testErrorMatrix] = createFeatureMatrix(testHeadlines, lexicon);

%  disp('Adding API Sums');

 % trainMatrix = [trainMatrix, trainAPISum];
 % testMatrix = [testMatrix, testAPISum];
  
  disp('SVM:');

%  [model] = svm_train(trainMatrix, trainLabels);
%  [predicted_label, accuracy, decision] = svm_test(testLabels, testMatrix, model);
%  [precision, recall, accuracy] = stats(testLabels,predicted_label)
%  statsMatrixSVM((i+1),1) = precision;
%  statsMatrixSVM((i+1),2) = recall;
%  statsMatrixSVM((i+1),3) = accuracy;


  disp('NB')

  for (j = 1:size(trainLabels,1))
      if (trainLabels(j) == -1)
	 trainLabels(j) = 0;
      end
  end
     
  for (j = 1:size(testLabels,1))
      if (testLabels(j,1) == -1)
	 trainLabels(j,1) = 0;
      end
  end
 
  predicted_label = nb_run(trainMatrix, trainLabels, testMatrix, testLabels);
  [precision, recall, accuracy] = stats(testLabels, predicted_label);
  statsMatrixNB((i+1),1) = precision;
  statsMatrixNB((i+1),2) = recall;
  statsMatrixNB((i+1),3) = accuracy;

  disp('*****************');

end

%disp(statsMatrixSVM);
disp(statsMatrixNB);

%disp('Average SVM Results');
%disp('Precision');
%disp(sum(statsMatrixSVM(:,1)) ./ 10);
%disp('Recall');
%disp(sum(statsMatrixSVM(:,2)) ./ 10);
%disp('Accuracy');
%disp(sum(statsMatrixSVM(:,3)) ./ 10);

disp('Average NB Results');
disp('Precision');
disp(sum(statsMatrixNB(:,1)) ./ 10);
disp('Recall');
disp(sum(statsMatrixNB(:,2)) ./ 10);
disp('Accuracy');
disp(sum(statsMatrixNB(:,3)) ./ 10);

end
