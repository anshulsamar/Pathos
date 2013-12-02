%Given a Cell of Headlines (where each entry in the cell is a cellstr which
%in itself is just a list of csvs in string format), return a map and a
%Lexicon containing all the unique unigrams/bigrams from the set of
%headlines. Lexicon is a Cell <1xn> where n = NumFeatures (unique unigrams/bigrams). 

function[map, lexicon] = createLexicon(trainHeadlines) 

map = containers.Map();

[m,n] = size(trainHeadlines);

for i = 1:m
    elm = trainHeadlines(i);
    csvs = strsplit(elm{1},',');
    for csv = csvs
       map(csv{1}) = 1;
    end
end

lexicon = keys(map);

end