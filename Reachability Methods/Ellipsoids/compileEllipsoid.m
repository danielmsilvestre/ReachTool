function [F,p] = compileEllipsoid(Z)
% compileEllipsoid - Function returning a Yalmip constraint set representing the
% Ellipsoid.
%   
%   Z = {z: (z-X.c)'/X.Q*(z-X.c) <= 1}, for some shape Q and center c.
% 
% Syntax:  
%    [F,p] = compileEllipsoid(Z)
%
% Inputs:
%    Z - Ellipsoid
%
% Outputs:
%    F - Yalmip constraint set
%    p - sdpvar representing a point in Z.
%
% Example: 
%    radius = 2;
%    X = struct('Q',diag(radius.^2),'c',zeros(2,1));
%    [F,p] = compileEllipsoid(X);
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

n = length(Z.c);
p = sdpvar(n,1);

F = (p-Z.c)'/Z.Q*(p-Z.c) <= 1;

end

