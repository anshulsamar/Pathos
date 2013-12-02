% Anshul Samar
% File: createFeatureMatrix.m
% --------------------------
% Takes the input feature matrix (in our case a vector of headlines) and
% the lexicon (Created by createLexicon), and outputs a matrix (mxn), where each
% row represents one feature vector and there is a 1, if that particular
% word in the Lexicon is present in our vector.

function[trainMatrix] = createFeatureMatrix(headlines, lexicon)

[lexiconRows, lexiconCols] = size(lexicon);
[headlinesRows, headlinesCols] = size(headlines);
trainMatrix = zeros(headlinesRows, lexiconRows);

for i=1:headlinesRows
  str = headlines(i,:);
  words = strsplit(char(str));
  words = words';
  [wordsRows, wordsCols] = size(words);
  for j=1:wordsRows
    X = strcmp(lexicon, cellstr(words(j,:)));
    ind = find(X); %finds the non zero elements in X
    if(size(ind,1) ~= 0)
      trainMatrix(i, ind(1)) = 1;
    end
end
end

end
