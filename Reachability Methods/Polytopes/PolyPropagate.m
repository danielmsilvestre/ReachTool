function X = PolyPropagate(system, prevX, u, d)
% PolyPropagate - Function encapsulating the propagation phase of a
% set-valued state estimation for a linear system with no uncertainties.
% 
% The function returns the set X(k+1) that satisfies:
% X(k+1) = A X(k) + B u(k) + L D(k)
% 
% Syntax:  
%    X = PolyPropagate(system, prevX, u, d)
%
% Inputs:
%    system - structure with all the matrices from the dynamical model
%    prevX - previous set-valued estimate X(k)
%    u - value of the actuation
%    d - set for the unknown disturbance signal
%
% Outputs:
%    X - Polytope that X = {Ax + Bu + Ld: x \in prevX, d \in D} given u
%    value.
%
% Example: 
%    m = 10;
%    X.n = 2;
%    X.A = randn(m,2);
%    X.b = rand(m,1)*m;
%    X.Aeq = zeros(0,2);
%    X.beq = zeros(0,1);
%    D = X; % assume disturbance is equal to the state for illustration
%    system = struct('A',rand(2),'L',rand(2),'B',rand(2));
%    X = PolyPropagate(system, X, ones(2,1), D)
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

X = PolyLinMap(system.A,prevX,system.B*u); % A*x + B*u
D = PolyLinMap(system.L,d,zeros(size(system.L,1),1));
X = PolyMinkowskiSum(X,D); % A*x + B*u + L*Disturbance
end

