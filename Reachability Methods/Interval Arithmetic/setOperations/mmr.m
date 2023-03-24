function X = mmr(A)
% mmr - Auxiliary function that helps defining linear maps for uncertain
% matrices.
%  
% Syntax:  
%    X = mmr(A)
%
% Inputs:
%    A - Interval 
%
% Outputs:
%    X - min(A.radius, max(A.midpoints,-A.radius))
%
% Example: 
%    none.
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


if ~isfield(A,'midpoints')
    X = 0;
else
    X = min(A.radius, max(A.midpoints,-A.radius));
end
end

