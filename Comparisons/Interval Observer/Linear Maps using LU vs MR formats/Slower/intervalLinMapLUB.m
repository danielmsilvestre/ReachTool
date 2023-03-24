function Y = intervalLinMapLUB(A,X,t)
% intervalLinMapLUB - Function that applies a linear map to an interval
% 
% Syntax:  
%    Y = intervalLinMapLUB(A,X,t)
%
% Inputs:
%    A - some matrix representing the affine part of the linear map
%    t - a vector representing the constant part of the linear map
%    X - interval represented as a structure with lower and upper bounds lb
%    and  ub
%
% Outputs:
%    Y - interval such that Y = A * X + t
%
% Example: 
%    X.lb = [-1, 2];
%    X.ub = [3, 4];
%    t = ones(2,1);
%    Y = intervalLinMapLUB(rand(2),X,t);
%
% Other m-files required: iaprod.m
% Subfunctions: none
% MAT-files required: none
%
% See also: comparisonMRvsLUB.m (script showing that this format is less
% efficient than midpoint and radius representation that is implemented for
% interval observers).
 
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

Y.lb = zeros(size(A,1),1);
Y.ub = zeros(size(A,1),1);

for i = 1:size(A,1)
    xinterval = zeros(2,1);
    for j = 1:size(A,2)
        xinterval = xinterval + iaprod(A(i,j),[X.lb(j);X.ub(j)]);
    end
    Y.lb(i) = xinterval(1,1) + t(i);
    Y.ub(i) = xinterval(2,1) + t(i);
end


end

