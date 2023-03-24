function V = rayShooting(V,F,p,m,center)
% rayShooting - Function that takes any set representation specified by a
% constraint set in Yalmip F and an sdpvar p representing a point in that
% set. It then finds points on the surface by randomly sampling direction
% vectors. In order to get a better first approximation, it uses the
% canonical vectors and then the vectors where all components have unity
% magnitude.
% 
% Syntax:  
%    V = rayShooting(V,F,p,m,center)
%
% Inputs:
%    V - vertex set known from prior iterations or knowledge.
%    F - Yalmip constraint set representing the reachable set.
%    p - sdpvar to represent a point in the set.
%    m - size of the state space.
%    center - a guess for the center.
%
% Outputs:
%    V - set of points in the boundary.
%
% Example: 
%    m = 10;
%    P = rand(2,m);
%    [F,p] = compilePoints(P);
%    V = rayShooting([],F,p,2,PointsCenter(P));
%    plot(F,p); hold on; scatter(V(1,:),V(2,:),'b');
%
% Other m-files required: none.
% Subfunctions: none
% MAT-files required: none
%
% See also: VolumeRayShooting.m.
 
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

global cubeVertices;

firstSet = size(V,2) == 0;

if size(cubeVertices,2) ~= m && firstSet
    cubeVertices = permn([-1,1],m);
end

nb_samples = max(400,200+m+2^m);

n = size(p,1);

VM = zeros(m,nb_samples);
Vm = zeros(m,nb_samples);


d = sdpvar(m,1);

if firstSet
    getV = optimizer(F,[d;zeros(n-m,1)]'*p,sdpsettings('solver','mosek,sedumi,quadprog'),d,p(1:m));
end

k = sdpvar;
getRay = optimizer([F,p(1:m) == k*d + center],[d;zeros(n-m,1)]'*p,sdpsettings('solver','mosek,sedumi,quadprog'),d,p(1:m));

for i = 1:nb_samples
    if firstSet && i <= m 
        direction = e(i,m);
        VM(:,i) = getV(direction);
        Vm(:,i) = getV(-direction);
        if any(isnan(VM(:,i))) || any(isnan(Vm(:,i)))
            disp('The problem is infeasiable');
        end
    elseif firstSet && i > m && i <= m + 2^m
        direction = cubeVertices(i-m,:)';
        VM(:,i) = getV(direction);
        Vm(:,i) = getV(-direction);
        if any(isnan(VM(:,i))) || any(isnan(Vm(:,i)))
            disp('The problem is infeasiable');
        end
    else
        direction = -1 + 2.*rand(m,1);
        try
        VM(:,i) = getRay(direction);
        Vm(:,i) = getRay(-direction);
        if any(isnan(VM(:,i))) || any(isnan(Vm(:,i)))
            disp('The problem is infeasiable');
        end
        catch
            disp('This direction raised an exception in the solver:');
            disp(direction);
        end
    end
    
    
end
% V = removePoints([V,VM,Vm]);
V = [V,VM,Vm];

end

