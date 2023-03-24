function [F,p] = compileInterval(Z)
% compileInterval - Function returning a Yalmip constraint set representing the
% Interval.
%   
%   Z = {z = midpoints + v: v \in  [-radius,radius]}
% 
% Syntax:  
%    [F,p] = compileInterval(Z)
%
% Inputs:
%    Z - Interval
%
% Outputs:
%    F - Yalmip constraint set
%    p - sdpvar representing a point in Z.
%
% Example: 
%    X.midpoints = ones(2,1);
%    X.radius = 2*ones(2,1);
%    [F,p] = compileInterval(X);
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

n = size(Z.midpoints,1);

p = sdpvar(n,1);

if ~isnan(Z.midpoints)
    F = -Z.radius <= p - Z.midpoints <= Z.radius;
else
    F = [p >= 1, p <= -1];
end

end

