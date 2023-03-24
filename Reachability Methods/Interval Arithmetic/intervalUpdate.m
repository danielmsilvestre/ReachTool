function X = intervalUpdate(system, X, u, y, noise)
% intervalUpdate - Function encapsulating the update phase of a
% set-valued state estimation for a linear system with no uncertainties.
% 
% The function returns the set X(k) that satisfies the measurement set Y(k):
% X(k) = Xp(k) intersect_C Y(k) 
% 
% Syntax:  
%    nextX = intervalUpdate(system, X, u, y, noise)
%
% Inputs:
%    system - structure with all the matrices from the dynamical model
%    X - propagated set-valued estimate X(k)
%    u - value of the actuation
%    y - measurement
%    noise - set for the noise
%
% Outputs:
%    nextX - Interval with all values that can result in the
%    measurement y given the noise set.
%
% Example: 
%    X.midpoints = ones(2,1);
%    X.radius = 2*ones(2,1);
%    noise = X; % assume noise is equal to the state for illustration
%    system = struct('C',eye(2),'N',eye(2),'D',zeros(2));
%    X = intervalUpdate(system, X, ones(2,1), 2*ones(2,1), noise)
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

Y.midpoints = -system.N*noise.midpoints + y - system.D * u;
Y.radius = abs(system.N)*noise.radius;

n = size(X.midpoints,1);

xsdp = sdpvar(n,1);
v = sdpvar(n,1);
Fc = [X.midpoints - X.radius <= xsdp <= X.midpoints + X.radius, ...
    Y.midpoints - Y.radius <= system.C * xsdp <= Y.midpoints + Y.radius];

getBounds = optimizer(Fc,v'*xsdp,sdpsettings('solver','mosek,sedumi'),v,xsdp);
mx = zeros(n,1);
Mx = zeros(n,1);
for j = 1:n
    mx(j,1) = e(j,n)'*getBounds(e(j,n));
    Mx(j,1) = e(j,n)'*getBounds(-e(j,n));
end

X.midpoints = 0.5*(mx+Mx);
X.radius = 0.5*(Mx-mx);


end
