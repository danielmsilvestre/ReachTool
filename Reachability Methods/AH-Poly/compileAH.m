function [F,p] = compileAH(Z)
% compileAH - Function returning a Yalmip constraint set representing the
% A-H polytope.
%   
%   Z = {z=G*xi+c: H*xi<=z}
% 
% Syntax:  
%    [F,p] = compileAH(Z)
%
% Inputs:
%    Z - A-H polytope
%
% Outputs:
%    F - Yalmip constraint set
%    p - sdpvar representing a point in Z.
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.H = [eye(m);-eye(m)];
%    X.h = ones(2*m,1);
%    [F,p] = compileAH(X);
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

n = size(Z.G,1);

p = sdpvar(n,1);

xi = sdpvar(size(Z.G,2),1);

F = [p == Z.G * xi + Z.c, Z.H * xi <= Z.h];
end

