function X = EllipsoidsOverbound(set)
% EllipsoidsOverbound - Function returning trivial Ellipsoid overbounding
% simple sets like norm balls.
% 
% Syntax:  
%    X = EllipsoidsOverbound(set)
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
%    X = EllipsoidsOverbound(set)
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
        v = norm(ones(set.n,1)./norm(ones(set.n,1),set.subtype),2);
        X = struct('Q',diag((set.radius*v).^2),'c',zeros(set.n,1));    
    otherwise
        error('Not implemented the overbounding function for Ellipsoidal sets.');
end
end

