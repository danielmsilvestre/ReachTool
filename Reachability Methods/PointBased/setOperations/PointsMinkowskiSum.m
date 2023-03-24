function Z = PointsMinkowskiSum(X,Y)
% PointsMinkowskiSum - Function that calculates the Minkowski sum of two
% sets of Points.
% 
% Syntax:  
%    Z = PointsMinkowskiSum(X,Y)
%
% Inputs:
%    X - Points
%    Y - Points
%
% Outputs:
%    Z - Points that Z = {z = x+y: x \in X, y \in Y}
%
% Example: 
%    X = rand(2,m);
%    Y = rand(2,m);
%    Z = PointsMinkowskiSum(X,Y);
%    [Fx,px] = compilePoints(X);
%    [Fy,py] = compilePoints(Y);
%    [Fz,pz] = compilePoints(Z);
%    plot(Fz,pz,'b');hold on;
%    plot(Fx,px);
%    plot(Fy,py);
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

[nx,mx] = size(X);
[~,my] = size(Y);

allPairSum = zeros(nx,mx*my);

cx = nchoosek(1:mx,1);
cy = nchoosek(1:my,1);
idx = combvec(cx',cy')';

for i = 1:size(idx,1)
    allPairSum(:,i) = X(:,idx(i,1)) + Y(:,idx(i,2));
end

Z = removeInnerPoints(allPairSum);


end

