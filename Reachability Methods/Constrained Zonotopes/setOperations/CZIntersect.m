function nextX = CZIntersect(C, X, Y)
% CZIntersect - Function that calculates the points in X such that if
% multiplied by matrix C would be in Y.
% 
% Syntax:  
%    nextX = CZIntersect(C, X, Y)
%
% Inputs:
%    C - measurement matrix
%    X - Constrained Zonotope
%    Y - Constrained Zonotope
%
% Outputs:
%    Z - Constrained Zonotope that Z = {z: z \in X,  Cz \in Y}
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    Y = X;
%    Y.G = rand(2,m);
%    Z = CZIntersect(2*eye(2),X,Y);
%    [Fx,px] = compileCZ(X);
%    [Fy,py] = compileCZ(Y);
%    [Fz,pz] = compileCZ(Z);
%    plot(Fx,px);hold on;
%    plot(Fy,py);
%    plot(Fz,pz,'b');
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

nextX.G = [X.G zeros(size(X.G,1) , size(Y.G,2))];
nextX.c = X.c;
nextX.A = [blkdiag(X.A,Y.A);C*X.G -Y.G];
nextX.b = [X.b;Y.b;Y.c - C*X.c];

end

