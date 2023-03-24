function [F,p] = compileCZ(Z)
% compileCZ - Function returning a Yalmip constraint set representing the
% Constrained Zonotope.
%   
%   Z = {z = G*xi+c: A*xi = b, ||xi||_inf <= 1}
% 
% Syntax:  
%    [F,p] = compileCZ(Z)
%
% Inputs:
%    Z - Constrained Zonotope
%
% Outputs:
%    F - Yalmip constraint set
%    p - sdpvar representing a point in Z.
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    [F,p] = compileCZ(X);
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

[n, g] = size(Z.G);

p = sdpvar(n,1);

xi = sdpvar(g,1);

% Check whether there are constraints that need to be added.
if isempty(Z.A)
    F = [norm(xi, inf) <= 1, p == Z.G * xi + Z.c];
else
    F = [norm(xi, inf) <= 1, Z.A * xi == Z.b, p == Z.G * xi + Z.c];
end


end

