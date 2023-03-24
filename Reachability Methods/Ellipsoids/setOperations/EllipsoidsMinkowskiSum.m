function Z = EllipsoidsMinkowskiSum(X,Y)
% EllipsoidsMinkowskiSum - Function that calculates the Minkowski sum of two Ellipsoids.
% 
% Syntax:  
%    Z = EllipsoidsMinkowskiSum(X,Y)
%
% Inputs:
%    X - Ellipsoid
%    Y - Ellipsoid
%
% Outputs:
%    Z - Ellipsoid that Z = {z = x+y: x \in X, y \in Y}
%
% Example: 
%    radius = 2;
%    X = struct('Q',diag(radius.^2),'c',zeros(2,1));
%    Y = EllipsoidsLinMap(rand(2),X,zeros(2,1));
%    Z = EllipsoidsMinkowskiSum(X,Y);
%    [Fx,px] = compileEllipsoid(X);
%    [Fy,py] = compileEllipsoid(Y);
%    [Fz,pz] = compileEllipsoid(Z);
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

Z.c = X.c + Y.c;

R = X.Q\Y.Q;

lambda = eig(R);

bn = 0;
bnext = 1;

while norm(bn-bnext) > 1E-5
    bn = bnext;
    bnext = sqrt(sum(1./(1+bn*lambda))/sum(lambda./(1+bn*lambda)));
end
Z.Q = (1+1/bn) * X.Q + (1+bn) * Y.Q;

end

