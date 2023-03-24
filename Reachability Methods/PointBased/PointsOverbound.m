function X = PointsOverbound(set)
% PointsOverbound - Function returning trivial Points overbounding
% simple sets like norm balls.
% 
% Syntax:  
%    X = PointsOverbound(set)
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
%    set.subtype = inf;
%    set.radius = 3;
%    X = PointsOverbound(set)
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
        if set.subtype == 1
            X = set.radius.*[eye(set.n),-eye(set.n)];
        else
            X = set.radius.*permn([-1,1],set.n)';
        end
    otherwise
        error('Not implemented the overbounding function for this type of set.');
end
end

