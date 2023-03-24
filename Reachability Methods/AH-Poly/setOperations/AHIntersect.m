function Z = AHIntersect(C, X, Y)
% AHIntersect - Function that calculates the points in X such that if
% multiplied by matrix C would be in Y.
% 
% Syntax:  
%    nextX = AHIntersect(C, X, Y)
%
% Inputs:
%    C - measurement matrix
%    X - A-H polytope
%    Y - A-H polytope
%
% Outputs:
%    Z - A-H polytope that Z = {z: z \in X,  Cz \in Y}
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.H = [eye(m);-eye(m)];
%    X.h = ones(2*m,1);
%    Y = X;
%    Y.G = rand(2,m);
%    Z = AHIntersect(2*eye(2),X,Y);
%    [Fx,px] = compileAH(X);
%    [Fy,py] = compileAH(Y);
%    [Fz,pz] = compileAH(Z);
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

n2 = size(Y.H,2);
n = size(X.G,1);

Z.G = [X.G,zeros(n,n2)];
Z.c = X.c;
Z.H = [X.H zeros(size(X.H,1),n2);
           Y.H*pinv(Y.G)*C*X.G, Y.H*(eye(n2) - pinv(Y.G)*Y.G)];
Z.h = [X.h;Y.h + Y.H*pinv(Y.G)*(Y.c - C*X.c)];

% easy order reduction when there is no need to add extra auxiliary
% variables
if all(Y.H*(eye(n2) - pinv(Y.G)*Y.G)==0)
    Z.G = Z.G(:,1:end-n2);
    Z.H = Z.H(:,1:end-n2);
end
end

