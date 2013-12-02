% Function: reformatSemevalHeadlines.m
% ------------------------------------
% Writes each headline to a .txt file (for use by the parser).

function[] = reformatSemevalHeadlines()

disp('Parsing Semeval XML into txt file');
[headlines] = extractSemevalHeadlines();
fid = fopen('../../Evaluation/testHeadlines.txt', 'wt');
for i=1:size(headlines,1)
for j=1:size(headlines(i),2)
fprintf(fid, '%c', char(headlines(i,j)));
end
fprintf(fid, '%s\n', '');
end
fclose(fid);
disp('Finished. testHeadlines.txt can be found in Pathos/Evaluation/');


end
