% Function: reformatSemevalHeadlines.m
% ------------------------------------
% Writes each headline to a .txt file (for use by the parser).

function[] = reformatSemevalHeadlines()

disp('Parsing Semeval XML into txt file');
[headlines] = extractSemevalHeadlines();
fid = fopen('../../Matlab/Training/temp.txt', 'wt');
for i=1:size(headlines,1)
for j=1:size(headlines(i),2)
fprintf(fid, '%c', char(headlines(i,j)));
end
fprintf(fid, '%s\n', '');
end
fclose(fid);
disp('Finished. txt can be found in  Matlab/Training/temp.txt');


end
