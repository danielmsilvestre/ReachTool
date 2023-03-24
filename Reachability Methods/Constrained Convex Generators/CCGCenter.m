function c = CCGCenter(X)
% CCGCenter - Function that calculates the center of a Constrained Convex Generator
% by either returning the translation vector c or finding the minimum norm
% solution to the constrained generators and then applying the linear map.
%
% xi^start = min || xi ||_2
%             xi
%            s.t. X.A xi == X.b
% 
% center = X.G * xi^star + X.c.
%
% Notice that xi^star can be found in closed-form as:
% xi^star = (X.A'*((X.A*X.A')\X.b)).
% 
% Syntax:  
%    c = CCGCenter(X)
%
% Inputs:
%    X - Constrained Convex Generator
%
% Outputs:
%    c - minimum norm center 
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    X.idx = [5 5];
%    X.type = [2 inf];
%    c = CCGCenter(X) % zero vector given that there are no constraints
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

if isempty(X.A)
    c = X.c;
else
    c = X.G * (X.A'*((X.A*X.A')\X.b)) + X.c;
end
end

