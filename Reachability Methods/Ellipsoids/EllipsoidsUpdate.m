function nextX = EllipsoidsUpdate(system, X, u, y, noise)
% EllipsoidsUpdate - Function encapsulating the update phase of a
% set-valued state estimation for a linear system with no uncertainties.
% 
% The function returns the set X(k) that satisfies the measurement set Y(k):
% X(k) = Xp(k) intersect_C Y(k) 
% 
% Syntax:  
%    nextX = EllipsoidsUpdate(system, X, u, y, noise)
%
% Inputs:
%    system - structure with all the matrices from the dynamical model
%    X - propagated set-valued estimate X(k)
%    u - value of the actuation
%    y - measurement
%    noise - set for the noise
%
% Outputs:
%    nextX - Ellipsoid with all values that can result in the
%    measurement y given the noise set.
%
% Example: 
%    radius = 2;
%    X = struct('Q',diag(radius.^2),'c',zeros(2,1));
%    noise = X; % assume noise is equal to the state for illustration
%    system = struct('C',eye(2),'N',eye(2),'D',zeros(2));
%    X = EllipsoidsUpdate(system, X, ones(2,1), 2*ones(2,1), noise)
%
% Other m-files required: fuseEllipsoid.m.
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

Y = EllipsoidsLinMap(-system.N,noise,y - system.D * u);
Y = EllipsoidsLinMap(pinv(system.C),Y,zeros(size(system.C,2),1));
Y.Q = regularize(Y.Q);



% Intersection code of X and Y according to algorithm in:
% http://systemanalysisdpt-cmc-msu.github.io/ellipsoids/doc/chap_ellcalc.html#intersection-of-ellipsoid-and-ellipsoid

W1 = inv(X.Q);
W2 = inv(Y.Q);

q1 = X.c;
q2 = Y.c;

[p, ~] = fzero(@fuseEllipsoid, 0.5, [], q1, W1, q2, W2, size(q1, 1));
if p >= 1 - 1E-5
    nextX.c = Y.c;
    nextX.Q = Y.Q;
elseif p <= 1E-5
    nextX.c = X.c;
    nextX.Q = X.Q;
else
    Xvar = p*W1 + (1-p)*W2;
    iX = inv(Xvar);
    a = 1 - p*(1-p) * (q2-q1)'*W2*iX*W1*(q2-q1);
    nextX.c = iX * (p*W1*q1+(1-p)*W2*q2);
    nextX.Q = a*iX;
end
end

