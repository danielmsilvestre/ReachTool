function total = intervalNbDoubles(X)
% intervalNbDoubles - Function that calculates the amount of double variables
% used in the data structures to store an Interval.
% 
% Syntax:  
%    total = intervalNbDoubles(X)
%
% Inputs:
%    X - Interval
%
% Outputs:
%    total - size is constant and equal to 2n
%
% Example: 
%    X.midpoints = ones(2,1);
%    X.radius = 2*ones(2,1);
%    nb_doubles = intervalNbDoubles(X) % 2*2
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

total = size(X.midpoints,1) + size(X.radius,1);
end

