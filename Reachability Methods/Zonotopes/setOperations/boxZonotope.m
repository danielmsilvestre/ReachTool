function Zbox = boxZonotope(Z)
% boxZonotope - Function that calculates the Interval that overbounds the
% Zonotope Z.
% multiplied by matrix C would be in Y.
% 
% Syntax:  
%    Zbox = boxZonotope(Z)
%
% Inputs:
%    Z - Zonotope
%
% Outputs:
%    Zbox - Zonotope matching an Interval
%
% Example: 
%    m = 10;
%    X.H = rand(2,m);
%    X.p = zeros(2,1);
%    Z = boxZonotope(X);
%    [Fx,px] = compileZonotope(X);
%    [Fz,pz] = compileZonotope(Z);
%    plot(Fz,pz,'b');hold on;
%    plot(Fx,px);
%
% Other m-files required: unionHull.m.
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


Zbox.p = Z.p;
Zbox.H = diag(sum(abs(Z.H),2)');

end

