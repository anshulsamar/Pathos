% Anshul Samar
% File: svm_test.m
% ---------------
% Use svm to predict based on svm model, testMatrix, and testLabels

function[predicted_label, accuracy, decision] = svm_test(testLabels, testMatrix, model)

addpath('../Lib/liblinear-1.93/matlab');
[predicted_label, accuracy, decision] = predict(testLabels,sparse(testMatrix), model);
end
