function Y = ZonotopeLinMap(A,X,t)
% ZonotopeLinMap - Function that calculates the linear map AX + t for 
% Zonotope X.
%  
% Syntax:  
%    Y = ZonotopeLinMap(A,X,t)
%
% Inputs:
%    A - A matrix 
%    X - Zonotope
%    t - translation vector
%
% Outputs:
%    Y - Points that Y = {y = A*x + t: x \in X}
%
% Example: 
%    m = 10;
%    X.H = rand(2,m);
%    X.p = zeros(2,1);
%    Y = ZonotopeLinMap(2*eye(2),X,zeros(2,1));
%    [Fx,px] = compileZonotope(X);
%    [Fy,py] = compileZonotope(Y);
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

Y.H = A * X.H;
Y.p = A * X.p + t;
end

