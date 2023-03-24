function total = ZonotopeNbDoubles(X)
% ZonotopeNbDoubles - Function that calculates the amount of double variables
% used in the data structures to store Zonotope.
% 
% Syntax:  
%    total = ZonotopeNbDoubles(X)
%
% Inputs:
%    X - Zonotope
%
% Outputs:
%    total - number of points times the size of the state space
%
% Example: 
%    m = 10;
%    X.H = rand(2,m);
%    X.p = zeros(2,1);
%    nb_doubles = ZonotopeNbDoubles(X) % (2*10)+2
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


[n,m] = size(X.H);

total = n * (m + 1);
end

