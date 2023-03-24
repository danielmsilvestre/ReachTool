function f = fuseEllipsoid(p, q1, W1, q2, W2, n)
% fuseEllipsoid - Auxiliary function that is used to perform the
% intersection of two ellipsoids.
% 
% Syntax:  
%    f = fuseEllipsoid(p, q1, W1, q2, W2, n)
%
% Inputs:
%    p - center of Ellipsoid 1
%    q1 - center of Ellipsoid 2
%    W1 - shape of Ellipsoid 1
%    W2 - shape of Ellipsoid 2
%    n - dimension of the state space
%
% Outputs:
%    f - fusing parameter
%
% Example: 
%    none
%
% Other m-files required: none.
% Subfunctions: cz2ah(X)
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


X = p * W1 + (1-p) * W2;

Y = inv(X);
a = 1 - p*(1-p) * (q2-q1)'*W2*Y*W1*(q2-q1);
qplus = Y * (p*W1*q1+(1-p)*W2*q2);

f = a*det(X)^2*trace(Y*(W1-W2)) - n * det(X)^2*(2*qplus'*(W1*q1-W2*q2) + ...
    qplus'*(W2-W1)*qplus - q1'*W1*q1 + q2'*W2*q2);

end

