function nextX = PointsIntersect(C, X, Y)
% PointsIntersect - Function that calculates the points in X such that if
% multiplied by matrix C would be in Y.
% 
% Syntax:  
%    nextX = PointsIntersect(C, X, Y)
%
% Inputs:
%    C - measurement matrix
%    X - Points
%    Y - Points
%
% Outputs:
%    Z - Points that Z = {z: z \in X,  Cz \in Y}
%
% Example: 
%    m = 10;
%    X = rand(2,m);
%    Y = rand(2,m);
%    Z = PointsIntersect(2*eye(2),X,Y);
%    [Fx,px] = compilePoints(X);
%    [Fy,py] = compilePoints(Y);
%    [Fz,pz] = compilePoints(Z);
%    plot(Fx,px);hold on;
%    plot(Fy,py);
%    plot(Fz,pz,'b');
%
% Other m-files required: intersectionHull.m.
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

% Find the polytope X such that Y = CX
ny = size(Y,2);
largeUncertainty = 1E5;

if isempty(null(C))
    Xy = C\Y;
else
    Xy = Y.*repmat(pinv(C),[1,ny]); % get the part associated with the pseudo inverse of C
    Xy = [Xy + repmat(null(C) * largeUncertainty, [1,ny]),...
          Xy + repmat(null(C) * -largeUncertainty, [1,ny])]; % add uncertainty along null(C)
end

verticesUpdate = intersectionHull('vert',X','vert',Xy'); % transpose to get 1 vector per row

nextX = verticesUpdate.vert'; % transpose back to get 1 vector per column


end

