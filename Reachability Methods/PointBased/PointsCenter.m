function c = PointsCenter(X)
% PointsCenter - Function that calculates the center of a set of Points as
% the mean of them.
% 
% Syntax:  
%    c = PointsCenter(X)
%
% Inputs:
%    X - Points
%
% Outputs:
%    c - mean center 
%
% Example: 
%    m = 10;
%    X = rand(2,m);
%    c = PointsCenter(X) 
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

c = mean(X,2);

end

