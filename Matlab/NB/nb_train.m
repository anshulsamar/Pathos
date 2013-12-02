function[phiY0, phiY1, phiY] = nb_train(trainMatrix, labelMatrix)

numTrainDocs = size(trainMatrix, 1);
numTokens = size(trainMatrix, 2);

phiY0 = zeros(numTokens, 1);
phiY1 = zeros(numTokens, 1);

totalWordsY1 = 0;
totalWordsY0 = 0;

for i=1:numTrainDocs
if labelMatrix(i) == 0
    totalWordsY0 = totalWordsY0 + sum(trainMatrix(i,:));
end
if labelMatrix(i) == 1
    totalWordsY1 = totalWordsY1 + sum(trainMatrix(i,:));
end
end

for i=1:numTokens
  for j=1:numTrainDocs
    if labelMatrix(j) == 0
        phiY0(i) = phiY0(i) + trainMatrix(j, i);
    end
    if labelMatrix(j) == 1
	phiY1(i) = phiY1(i) + trainMatrix(j, i);
    end
  end
end

phiY0 = (phiY0 + 1) ./ (totalWordsY0 + numTokens);
phiY1 = (phiY1 + 1) ./ (totalWordsY1 + numTokens);
phiY = sum(labelMatrix) ./ numTrainDocs;

end
% YOUR CODE HERE
