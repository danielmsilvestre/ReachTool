% comparisonHRepvsYalmip - Script comparing the speed of computing the
% volume of a Constrained Zonotope using the Hrep proposed in the
% Constrained Zonotope paper versus the inner approximation computed using
% Yalmip.
% It clearly shows that Yalmip is a better form while maintaining accuracy
% 
% Syntax:  
%    run the script
%
% Inputs:
%    none
%
% Outputs:
%    the total time taken by each method
%
% Example: 
%    random Constrained Zonotope used.
%
% Other m-files required: compileCZ.m
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

clearvars;
close all;

n = 2;
ng = 12;
np = 5;

X.G = rand(n,ng);
X.c = rand(n,1);
X.A = rand(np,ng);
X.b = rand(np,1);

times = zeros(2,1);

for i = 1:5e1
    tic;
    % First let us construct the lifted Zonotope of X defined by (G,c)
    
    G = [X.G;X.A];
    c = [X.c;-X.b];
    
    % Compute the Hrep of the lifted Zonotope
    [A,b] = ZtoHrep(G,c);
        
    % Set the coordinates of the extra generators to zero
    A = A(:,1:end-size(X.b,1));
    
    % Compute the volume using the Yalmip interior approximation
    p = sdpvar(n,1);
    vertices = plot(A * p <= b,p);
    [~,vol] = convhull(vertices{1}','Simplify',true);
    
    t = toc;
    times(1,1) = times(1,1) + t;
    
    tic;
    [F,p] = compileCZ(X);
    vertices = plot(F,p);
    [~,V] = convhull(vertices{1}','Simplify',true);
    t = toc;
    times(2,1) = times(2,1) + t;
    
    if abs(vol - V) > 1e-3
        disp('Error');
    end
end

fprintf('Time spent CZ conversion to Z: %8.4f\nTime spent directly with Yalmip:  %8.4f \n',times);

    
