function[output] = nb_run(trainMatrix, labelMatrix, testMatrix, testLabelMatrix)

for i=1:size(labelMatrix,1)
if (labelMatrix(i) == -1)
labelMatrix(i) = 0;
end
end

for i=1:size(testLabelMatrix,1)
if (testLabelMatrix(i) == -1)
testLabelMatrix(i) = 0;
end
end

[phiY0, phiY1, phiY] = nb_train(trainMatrix, labelMatrix);

numTestDocs = size(testMatrix, 1);
numTokens = size(testMatrix, 2);

output = zeros(numTestDocs, 1);

pYis1 = 0;
pYis0 = 0;

for i=1:numTestDocs

x = testMatrix(i, :);

probXcondYis0 = 0;
probXcondYis1 = 0;
for j=1:numTokens
probXcondYis0 = probXcondYis0 + log(phiY0(j))*x(j);
probXcondYis1 = probXcondYis1 + log(phiY1(j))*x(j);
end

numeratorProbYis0 = probXcondYis0 + log(1 - phiY);
numeratorProbYis1 = probXcondYis1 + log(phiY);

output(i) = numeratorProbYis1 > numeratorProbYis0;

end
 
%---------------


% Compute the error on the test set
%correct=0;
%for i=1:numTestDocs
%  if (testLabelMatrix(i) == output(i))
%    correct=correct+1;
%  end
%end

%Print out the classification error on the test set
%accuracy = correct/numTestDocs

%recallDenominator = 0;
%recallNumerator = 0;
%precisionDenominator = 0;
%precisionNumerator = 0;

%for i=1:size(testLabelMatrix,1)
%  if (testLabelMatrix(i) == 1)
%    recallDenominator = recallDenominator + 1;
%    if (output(i) == 1)
%      recallNumerator = recallNumerator + 1;
%    end
%  end

 % if (output(i) == 1)
  %  precisionDenominator = precisionDenominator + 1;
   % if (testLabelMatrix(i) == 1)
    %  precisionNumerator = precisionNumerator + 1;
   % end
  %end
%end
%precisionNumerator
%precisionDenominator
%recallNumerator
%recallDenominator
%precision = precisionNumerator/precisionDenominator
%recall = recallNumerator/recallDenominator

end
