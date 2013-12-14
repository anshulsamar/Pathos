function display(arg)
%DISPLAY Display method for cell arrays.
%
%   DISPLAY(ARG) displays cell arrays.
%
%   See also CELL\DISP.

%   Jiro Doke
%   Copyright 2006-2010 The MathWorks, Inc.

isLoose = isequal(get(0,'FormatSpacing'),'loose');

if ndims(arg) > 2
  sz = size(arg);
  id = cell(ndims(arg) - 2, 1);
else
  sz = [0 0 1];
end

for ii = 1:prod(sz(3:end))
  if exist('id', 'var')
    [id{:}] = ind2sub(sz(3:end), ii);
    str = ['(:,:', sprintf(',%d', id{:}), ')'];
    this_arg = arg(:,:,id{:});
  else
    this_arg = arg;
    str = '';
  end
  if ~isempty(inputname(1))
    if isLoose
      disp(' ');
      fprintf('%s%s =\n', inputname(1), str);
      disp(' ');
    else
      fprintf('%s%s =\n', inputname(1), str);
    end
  end
  
  if isequal(size(this_arg), [0 0])
    disp('     {}');
    if isLoose;disp(' ');end
  elseif ismember(0, size(this_arg))
    fprintf('   Empty cell array: %d-by-%d\n', size(this_arg));
    if isLoose;disp(' ');end
  else
    disp(this_arg);
  end
  
end
