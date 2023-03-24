function vol = intervalVolume(X)
% intervalVolume - Function that calculates the hypervolume of the Interval.
% 
% Syntax:  
%    vol = intervalVolume(X)
%
% Inputs:
%    X - Interval
%
% Outputs:
%    vol - volume
%
% Example: 
%    X.midpoints = ones(2,1);
%    X.radius = 2*ones(2,1);
%    vol = intervalVolume(X)
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

vol = prod(2*X.radius);
end

