function Z = CZcvxHull(X,Y)
% CZcvxHull - Function that calculates the convex hull of two Constrained
% Zonotopes.
% 
% Syntax:  
%    Z = CZcvxHull(X,Y)
%
% Inputs:
%    X - Constrained Zonotope
%    Y - Constrained Zonotope
%
% Outputs:
%    Z - Constrained Zonotope that Z = {z = lambda*x+(1-lambda)*y: x \in X, y \in Y}
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    Y = X;
%    Y.G = rand(2,m);
%    Z = CZcvxHull(X,Y);
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


n1 = size(X.G,2);
n2 = size(Y.G,2);

A31 = [eye(n1);-eye(n1);zeros(2*n2,n1)];
A32 = [zeros(2*n1,n2);eye(n2);-eye(n2)];
A30 = [-0.5*ones(2*n1,1);0.5*ones(2*n2,1)];

Z.G = [X.G Y.G (X.c-Y.c)/2 zeros(size(X.G,1),2*(n1+n2))];
Z.c = (X.c+Y.c)/2;
Z.A = [blkdiag(X.A,Y.A),[-X.b/2;Y.b/2],zeros(size(X.A,1)+size(Y.A,1),2*(n1+n2));
       A31,A32,A30,eye(2*(n1+n2))];
Z.b = [0.5*X.b;0.5*Y.b;-0.5*ones(2*(n1+n2),1)];


end

