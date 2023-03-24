function Z = intervalMinkowskiSum(X,Y)
% intervalMinkowskiSum - Function that calculates the Minkowski sum of two Intervals.
% 
% Syntax:  
%    Z = intervalMinkowskiSum(X,Y)
%
% Inputs:
%    X - Interval
%    Y - Interval
%
% Outputs:
%    Z - Interval that Z = {z = x+y: x \in X, y \in Y}
%
% Example: 
%    X.midpoints = ones(2,1);
%    X.radius = 2*ones(2,1);
%    Y = X;
%    Z = intervalMinkowskiSum(X,Y);
%    [Fx,px] = compileInterval(X);
%    [Fy,py] = compileInterval(Y);
%    [Fz,pz] = compileInterval(Z);
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


Z.midpoints = X.midpoints + Y.midpoints;
Z.radius = X.radius + Y.radius;
end

