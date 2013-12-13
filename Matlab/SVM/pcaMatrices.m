function[pcaTrainMatrix,pcaTestMatrix] = pcaMatrices(trainMatrix,testMatrix)

trainMean = mean(trainMatrix);
trainStd = std(trainMatrix);

disp('got basic stats and size');
[m n] = size(trainMatrix);

sMatrix = (trainMatrix - repmat(trainMean,[m 1]))./repmat(trainStd,[m 1]);
disp('got standardized matrix');

tStart = tic;
[V D] = eig(cov(sMatrix));

disp('got eigenvectors and values of cov matrix');

tElapsed = toc(tStart)

D = flipud(diag(D));
V = fliplr(V);

cumVar = cumsum(D)/sum(D);
index = find(cumVar>0.95,1)

l = size(D,1)

eigenbasis = V(:,1:index);

pcaTrainMatrix = (eigenbasis'*trainMatrix')';                                  
pcaTestMatrix = (eigenbasis'*testMatrix')';

disp('successfully computed newTrainMatrix');

size(pcaTrainMatrix);
size(pcaTestMatrix);
end

