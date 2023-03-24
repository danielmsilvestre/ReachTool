function Z = CZMinkowskiSum(X,Y)
% CZMinkowskiSum - Function that calculates the Minkowski sum of two
% Constrained Zonotopes.
% 
% Syntax:  
%    Z = CZMinkowskiSum(X,Y)
%
% Inputs:
%    X - Constrained Zonotope
%    Y - Constrained Zonotope
%
% Outputs:
%    Z - Constrained Zonotope that Z = {z = x+y: x \in X, y \in Y}
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    Y = X;
%    Y.G = rand(2,m);
%    Z = CZMinkowskiSum(X,Y);
%    [Fx,px] = compileCZ(X);
%    [Fy,py] = compileCZ(Y);
%    [Fz,pz] = compileCZ(Z);
%    plot(Fz,pz,'b');hold on;
%    plot(Fx,px);
%    plot(Fy,py);
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

Z.G = [X.G Y.G];
Z.c = X.c + Y.c;
Z.A = blkdiag(X.A, Y.A);
Z.b = [X.b; Y.b];

end

