function nextX = PolyUpdate(system, X, u, y, noise)
% PolyUpdate - Function encapsulating the update phase of a
% set-valued state estimation for a linear system with no uncertainties.
% 
% The function returns the set X(k) that satisfies the measurement set Y(k):
% X(k) = Xp(k) intersect_C Y(k) 
% 
% Syntax:  
%    nextX = PolyUpdate(system, X, u, y, noise)
%
% Inputs:
%    system - structure with all the matrices from the dynamical model
%    X - propagated set-valued estimate X(k)
%    u - value of the actuation
%    y - measurement
%    noise - set for the noise
%
% Outputs:
%    nextX - Polytope with all values that can result in the
%    measurement y given the noise set.
%
% Example: 
%    m = 10;
%    X.n = 2;
%    X.A = randn(m,2);
%    X.b = rand(m,1)*m;
%    X.Aeq = zeros(0,2);
%    X.beq = zeros(0,1);
%    noise = X; % assume noise is equal to the state for illustration
%    system = struct('C',eye(2),'N',eye(2),'D',zeros(2));
%    X = PolyUpdate(system, X, ones(2,1), 2*ones(2,1), noise)
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

Y = PolyLinMap(-system.N,noise,y - system.D * u);

nextX = PolyIntersect(system.C,X,Y);
end

