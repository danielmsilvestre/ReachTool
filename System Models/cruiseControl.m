function system = cruiseControl(parameters, Ts)
% cruiseControl - Outputs the discrete dynamical system corresponding to a
% model of a cruise control using ZOH with sampling time Ts.
%   c2d(ss(A,B,C,D)) with :
% 
%   A = -b/m;
%   B = 1/m;
%   C = 1;
%   D = 0;
%
% Syntax:  
%    system = cruiseControl(parameters, Ts)
%
% Inputs:
%    parameters - parameteres regarding the model.
%    Ts - sampling time.
%
% Outputs:
%    system - discrete dynamical system structure to use for simulation.
%
% Example: 
%    system = cruiseControl(struct('m',1000,'b',50), 0.1)
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


m = parameters.m;
b = parameters.b;

A = -b/m;
B = 1/m;
C = 1;
D = 0;

cruise_ss = ss(A,B,C,D);

discrete_cruise_ss = c2d(cruise_ss,Ts);

[Ad, Bd, Cd, Dd] = ssdata(discrete_cruise_ss);
system = struct('A', Ad, 'B', Bd, 'C', Cd, 'D', Dd, 'n', size(A,1), 'L', Bd, 'N', 1, 'nd', 1, 'nn', 1);

end

