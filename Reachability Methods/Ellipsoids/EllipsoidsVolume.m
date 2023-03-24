function vol = EllipsoidsVolume(X)
% EllipsoidsVolume - Function that calculates the hypervolume of the Ellipsoid.
% 
% Syntax:  
%    vol = EllipsoidsVolume(X)
%
% Inputs:
%    X - Ellipsoid
%
% Outputs:
%    vol - volume
%
% Example: 
%    radius = 2;
%    X = struct('Q',diag(radius.^2),'c',zeros(2,1));
%    vol = EllipsoidsVolume(X)
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


n = length(X.c);

vol = (pi^(n/2)/gamma(n/2+1)) * sqrt(det(X.Q));

end

