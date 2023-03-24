% CCGillustration - Example drawing two CCGs to illustrate intersection of
% ellipsoids and polytopes.
% 
% Syntax:  
%    run the script
%
% Inputs:
%    none
%
% Outputs:
%    saves a pdf figure with two examples
%
% Example: 
%    Left is the intersection of an ellipsoid with a polytope
%    Right is the intersection of two ellipsoids
%
% Other m-files required: compileCCG.m
% Subfunctions: none
% MAT-files required: none
%
% See also: none
 
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



%% Initialize Variables

clearvars;
close all;

%% Define a square
% let us create a square using the new notation
Z.G = eye(2);
Z.c = zeros(2,1); % square centered in [1;1]
Z.A = zeros(0,2); % it is important to maintain empty matrices of the appropriate dimension for concatenation of generator sets
Z.b = zeros(0,1);
Z.idx = 2;
Z.type = inf;

%% Define an ellipse
% let us create an ellipsoid centered in [2;2] using the new notation
Y.G = diag([1,2]);
Y.c = ones(2,1); % square centered in [1;1]
Y.A = zeros(0,2);
Y.b = zeros(0,1);
Y.idx = 2;
Y.type = 2;

%% Compute the intersection of the two sets
% Compute the intersection
W = CCGIntersect(eye(2),Z,Y);

% let us create an ellipsoid centered in [2;2] using the new notation
X.G = diag([1,1]);
X.c = zeros(2,1); % square centered in [0;0]
X.A = zeros(0,2);
X.b = zeros(0,1);
X.idx = 2;
X.type = 2;

%% Draw the intersection of the two sets

h = figure;
subplot(1,2,1);
[Fw,pw] = compileCCG(W);
plot(Fw,pw,'m');
xlim([-0.5,1.5]);
ylim([-3,3]);
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');


Int = CCGIntersect(eye(2),Y,X);
subplot(1,2,2);
xlim([-0.5,1.5]);
ylim([-3,3]);
[Fx,px] = compileCCG(X);
[Fi,pi] = compileCCG(Int);
plot(Fi,pi,'r');
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');
saveas(h,'ccg','pdf');


