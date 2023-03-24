function Z = ZonotopeMinkowskiSum(X,Y)
% ZonotopeMinkowskiSum - Function that calculates the Minkowski sum of two
% Zonotopes.
% 
% Syntax:  
%    Z = ZonotopeMinkowskiSum(X,Y)
%
% Inputs:
%    X - Zonotope
%    Y - Zonotope
%
% Outputs:
%    Z - Zonotope that Z = {z = x+y: x \in X, y \in Y}
%
% Example: 
%    m = 10;
%    X.H = rand(2,m);
%    X.p = zeros(2,1);
%    Y.H = rand(2,m);
%    Y.p = zeros(2,1);
%    Z = ZonotopeMinkowskiSum(X,Y);
%    [Fx,px] = compileZonotope(X);
%    [Fy,py] = compileZonotope(Y);
%    [Fz,pz] = compileZonotope(Z);
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

Z.H = [X.H Y.H];
Z.p = X.p + Y.p;

end

