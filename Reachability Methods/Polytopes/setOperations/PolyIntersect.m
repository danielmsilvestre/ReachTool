function nextX = PolyIntersect(C, X, Y)
% PolyIntersect - Function that calculates the points in X such that if
% multiplied by matrix C would be in Y.
% 
% Syntax:  
%    nextX = PolyIntersect(C, X, Y)
%
% Inputs:
%    C - measurement matrix
%    X - Polytope
%    Y - Polytope
%
% Outputs:
%    Z - Polytope that Z = {z: z \in X,  Cz \in Y}
%
% Example: 
%    m = 10;
%    X.n = 2;
%    X.A = randn(m,2);
%    X.b = rand(m,1)*m;
%    X.Aeq = zeros(0,2);
%    X.beq = zeros(0,1);
%    Y = X;
%    Y.A = randn(m,2);
%    Z = PolyIntersect(2*eye(2),X,Y);
%    [Fx,px] = compilePoly(X);
%    [Fy,py] = compilePoly(Y);
%    [Fz,pz] = compilePoly(Z);
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

n = X.n;

nextX.A = blkdiag(X.A,Y.A);
nextX.b = [X.b;Y.b];
nextX.Aeq = [blkdiag(X.Aeq,Y.Aeq);C zeros(size(C,1),size(X.A,2)-n) -eye(Y.n) zeros(size(C,1),size(Y.A,2)-Y.n)];
% nextX.Aeq = [cblkdiag(X.Aeq,Y.Aeq,size(X.A,2),size(Y.A,2));C zeros(size(C,1),size(X.A,2)-n) -eye(Y.n) zeros(size(C,1),size(Y.A,2)-Y.n)];
nextX.beq = [X.beq;Y.beq;zeros(size(C,1),1)];
nextX.n = n;

end

