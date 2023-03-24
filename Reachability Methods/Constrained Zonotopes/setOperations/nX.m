function y = nX(H)
% nX - Auxiliary function used in the conversion of Constrained Zonotopes
% to a H-representation.
%
% Syntax:  
%    y = nX(H)
%
% Inputs:
%    H - Matrix with part of the linear map of a Constrained Zonotope
%
% Outputs:
%    y - vector with a determinant computation used in the conversion.
%
% Example: 
%    none.
%
% Other m-files required: none.
% Subfunctions: none
% MAT-files required: none
%
% See also: ZtoHrep.m.
 
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
n = size(H,1);

y = zeros(1,n);


for i = 1:n
    Hi = H([1:(i-1),(i+1):n],:);
    y(i) = (-1)^(i+1)*det(Hi);
    
end
y = y';
end

