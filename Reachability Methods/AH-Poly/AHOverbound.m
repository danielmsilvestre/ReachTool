function X = AHOverbound(set)
% AHOverbound - Function returning trivial A-H polytopes overbounding
% simple sets like norm balls.
% 
% Syntax:  
%    X = AHOverbound(set)
%
% Inputs:
%    set - data structure with:
%       n - dimension
%       type - type of simple set
%       radius - length of the set
%
% Outputs:
%    X - for any ball it will output a l_inf ball of length radius
%
% Example: 
%    set.n = 2;
%    set.type = 'ball';
%    set.radius = 3;
%    X = AHOverbound(set)
%
% Other m-files required: none.
% Subfunctions: none
% MAT-files required: none
%
% See also: none.
 
% Copyright 2023 Daniel Silvestre
% This file is part of ReachTool.
%
% ReachTool is free software: you can redistribute it and/or modify 
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% ReachTool is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with ReachTool.  If not, see <https://www.gnu.org/licenses/>.

 
%------------- BEGIN CODE --------------

n = set.n;
switch lower(set.type)
    case 'ball'
        X = struct('G',eye(n),'c',zeros(n,1),'H',kron([1;-1],eye(n)),'h',kron(ones(2,1),set.radius));
    otherwise
        error('Not implemented the overbounding function for AH sets.');
end
end

