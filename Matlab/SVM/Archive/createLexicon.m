% Anshul Samar
% File: createLexicon.m
% -------------------------
% Parses through every row of the input feature matrix (in our case a%
% vector of headlines) and creates a lexicon of all the words that are used.

function[map, lexicon] = createLexicon(headlines)

map = containers.Map();
lexicon = repmat({''},1, 1);
[rows, cols] = size(headlines);
for i=1:rows
str = headlines(i,:);
words = strsplit(char(str));
words = words';
[wordsRows, wordsCols] = size(words);
for j=1:wordsRows
if (isKey(map, char(words(j,:))))
    map(char(words(j,:))) = map(char(words(j,:))) + 1;
else
    map(char(words(j,:))) = 1;
    lexicon = [lexicon; words(j,:)];
end
end
end

lexicon(1,:) = []; %removes the first row as it is empty
lexicon = sort(lexicon); %sorts alphabetically 
end
