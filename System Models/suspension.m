function system = suspension(parameters, Ts)
% suspension - Outputs the discrete dynamical system corresponding to a
% model of a suspension using ZOH with sampling time Ts.
%   c2d(ss(A,B,C,D)) with :
% 
%   A=[0                 1   0                                              0
%      -(b1*b2)/(m1*m2)  0   ((b1/m1)*((b1/m1)+(b1/m2)+(b2/m2)))-(k1/m1)   -(b1/m1)
%      b2/m2             0  -((b1/m1)+(b1/m2)+(b2/m2))                      1
%      k2/m2             0  -((k1/m1)+(k1/m2)+(k2/m2))                      0];
%   B=[0                 0
%      1/m1              (b1*b2)/(m1*m2)
%      0                -(b2/m2)
%      (1/m1)+(1/m2)    -(k2/m2)];
%   C=[0 0 1 0];
%   D=[0 0];
%
% Syntax:  
%    system = suspension(parameters, Ts)
%
% Inputs:
%    parameters - parameteres regarding the model.
%    Ts - sampling time.
%
% Outputs:
%    system - discrete dynamical system structure to use for simulation.
%
% Example: 
%    system = suspension(struct('m1',2500,'m2',320,'k1',80000,'k2',500000,'b1',350,'b2',15020), 0.1)
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

m1 = parameters.m1;
m2 = parameters.m2;
k1 = parameters.k1;
k2 = parameters.k2;
b1 = parameters.b1;
b2 = parameters.b2;


A=[0                 1   0                                              0
  -(b1*b2)/(m1*m2)   0   ((b1/m1)*((b1/m1)+(b1/m2)+(b2/m2)))-(k1/m1)   -(b1/m1)
   b2/m2             0  -((b1/m1)+(b1/m2)+(b2/m2))                      1
   k2/m2             0  -((k1/m1)+(k1/m2)+(k2/m2))                      0];
B=[0                 0
   1/m1              (b1*b2)/(m1*m2)
   0                -(b2/m2)
   (1/m1)+(1/m2)    -(k2/m2)];
C=[0 0 1 0];
D=[0 0];

suspension_ss = ss(A,B,C,D);

discrete_suspension_ss = c2d(suspension_ss,Ts);

[Ad, Bd, Cd, Dd] = ssdata(discrete_suspension_ss);
system = struct('A', Ad, 'B', Bd(:,1), 'C', Cd, 'D', Dd(:,1), 'n', size(A,1), 'L', Bd(:,2), 'N', 1, 'nd', 1, 'nn', 1);

end

