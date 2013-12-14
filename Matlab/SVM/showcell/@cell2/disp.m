function disp(arg)
%DISP Display method for cell arrays.
%
%   Note: This is meant to overload the DISP method for @CELL. To do that,
%   rename the parent folder to "@cell" and make sure that the folder
%   containing "@cell" is on the MATLAB path.
%   
%   
%   DISP(ARG) displays the contents of a cell array ARG in the command
%   window.  It will format the display so that long strings will display
%   appropriately.  ARG can be a cell array of numbers, strings, and/or other
%   objects.
%
%   Acceptable numbers are of class DOUBLE, SINGLE, LOGICAL, UINT8, UINT16,
%   UINT32, UINT64, INT8, INT16, INT32, INT64. Elements other than CHAR or
%   numbers are displayed as the size and name of the object,
%     e.g. [1x1 struct]
%
%   See also CELL\DISPLAY

%   Jiro Doke
%   Copyright 2006-2010 The MathWorks, Inc.
%   Version: 11.2.2010.1

                                                                          %
if isempty(arg)                                                           %
  return;                                                                 %
end                                                                       %
                                                                          %
if ndims(arg) > 2                                                         %
  eval([inputname(1), '=arg;']);                                          %
  eval(['display(', inputname(1), ');']);                                 %
  return;                                                                 %
end                                                                       %
                                                                          %
% Default values                                                          %
num_spaces = 4;                                                           %
num_digits = 5;                                                           %
                                                                          %
%--------------------------------------------------------------------------
% Determine class of cell elements                                        %
%--------------------------------------------------------------------------
                                                                          %
cellArg = arg(:);                                                         %
                                                                          %
isNumChar        = false(length(cellArg), 12);                            %
isNumChar(:, 1)  = cellfun('isclass', cellArg, 'char'   );                %
isNumChar(:, 2)  = cellfun('isclass', cellArg, 'double' );                %
isNumChar(:, 3)  = cellfun('isclass', cellArg, 'single' );                %
isNumChar(:, 4)  = cellfun('isclass', cellArg, 'uint8'  );                %
isNumChar(:, 5)  = cellfun('isclass', cellArg, 'uint16' );                %
isNumChar(:, 6)  = cellfun('isclass', cellArg, 'uint32' );                %
isNumChar(:, 7)  = cellfun('isclass', cellArg, 'uint64' );                %
isNumChar(:, 8)  = cellfun('isclass', cellArg, 'int8'   );                %
isNumChar(:, 9)  = cellfun('isclass', cellArg, 'int16'  );                %
isNumChar(:, 10) = cellfun('isclass', cellArg, 'int32'  );                %
isNumChar(:, 11) = cellfun('isclass', cellArg, 'int64'  );                %
isNumChar(:, 12) = cellfun('isclass', cellArg, 'logical');                %
                                                                          %
% Number of elements in cell element                                      %
numElmt             = cellfun('prodofsize', cellArg);                     %
                                                                          %
% Remove number cells with vectors (more than a scalar)                   %
isNumChar(:, 2:end) = isNumChar(:, 2:end) & repmat(numElmt <= 1, 1, 11);  %
                                                                          %
% Number elements                                                         %
isNum               = ~~sum(isNumChar(:, 2:end), 2);                      %
                                                                          %
% Cell elements                                                           %
cellElements        = cellfun('isclass', cellArg, 'cell');                %
                                                                          %
% Empty elements                                                          %
emptyElements       = cellfun('isempty', cellArg);                        %
emptyCells          = emptyElements & cellElements;                       %
emptyNums           = emptyElements & isNum;                              %
                                                                          %
% All other objects (including objects with more than one element)        %
isObj               = xor(emptyCells, ~sum(isNumChar, 2));                %
                                                                          %
% Discard empty number elements. These will be processed separately.      %
isNumChar(isNumChar & repmat(emptyNums, 1, size(isNumChar, 2))) = false;  %
                                                                          %
%--------------------------------------------------------------------------
% Deal with empty elements                                                %
%--------------------------------------------------------------------------
if any(emptyCells)                                                        %
  cellArg(emptyCells) = {'{}'};                                           %
end                                                                       %
                                                                          %
if any(emptyNums)                                                         %
  cellArg(emptyNums)  = {'[]'};                                           %
end                                                                       %
                                                                          %
%--------------------------------------------------------------------------
% Deal with numeric elements                                              %
%--------------------------------------------------------------------------
                                                                          %
