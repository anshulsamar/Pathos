%Given a vector of headlines (trainHeadlines), and a lexicon, create a
%Training Matrix for those headlines based on the Lexicon. This matrix is a
%typical bag of words model. 


function[trainMatrix] = createFeatureMatrix(trainHeadlines, lexicon)


%Get the sizes of the trainHeadlines matrix
[numHeadlines,n] = size(trainHeadlines); %m = # of headlines, n = 1
[a,numFeatures] = size(lexicon); %a = 1, b = # of features in lexicon

%Initialize the training Matrix with all the input
%Each row represents one training headline, and the columns represent 
%the amount of each feature they have in the lexicon.
%Everything is 0 at first, we will update this matrix. 
trainMatrix = zeros(numHeadlines,numFeatures);

for i = 1:numHeadlines
    elm = trainHeadlines(i);
    csvs = strsplit(elm{1},',');
    features = [];
    for csv = csvs
        features = [features; csv];
    end
    [featureRows, featureCols] = size(features);
    for j = 1:featureRows
        for k = 1:numFeatures
            X = strcmp(features(j,1),lexicon(1,k));
            if X == 1
                trainMatrix(i,k) = trainMatrix(i,k) + 1;
            end
        end
    end
    disp(i);
end
