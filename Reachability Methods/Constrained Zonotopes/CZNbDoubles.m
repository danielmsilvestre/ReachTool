function total = CZNbDoubles(X)
% CZNbDoubles - Function that calculates the amount of double variables
% used in the data structures to store a Constrained Zonotope.
% 
% Syntax:  
%    total = CZNbDoubles(X)
%
% Inputs:
%    X - Constrained Zonotope
%
% Outputs:
%    total - number of elements in the G and A matrices and c and b vectors
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    nb_doubles = CZNbDoubles(X) % (2*10) + (2*1) + (0*10) + (0*1)
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

[n,ng] = size(X.G);
nc = size(X.A,1);

total = (n + nc) * (ng + 1);
end

