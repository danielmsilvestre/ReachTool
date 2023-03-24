function Y = intervalLinMap(A,X,t)
% intervalLinMap - Function that calculates the linear map AX + t for an
% Interval.
%  
% Syntax:  
%    Y = intervalLinMap(A,X,t)
%
% Inputs:
%    A - A matrix 
%    X - Interval
%    t - translation vector
%
% Outputs:
%    Y - Interval that Y = {y = A*x + t: x \in X}
%
% Example: 
%    X.midpoints = ones(2,1);
%    X.radius = 2*ones(2,1);
%    Y = intervalLinMap(2*eye(2),X,zeros(2,1));
%    [Fx,px] = compileInterval(X);
%    [Fy,py] = compileInterval(Y);
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

Y.midpoints = A*X.midpoints + t;
Y.radius = abs(A)*X.radius;

end