numID = logical(sum(isNumChar(:, 2:end), 2));                             %
if ~isempty(find(numID, 1))                                               %
                                                                          %
  TOdouble = repmat(NaN, length(cellArg), 1);                             %
                                                                          %
  % Convert the numeric/logical values to double                          %
  useIDX = find(sum(isNumChar(:, 2:end), 1));                             %
  % Only parse through valid types                                        %
  for iType = useIDX + 1                                                  %
    TOdouble(isNumChar(:, iType), 1) = ...                                %
      double([cellArg{isNumChar(:, iType)}]');                            %
  end                                                                     %
                                                                          %
  TOdouble(~numID) = [];                                                  %
  % Convert DOUBLE to strings and put brackets around them                %
  try                                                                     %
    tmp = strcat({'['}, num2str(TOdouble, num_digits), {']'});            %
  catch                                                                   %
    rethrow(lasterror);                                                   %
  end                                                                     %
  cellArg(numID) = tmp;                                                   %
end                                                                       %
                                                                          %
%--------------------------------------------------------------------------
% Deal with string elements                                               %
%--------------------------------------------------------------------------
% Put single quotes around the strings                                    %
stringCell = strcat({''''}, cellArg(isNumChar(:, 1)), {''''});            %
cellArg(isNumChar(:, 1)) = stringCell;                                    %
                                                                          %
%--------------------------------------------------------------------------
% Deal with elements other than string or numeric                         %
%--------------------------------------------------------------------------
objID = find(isObj);                                                      %
objCell = cell(length(objID), 1);                                         %
for iObj = 1:length(objID)                                                %
  sz = size(cellArg{objID(iObj)});                                        %
  cl = class(cellArg{objID(iObj)});                                       %
  % Display size and class type, wrapped by brackets                      %
  switch cl                                                               %
    case 'cell'                                                           %
      if length(sz) < 4                                                   %
        objCell{iObj} = ['{', sprintf('%dx', sz(1:end-1)), ...            %
            num2str(sz(end)), sprintf(' %s}', cl)];                       %
      else                                                                %
        objCell{iObj} = sprintf('{%d-D %s}', length(sz), cl);             %
      end                                                                 %
    otherwise                                                             %
      if length(sz) < 4                                                   %
        objCell{iObj} = ['[', sprintf('%dx', sz(1:end-1)), ...            %
            num2str(sz(end)), sprintf(' %s]', cl)];                       %
      else                                                                %
        objCell{iObj} = sprintf('[%d-D %s]', length(sz), cl);             %
      end                                                                 %
  end                                                                     %
end                                                                       %
cellArg(isObj) = objCell;                                                 %
                                                                          %
% Reconstruct the original size                                           %
arg = reshape(cellArg, size(arg));                                        %
                                                                          %
%--------------------------------------------------------------------------
% Create FPRINTF format string based on length of strings                 %
%--------------------------------------------------------------------------
char_len = cellfun('length', arg);                                        %
if 0  % Change this to 1 in order to right justify numeric elements.      %
      % This will be slightly slower.                                     %
  conv_str = '    ';                                                      %
  for iCol = 1:size(arg, 2);                                              %
    if length(unique(char_len(:, iCol))) == 1                             %
      conv_str = [conv_str, ...                                           %
          sprintf('%%-%ds%s', unique(char_len(:, iCol)), ...              %
          blanks(num_spaces))];                                           %
    else                                                                  %
      tmp = char(arg(:, iCol));                                           %
      idx1 = strfind(tmp(:, 1)', '[');                                    %
      idx2 = strfind(tmp(:, 1)', '{');                                    %
      tmp([idx1 idx2], :) = strjust(tmp([idx1 idx2], :), 'right');        %
      arg(:, iCol) = cellstr(tmp);                                        %
      conv_str = [conv_str, ...                                           %
          sprintf('%%-%ds%s', max(char_len(:, iCol)), ...                 %
          blanks(num_spaces))];                                           %
    end                                                                   %
  end                                                                     %
else                                                                      %
  % Create array of max character lengths and blank pads                  %
  char_max = [num2cell(max(char_len, [], 1)); ...                         %
      repmat({blanks(num_spaces)}, 1, size(char_len, 2))];                %
  conv_str = ['    ', sprintf('%%-%ds%s', char_max{:})];                  %
end                                                                       %
                                                                          %
% Add carrige return at the end                                           %
conv_str = [conv_str(1 : end - num_spaces) '\n'];                         %
                                                                          %
%--------------------------------------------------------------------------
% Display in command window                                               %
%--------------------------------------------------------------------------
                                                                          %
% Must transpose for FPRINTF to work                                      %
arg = arg';                                                               %
                                                                          %
% If arg is a single EMPTY cell/string/numeric element,                   %
% then wrap it with {}                                                    %
if length(arg) == 1                                                       %
  switch arg{1}                                                           %
    case {'{}', '''''', '[]'}                                             %
      conv_str = '    {%s}\n';                                            %
  end                                                                     %
end                                                                       %
                                                                          %
try                                                                       %
  % Wrap around TRY ... END in case the user quits out of MORE            %
  fprintf(1, conv_str, arg{:});                                           %
  if isequal(get(0,'FormatSpacing'),'loose')                              %
    disp(' ');                                                            %
  end                                                                     %
catch                                                                     %
end                                                                       %
                                                                          %
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------