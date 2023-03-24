function total = PointsNbDoubles(X)
% PointsNbDoubles - Function that calculates the amount of double variables
% used in the data structures to store Points.
% 
% Syntax:  
%    total = PointsNbDoubles(X)
%
% Inputs:
%    X - Points
%
% Outputs:
%    total - number of points times the size of the state space
%
% Example: 
%    m = 10;
%    X = rand(2,m);
%    nb_doubles = PointsNbDoubles(X) % (2*10)
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

[n,m] = size(X);

total = n*m;
end

