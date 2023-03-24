function total = PolyNbDoubles(X)
% PolyNbDoubles - Function that calculates the amount of double variables
% used in the data structures to store Polytope.
% 
% Syntax:  
%    total = PolyNbDoubles(X)
%
% Inputs:
%    X - Polytope
%
% Outputs:
%    total - number of points times the size of the state space
%
% Example: 
%    m = 10;
%    X.n = 2;
%    X.A = randn(m,2);
%    X.b = rand(m,1)*m;
%    X.Aeq = zeros(0,2);
%    X.beq = zeros(0,1);
%    nb_doubles = PolyNbDoubles(X) % (10*2) + (10*1) + (0*2) + (0*1)
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


[np,n] = size(X.A);
[npeq,neq] = size(X.Aeq);

total = np*(n + 1) + npeq*(neq + 1);
end

