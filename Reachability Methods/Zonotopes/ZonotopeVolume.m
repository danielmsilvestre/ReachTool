function vol = ZonotopeVolume(X)
% ZonotopeVolume - Function that calculates the hypervolume of a Zonotope.
% 
% Syntax:  
%    vol = ZonotopeVolume(X)
%
% Inputs:
%    X - Zonotope
%
% Outputs:
%    vol - volume
%
% Example: 
%    m = 10;
%    X.H = rand(2,m);
%    X.p = zeros(2,1);
%    vol = ZonotopeVolume(X)
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

[n,m] = size(X.H);

combinations = nchoosek(1:m,n);

vol = 0;

for i = 1:size(combinations,1)
    vol = vol + abs(det(X.H(:,combinations(i,:))));
end
vol = 2^n * vol;


end

