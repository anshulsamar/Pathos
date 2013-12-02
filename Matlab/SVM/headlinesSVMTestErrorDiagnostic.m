%headlinesSVM('affectivetext_test.xml', 'affectivetext_test.valence.gold', 1000, 'affectivetext_trial.xml', 'affectivetext_trial.valence.gold', 250, 1)

avgTestAccuracy = zeros(4,1);
avgTestPrecision = zeros(4,1);
avgTestRecall = zeros(4,1);

[avgTestAccuracy(1,1), avgTestPrecison(1,1), avgTestRecall(1,1)] = headlinesSVM('affectivetext_test.xml', 'affectivetext_test.emotions.gold', 250, 'affectivetext_trial.xml', 'affectivetext_trial.emotions.gold', 250, 6);
[avgTestAccuracy(2,1), avgTestPrecison(2,1), avgTestRecall(2,1)] = headlinesSVM('affectivetext_test.xml', 'affectivetext_test.emotions.gold', 500, 'affectivetext_trial.xml', 'affectivetext_trial.emotions.gold', 250, 6);
[avgTestAccuracy(3,1), avgTestPrecison(3,1), avgTestRecall(3,1)] = headlinesSVM('affectivetext_test.xml', 'affectivetext_test.emotions.gold', 750, 'affectivetext_trial.xml', 'affectivetext_trial.emotions.gold', 250, 6);
[avgTestAccuracy(4,1), avgTestPrecison(4,1), avgTestRecall(4,1)] = headlinesSVM('affectivetext_test.xml', 'affectivetext_test.emotions.gold', 1000, 'affectivetext_trial.xml', 'affectivetext_trial.emotions.gold', 250, 6);

avgTestAccuracy

avgTestError = [100;100;100;100]
avgTestError = avgTestError - avgTestAccuracy;
x = [250, 500, 750, 1000];
plot(x, avgTestError);
hold on;
 
avgTestError
avgTestPrecision
avgTestRecall

avgTrainAccuracy = zeros(4,1);
avgTrainPrecision = zeros(4,1);
avgTrainRecall = zeros(4,1);

[avgTrainAccuracy(1,1), avgPrecison(1,1), avgTrainRecall(1,1)] = headlinesSVM('affectivetext_test.xml', 'affectivetext_test.emotions.gold', 250, 'affectivetext_test.xml', 'affectivetext_test.emotions.gold', 1000, 6);
[avgTrainAccuracy(2,1), avgPrecison(2,1), avgTrainRecall(2,1)] = headlinesSVM('affectivetext_test.xml', 'affectivetext_test.emotions.gold', 500, 'affectivetext_test.xml', 'affectivetext_test.emotions.gold', 1000, 6);
[avgTrainAccuracy(3,1), avgPrecison(3,1), avgTrainRecall(3,1)] = headlinesSVM('affectivetext_test.xml', 'affectivetext_test.emotions.gold', 750, 'affectivetext_test.xml', 'affectivetext_test.emotions.gold', 1000, 6);
[avgTrainAccuracy(4,1), avgPrecison(4,1), avgTrainRecall(4,1)] = headlinesSVM('affectivetext_test.xml', 'affectivetext_test.emotions.gold', 1000, 'affectivetext_test.xml', 'affectivetext_test.emotions.gold', 1000, 6);

avgTrainAccuracy

avgTrainError = [100;100;100;100];
avgTrainError = avgTrainError - avgTrainAccuracy;
x = [250, 500, 750, 1000];
plot(x, avgTrainError);
hold off;


