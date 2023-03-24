function [F,p] = compilePoly(X)
% compilePoly - Function returning a Yalmip constraint set representing the
% Polytope.
%   
%   Z = {z = G*xi+c: A*xi <= b, ||xi||_inf <= 1}
% 
% Syntax:  
%    [F,p] = compilePoly(Z)
%
% Inputs:
%    Z - Polytope
%
% Outputs:
%    F - Yalmip constraint set
%    p - sdpvar representing a point in Z.
%
% Example: 
%    m = 10;
%    X.n = 2;
%    X.A = randn(m,2);
%    X.b = rand(m,1)*m;
%    X.Aeq = zeros(0,2);
%    X.beq = zeros(0,1);
%    [F,p] = compilePoly(X);
%    plot(F,p);
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

p = sdpvar(X.n,1); % actual variable
paux = sdpvar(size(X.A,2)-X.n,1); % auxiliary variables
pn = [p;paux]; % set is written in the higher space of variables and auxiliary variables

if ~isempty(X.Aeq)
    F = [X.A*pn<=X.b,X.Aeq * pn == X.beq];
else
    F = X.A*pn<=X.b;
end
end

