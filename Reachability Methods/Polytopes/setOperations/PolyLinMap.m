function Y = PolyLinMap(F,X,t)
% PolyLinMap - Function that calculates the linear map AX + t for 
% Polytope X.
%  
% Syntax:  
%    Y = PolyLinMap(A,X,t)
%
% Inputs:
%    A - A matrix 
%    X - Polytope
%    t - translation vector
%
% Outputs:
%    Y - Polytope that Y = {y = A*x + t: x \in X}
%
% Example: 
%    m = 10;
%    X.n = 2;
%    X.A = randn(m,2);
%    X.b = rand(m,1)*m;
%    X.Aeq = zeros(0,2);
%    X.beq = zeros(0,1);
%    Y = PolyLinMap(2*eye(2),X,zeros(2,1));
%    [Fx,px] = compilePoly(X);
%    [Fy,py] = compilePoly(Y);
%    plot(Fy,py,'b');hold on;
%    plot(Fx,px);
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

[r,c] = size(F);

if r == c && rank(F) == r % matrix A is invertible
    Y.A = [X.A(:,1:n) / F, X.A(:,(n+1):end)];
    Y.b = X.b + X.A(:,1:n) / F * t;
    Y.Aeq = [X.Aeq(:,1:n) / F, X.Aeq(:,(n+1):end)];
    Y.beq = X.beq + X.Aeq(:,1:n) / F * t;
%     if ~isempty(X.Aeq)
%         Y.Aeq = [X.Aeq(:,1:n) / F, X.Aeq(:,(n+1):end)];
%         Y.beq = X.beq + X.Aeq(:,1:n) / F * t;
%     else
%         Y.Aeq = [];
%         Y.beq = [];
%     end
    Y.n = r;
else
    Y.A = [zeros(size(X.A,1),r), X.A];
    Y.b = X.b;
    Y.Aeq = [eye(r) -F zeros(r,size(X.Aeq,2)-n);zeros(size(X.Aeq,1),r) X.Aeq];
%     if isempty(X.Aeq)
%         Y.Aeq = [eye(r) -F zeros(r,size(X.Aeq,2)-n)];
%     else
%         Y.Aeq = [eye(r) -F zeros(r,size(X.Aeq,2)-n);zeros(size(X.Aeq,1),r) X.Aeq];
%     end
    Y.beq = [t; X.beq];
    Y.n = r;
end
end

