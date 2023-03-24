function system = invertedPendulum(parameters, Ts)
% cruiseControl - Outputs the discrete dynamical system corresponding to a
% model of an inverted pendulum using ZOH with sampling time Ts.
%   c2d(ss(A,B,C,D)) with :
% 
%   p = I*(M+m)+M*m*l^2; %denominator for the A and B matrices
% 
%   A = [0      1              0           0;
%        0 -(I+m*l^2)*b/p  (m^2*g*l^2)/p   0;
%        0      0              0           1;
%        0 -(m*l*b)/p       m*g*l*(M+m)/p  0];
%   B = [    0;
%           (I+m*l^2)/p;
%            0;
%            m*l/p];
%   C = [1 0 0 0;
%        0 0 1 0];
%   D = [0;
%        0];
%
% Syntax:  
%    system = invertedPendulum(parameters, Ts)
%
% Inputs:
%    parameters - parameteres regarding the model.
%    Ts - sampling time.
%
% Outputs:
%    system - discrete dynamical system structure to use for simulation.
%
% Example: 
%    system = invertedPendulum(struct('M',0.5,'m',0.2,'b',0.1,'I',0.006,'g',9.8,'l',0.3), 0.1)
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

%INVERTEDPENDULUM Outputs the discrete dynamical system corresponding to a
%model of a motor speed using sample and hold method with sampling time Ts.
%   c2d(ss(A,B,C,D)) with :


M = parameters.M;
m = parameters.m;
b = parameters.b;
I = parameters.I;
g = parameters.g;
l = parameters.l;

p = I*(M+m)+M*m*l^2; %denominator for the A and B matrices

A = [0      1              0           0;
     0 -(I+m*l^2)*b/p  (m^2*g*l^2)/p   0;
     0      0              0           1;
     0 -(m*l*b)/p       m*g*l*(M+m)/p  0];
B = [     0;
     (I+m*l^2)/p;
          0;
        m*l/p];
C = [1 0 0 0;
     0 0 1 0];
D = [0;
     0];
 
pendulum_ss = ss(A,B,C,D);

discrete_pendulum_ss = c2d(pendulum_ss,Ts);

[Ad, Bd, Cd, Dd] = ssdata(discrete_pendulum_ss);
system = struct('A', Ad, 'B', Bd, 'C', Cd, 'D', Dd, 'n', size(A,1), 'L', [e(1,size(A,1)),e(3,size(A,1))], 'N', eye(size(Cd,1)), 'nd', 2, 'nn', 2);

end

