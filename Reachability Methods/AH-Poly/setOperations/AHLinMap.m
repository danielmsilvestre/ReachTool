function Y = AHLinMap(A,X,t)
% AHLinMap - Function that calculates the linear map AX + t for a A-H
% polytope X.
%  
% Syntax:  
%    Y = AHLinMap(A,X,t)
%
% Inputs:
%    A - A matrix 
%    X - A-H polytope
%    t - translation vector
%
% Outputs:
%    Y - A-H polytope that Y = {y = A*x + t: x \in X}
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.H = [eye(m);-eye(m)];
%    X.h = ones(2*m,1);
%    Y = AHLinMap(2*eye(2),X,zeros(2,1));
%    [Fx,px] = compileAH(X);
%    [Fy,py] = compileAH(Y);
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

Y.G = A * X.G;
Y.c = A * X.c + t;
Y.H = X.H;
Y.h = X.h;
end

