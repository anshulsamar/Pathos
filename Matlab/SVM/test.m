
totalHeadlines = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11];
totalLabels = [0; 0; 0; 0; 0; 1; 1; 1; 1; 1; 1; 1];
x = randperm(11);
totalHeadlines = totalHeadlines(x)
totalLabels = totalLabels(x)
numAngryHeadlines = 6;
numNonAngryHeadlines = 5;

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

  testHeadlines = totalHeadlines((startIndex + 1):endIndex,:)
  testLabels = totalLabels((startIndex + 1):endIndex,:)

  if i == 0
     trainHeadlines = totalHeadlines(endIndex+1:numHeadlines)
     trainLabels = totalLabels(endIndex+1:numHeadlines)
  elseif i == 9
     trainHeadlines = totalHeadlines(1:startIndex)
     trainLabels = totalLabels(1:startIndex)
  else
      disp('Combining parts');
      trainHeadlines = [totalHeadlines(1:startIndex, :);  totalHeadlines((endIndex + 1):numHeadlines,:)]
      trainLabels = [totalLabels(1:startIndex, :);  totalLabels((endIndex + 1):numHeadlines,:)]
  end
end
