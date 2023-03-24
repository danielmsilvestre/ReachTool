function [F,p] = compileZonotope(X)
% compileZonotope - Function returning a Yalmip constraint set representing the
% Zonotope.
%   
%   Z = {z = G*xi+c: A*xi <= b, ||xi||_inf <= 1}
% 
% Syntax:  
%    [F,p] = compileZonotope(Z)
%
% Inputs:
%    Z - Zonotope
%
% Outputs:
%    F - Yalmip constraint set
%    p - sdpvar representing a point in Z.
%
% Example: 
%    m = 10;
%    X.H = rand(2,m);
%    X.p = zeros(2,1);
%    [F,p] = compileZonotope(X);
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

[n,m] = size(X.H);
x = sdpvar(m,1);
p = sdpvar(n,1);

if ~isnan(X.H)
    F = [norm(x,inf) <= 1, p == X.H * x + X.p];
else
     F = [p >= 1, p <= -1];
end

end

