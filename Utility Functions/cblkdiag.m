function C = cblkdiag(A,B,n1,n2)
% cblkdiag - Auxiliary function to replace blkdiag when A or B are empty
% but their size has not been defined.
% 
% Syntax:  
%    C = cblkdiag(A,B,n1,n2)
%
% Inputs:
%    A - matrix
%    B - matrix
%    n1 - supposed size of A
%    n2 - supposed size of B
%
% Outputs:
%    C - equivalent to blkdiag but adds zeros matching n1 or n2 when A is
%    [] or B is [].
%
% Example: 
%    C = cblkdiag(eye(2),[],2,3) % check blkdiag(eye(2),[])
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

A = [A,zeros(size(A,1),n1-size(A,2))];
B = [B,zeros(size(B,1),n2-size(B,2))];

C = blkdiag(A,B);
end

