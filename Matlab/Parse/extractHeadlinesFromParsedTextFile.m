% The first argument is a .txt file that has parsed data from the python
% script. The second argument is the number of headlines you wish to parse
% from that file of headlines. 
%
% The output is a numHeadlinesx1 Cell  where the only
% element inside the struct is a string of csvs containing unigrams and
% bigrams for the headlines. 
%


function[headlines] = extractHeadlinesFromParsedTextFile(fileName,numHeadlines)

fid = fopen(fileName);

  allData = textscan(fid,'%s','Delimiter','\n');
  headlines = allData{1};
  disp('Headlines extracted');

  for i=1:numHeadlines
      elm = headlines(i);
      headlines(i) = {strrep(elm{1},'#',',')};
  end

  headlines = headlines(1:numHeadlines);


end
