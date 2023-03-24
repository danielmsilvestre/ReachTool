function total = AHNbDoubles(X)
% AHNbDoubles - Function that calculates the amount of double variables
% used in the data structures to store a A-H polytope.
% 
% Syntax:  
%    total = AHNbDoubles(X)
%
% Inputs:
%    X - A-H polytope
%
% Outputs:
%    total - number of elements in the H and G matrices and h and c vectors
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.H = [eye(m);-eye(m)];
%    X.h = ones(2*m,1);
%    nb_doubles = AHNbDoubles(X) % (2*10) + (2*1) + (20*10) + (20*1)
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
nc = size(X.H,1);

total = n*(ng+1) + nc*(ng+1);
end

