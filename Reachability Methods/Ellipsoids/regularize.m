function R = regularize(Q)
% regularize - Auxiliary function that is used to eliminate zero
% eigenvalues of the shape matrix.
% 
% Syntax:  
%    R = regularize(Q)
%
% Inputs:
%    Q - shape of Ellipsoid
%
% Outputs:
%    R - new shape with no directions of zero size
%
% Example: 
%    none
%
% Other m-files required: none.
% Subfunctions: none.
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

[~, n] = size(Q);
r = rank(Q);

if r < n
    [U, ~, ~] = svd(Q);
    E = 1E7 * eye(n - r);
    R = Q + (U * [zeros(r, r) zeros(r, (n-r)); zeros((n-r), r) E] * U');
    R = 0.5*(R + R');
else
    R = Q;
end

  return;
