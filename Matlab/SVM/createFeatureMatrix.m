%Given a vector of headlines (trainHeadlines), and a lexicon, create a
%Training Matrix for those headlines based on the Lexicon. This matrix is a
%typical bag of words model. 


function[trainMatrix,unregisteredMatrix] = createFeatureMatrix(trainHeadlines, lexicon)

mapWordToIndex = containers.Map();
for i = 1:size(lexicon,2)
	mapWordToIndex(char(lexicon(i))) = i;
end

keys(mapWordToIndex);

%Get the sizes of the trainHeadlines matrix
[numHeadlines,n] = size(trainHeadlines); %m = # of headlines, n = 1
[a,numFeatures] = size(lexicon); %a = 1, b = # of features in lexicon

%Initialize the training Matrix with all the input
%Each row represents one training headline, and the columns represent 
%the amount of each feature they have in the lexicon.
%Everything is 0 at first, we will update this matrix. 
trainMatrix = zeros(numHeadlines,numFeatures);

unregisteredMatrix = zeros(numHeadlines, 2);


for i = 1:numHeadlines
    elm = trainHeadlines(i);
    csvs = strsplit(elm{1},',');
    features = [];
    for csv = csvs
        features = [features; csv];
    end
    [featureRows, featureCols] = size(features);
    unregisteredMatrix(i,2) = featureRows;
    uFeatures = 0;
    for j = 1:featureRows
	    if (mapWordToIndex.isKey(char(features(j,1))))
	       k = mapWordToIndex(char(features(j,1)));
               trainMatrix(i,k) = trainMatrix(i,k) + 1;
	    else 
	       uFeatures = uFeatures + 1;
            end
    end
    unregisteredMatrix(i,1) = uFeatures;
    %disp(i);
end
