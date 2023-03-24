function vol = PointsVolume(X)
% PointsVolume - Function that calculates the hypervolume of a set of
% Points.
% 
% Syntax:  
%    vol = PointsVolume(X)
%
% Inputs:
%    X - Points
%
% Outputs:
%    vol - volume
%
% Example: 
%    m = 10;
%    X = rand(2,m);
%    vol = PointsVolume(X)
%
% Other m-files required: convhull.m.
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

n = size(X,1);

if n == 1
    vol = max(X)-min(X);
elseif (1 < n) && (n <= 3)
    [~,vol] = convhull(X','Simplify',true);
else
    [~,vol] = convhulln(X','Simplify',true);
end
end

