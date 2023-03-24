function Z = AHcvxHull(X,Y)
% AHcvxHull - Function that calculates the convex hull of two A-H
% polytopes.
% 
% In the constraints we are not adding 0 <= lambda <= 1 because it is
% assumed that the original polytope H xi <= h includes the origin making 
% h >= 0. For that reason, if lambda < 0 it makes the generator set of X
% empty and if lambda > 1 it makes the generator set of Y empty.
% 
% Syntax:  
%    Z = AHcvxHull(X,Y)
%
% Inputs:
%    X - A-H polytope
%    Y - A-H polytope
%
% Outputs:
%    Z - A-H polytope that Z = {z = lambda*x+(1-lambda)*y: x \in X, y \in Y}
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.H = [eye(m);-eye(m)];
%    X.h = ones(2*m,1);
%    Y = X;
%    Y.G = rand(2,m);
%    Z = AHcvxHull(X,Y);
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

Z.G = [X.G, Y.G, (X.c-Y.c)];
Z.c = Y.c;
Z.H = [blkdiag(X.H,Y.H),[-X.h;Y.h]];
Z.h = [zeros(size(X.H,1),1);Y.h];

end

