% Function: extractDataFromTextFile.m
% -----------------------------
% Given a filename (i.e. headlines.txt) with new line seperated headlines
% returns a matlab vector of headlines for use in a .m script.

function[headlines] = extractHeadlinesFromTextFile(fileName,numHeadlines)

  fid = fopen(fileName);
  allData = textscan(fid,'%s','Delimiter','\n');
  headlines = allData{1};
  disp('Headlines extracted');

end
