function X = CZOverbound(set)
% CZOverbound - Function returning trivial Constrained Zonotope overbounding
% simple sets like norm balls.
% 
% Syntax:  
%    X = CZOverbound(set)
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
%    X = CZOverbound(set)
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

switch lower(set.type)
    case 'ball'
        X = struct('G',diag(set.radius),'c',zeros(set.n,1),'A',zeros(0,length(set.radius)),'b',zeros(0,1));
    otherwise
        error('Not implemented the overbounding function for Constrained Zonotope sets.');
end
end

