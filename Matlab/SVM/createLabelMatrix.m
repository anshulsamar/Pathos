% Anshul Samar
% File: createLabelMatrix.m
% --------------------------
% Takes any positive value in the label matrix and makes it 1, takes any
% negative or 0 value and makes it -1. 

function[labelMatrix] = createLabelMatrix(labels)

[labelsRows, labelsCols] = size(labels);
labelMatrix = labels;

for i=1:labelsRows
for j=1:labelsCols
if (labelMatrix(i, j) <= 50) labelMatrix(i,j) = -1;
else labelMatrix(i,j) = 1;
end
end
end

end
