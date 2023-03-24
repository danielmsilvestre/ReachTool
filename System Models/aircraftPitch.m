function system = aircraftPitch(parameters, Ts)
% aircraftPitch - Outputs the discrete dynamical system corresponding to a
% model of an aircraft pitch using ZOH with sampling time Ts.
%   c2d(ss(A,B,C,D)) with :
% 
%   A = [-0.313 56.7 0; -0.0139 -0.426 0; 0 56.7 0];
%   B = [0.232; 0.0203; 0];
%   C = [0 0 1];
%   D = 0;
%
% Syntax:  
%    system = aircraftPitch(parameters, Ts)
%
% Inputs:
%    parameters - not used here but can be changed to add variations.
%    Ts - sampling time.
%
% Outputs:
%    system - discrete dynamical system structure to use for simulation.
%
% Example: 
%    system = aircraftPitch([], 0.1)
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

A = [-0.313 56.7 0; -0.0139 -0.426 0; 0 56.7 0];
B = [0.232; 0.0203; 0];
C = [0 0 1];
D = 0;

aircraft_ss = ss(A,B,C,D);

discrete_aircraft_ss = c2d(aircraft_ss,Ts);

[Ad, Bd, Cd, Dd] = ssdata(discrete_aircraft_ss);
system = struct('A', Ad, 'B', Bd, 'C', Cd, 'D', Dd, 'n', size(A,1), 'L', eye(3), 'N', 1, 'nd', 3, 'nn', 1);

end

