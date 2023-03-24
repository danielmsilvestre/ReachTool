function Z = PolyMinkowskiSum(X,Y)
% PolyMinkowskiSum - Function that calculates the Minkowski sum of two
% Polytopes.
% 
% Syntax:  
%    Z = PolyMinkowskiSum(X,Y)
%
% Inputs:
%    X - Polytope
%    Y - Polytope
%
% Outputs:
%    Z - Polytope that Z = {z = x+y: x \in X, y \in Y}
%
% Example: 
%    m = 10;
%    X.n = 2;
%    X.A = randn(m,2);
%    X.b = rand(m,1)*m;
%    X.Aeq = zeros(0,2);
%    X.beq = zeros(0,1);
%    Y.n = 2;
%    Y.A = randn(m,2);
%    Y.b = rand(m,1)*m;
%    Y.Aeq = zeros(0,2);
%    Y.beq = zeros(0,1);
%    Z = PolyMinkowskiSum(X,Y);
%    [Fx,px] = compilePoly(X);
%    [Fy,py] = compilePoly(Y);
%    [Fz,pz] = compilePoly(Z);
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

n = X.n;

Z.A = [zeros(size(X.A,1)+size(Y.A,1),n),blkdiag(X.A,Y.A)];
Z.b = [X.b;Y.b];
Z.Aeq = [eye(n) -eye(n) zeros(n,size(X.Aeq,2)-n) -eye(n) zeros(n,size(Y.Aeq,2)-n);
         zeros(size(X.Aeq,1)+size(Y.Aeq,1),n) blkdiag(X.Aeq,Y.Aeq)];
% if isempty(Y.Aeq) && ~isempty(X.Aeq)
%     Z.Aeq = [eye(n) -eye(n) zeros(n,size(X.Aeq,2)-n) -eye(n) zeros(n,size(Y.Aeq,2)-n);
%          zeros(size(X.Aeq,1)+size(Y.Aeq,1),n) X.Aeq,zeros(size(X.Aeq,1),size(Y.A,2))];
% elseif ~isempty(Y.Aeq) && ~isempty(X.Aeq)
%     Z.Aeq = [eye(n) -eye(n) zeros(n,size(X.Aeq,2)-n) -eye(n) zeros(n,size(Y.Aeq,2)-n);
%          zeros(size(X.Aeq,1)+size(Y.Aeq,1),n) blkdiag(X.Aeq,Y.Aeq)];
% elseif isempty(Y.Aeq) && isempty(X.Aeq)
%     Z.Aeq = [eye(n) -eye(n) zeros(n,size(X.Aeq,2)-n) -eye(n) zeros(n,size(Y.Aeq,2)-n)];     
% else
%     Z.Aeq = [eye(n) -eye(n) zeros(n,size(X.Aeq,2)-n) -eye(n) zeros(n,size(Y.Aeq,2)-n);
%          zeros(size(X.Aeq,1)+size(Y.Aeq,1),n) zeros(size(Y.Aeq,1),size(X.A,2)),Y.Aeq];
% end
Z.beq = [zeros(n,1);X.beq;Y.beq];
Z.n = n;
end

