% Anshul Samar
% File: extractLabels.m
% -----------------------
% Given a filename from the Affective Test data set (found in Path/Evaluation/, this matlab function
% uses XPATH to parse it. It creates a matrix of lables (Each column represents a different emotion)

function[labels] = extractSemevalLabels(testLabelsFilePath, numTestHeadlines, numEmotions)

disp('Extracting semeval labels');


labels = zeros(numTestHeadlines, numEmotions + 1); %extra column for id
fid = fopen(testLabelsFilePath);
tline = fgetl(fid);
for i=1:numTestHeadlines
a = sscanf(tline, '%f')
labels(i,:)
labels(i,:) = a;
tline = fgetl(fid);
end

labels(:,1) = []; %remove the id's
fclose(fid);

disp('SemEval dataset labels extracted');

end
