% Function: extractDataFromTextFile.m
% -----------------------------
% Given a filename (i.e. headlines.txt) with new line seperated headlines
% returns a matlab vector of headlines for use in a .m script.

function[headlines] = extractFeaturesFromTextFile(fileName,numHeadlines)

  fid = fopen(fileName);
  allData = textscan(fid,'%d','Delimiter','\n');
  headlines = allData{1};
  disp('Features extracted');

end
