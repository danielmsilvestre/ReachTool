function Z = removeInnerPoints(Z)
% removeInnerPoints - Function that calculates the points in X such that if
% multiplied by matrix C would be in Y.
% 
% Syntax:  
%    Z = removeInnerPoints(Z)
%
% Inputs:
%    Z - Points
%
% Outputs:
%    Z - Points with only elements in the boundary
%
% Example: 
%    m = 10;
%    X = rand(2,m);
%    Z = removeInnerPoints(X)
%    [Fx,px] = compilePoints(X);
%    [Fz,pz] = compilePoints(Z);
%    plot(Fx,px);hold on;
%    plot(Fz,pz,'b');
%
% Other m-files required: unionHull.m.
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

if size(Z,2) > 1
    % option with convhull
    try
        if size(Z,1) == 2
            K = convhull(Z');
        else
            K = convhulln(Z');
        end
        Z = Z(:,unique(K));
    catch 
        I=unionHull('vert',Z');   %compute the union
        if size(I.vert,1) <= size(Z,2)
            Z = I.vert';
        end
    end
end

end

