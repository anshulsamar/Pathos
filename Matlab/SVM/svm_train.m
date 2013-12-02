% Anshul Samar
% File: svm_train.m
% -------------------
% Trains an svm on trainMatrix and trainLabels.

function[model] = svm_train(trainMatrix, trainLabels)

addpath('../Lib/liblinear-1.93/matlab');
trainMatrix = sparse(trainMatrix);
model = train(trainLabels(:,1), sparse(trainMatrix));
end
