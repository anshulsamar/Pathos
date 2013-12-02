% Anshul Samar
% File: extractData.m
% ----------------------
% Given a filename from the Affective Test data set found in (Pathos/Evaluation/), this matlab function
% uses XPATH to parse it. It creates a vector of headlines readable into a
% .m script. Requires user to run loadconstants.m

function[headlines] = extractSemevalHeadlines()

disp('Extracting semeval headlines');

global numTestHeadlines testHeadlinesFilePath

filePath = testHeadlinesFilePath;
import javax.xml.xpath.*
factory = XPathFactory.newInstance;
xpath = factory.newXPath;
headlines = repmat({''},numTestHeadlines, 1);
docNode = xmlread(filePath);
j = 1;

for i=1:numTestHeadlines;
  expString = strcat('corpus/instance[',num2str(i), ']');
  expression = xpath.compile(expString);
  headline = expression.evaluate(docNode, XPathConstants.STRING);
  headlines(j) = cellstr(headline);
  j = j + 1;
end

disp('SemEval Headliens extracted from dataset and xml file');

end
