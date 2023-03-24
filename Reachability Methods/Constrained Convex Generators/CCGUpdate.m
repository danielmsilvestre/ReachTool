function nextX = CCGUpdate(system, X, u, y, noise)
% CCGUpdate - Function encapsulating the update phase of a
% set-valued state estimation for a linear system with no uncertainties.
% 
% The function returns the set X(k) that satisfies the measurement set Y(k):
% X(k) = Xp(k) intersect_C Y(k) 
% 
% Syntax:  
%    nextX = CCGUpdate(system, X, u, y, noise)
%
% Inputs:
%    system - structure with all the matrices from the dynamical model
%    X - propagated set-valued estimate X(k)
%    u - value of the actuation
%    y - measurement
%    noise - set for the noise
%
% Outputs:
%    nextX - Constrained Convex Generator with all values that can result
%    in the measurement y given the noise set.
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    X.idx = [5 5];
%    X.type = [2 inf];
%    noise = X; % assume noise is equal to the state for illustration
%    system = struct('C',eye(2),'N',eye(2),'D',zeros(2));
%    X = CCGUpdate(system, X, ones(2,1), 2*ones(2,1), noise)
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

Y = CCGLinMap(-system.N,noise,y - system.D * u);

nextX = CCGIntersect(system.C,X,Y);

end

