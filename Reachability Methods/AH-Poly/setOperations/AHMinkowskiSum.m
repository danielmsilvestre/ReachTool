function Z = AHMinkowskiSum(X,Y)
% AHcvxHull - Function that calculates the Minkowski sum of two A-H polytopes.
% 
% Syntax:  
%    Z = AHMinkowskiSum(X,Y)
%
% Inputs:
%    X - A-H polytope
%    Y - A-H polytope
%
% Outputs:
%    Z - A-H polytope that Z = {z = x+y: x \in X, y \in Y}
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.H = [eye(m);-eye(m)];
%    X.h = ones(2*m,1);
%    Y = X;
%    Y.G = rand(2,m);
%    Z = AHMinkowskiSum(X,Y);
%    [Fx,px] = compileAH(X);
%    [Fy,py] = compileAH(Y);
%    [Fz,pz] = compileAH(Z);
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

Z.G = [X.G,Y.G];
Z.c = X.c + Y.c;
Z.H = blkdiag(X.H,Y.H);
Z.h = [X.h;Y.h];
end

