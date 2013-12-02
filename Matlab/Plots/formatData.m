headlines = extractData('affectivetext_trial.xml',250);
labels = extractLabels('affectivetext_trial.emotions.gold',250,6);
labels = createLabelMatrix(labels);

for i=1:size(labels,1)
for j = 1:size(labels,2)
if (labels(i,j) == -1)
labels(i,j) = 0;
end
end
end

labelsString = cellstr(num2str(labels));
headlinesFormatted = [headlines, labelsString]

emotions = [{'anger'};{'disgust'};{'fear'};{'joy'};{'sadness'};{'surprise'}];

for i=1:6
headlinesEmo = [];
for j=1:size(headlines,1)

if (labels(j,i) == 1)
headlinesEmo = [headlinesEmo;headlines(j,:)];

end
end
disp(emotions(i))
headlinesEmo
end

%headlines = extractData('affectivetext_test.xml',1000);
%labels = extractLabels('affectivetext_test.emotions.gold',1000,6);
%labels = createLabelMatrix(labels);

%for i=1:size(labels,1)
%for j = 1:size(labels,2)
%if (labels(i,j) == -1)
%labels(i,j) = 0;
%end
%end
%end

%labels = cellstr(num2str(labels));
%headlinesFormatted = [headlines, labels]
