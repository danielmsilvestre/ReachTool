function [F,p] = compileCCG(Z)
% compileCCG - Function returning a Yalmip constraint set representing the
% Constrained Convex Generator.
%   
%   Z = {z = G*xi+c: A*xi = b, xi_j \in C_j, forall j}
% 
% Syntax:  
%    [F,p] = compileCCG(Z)
%
% Inputs:
%    Z - Constrained Convex Generator
%
% Outputs:
%    F - Yalmip constraint set
%    p - sdpvar representing a point in Z.
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    X.idx = [5 5];
%    X.type = [2 inf];
%    [F,p] = compileCCG(X);
%    plot(F,p);
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

n = size(Z.G,1);

p = sdpvar(n,1);

xi = sdpvar(size(Z.G,2),1);

pointer = 0;
F = [Z.A * xi == Z.b, p == Z.G * xi + Z.c];

gen_idx = 1;

for i = 1:length(Z.idx)
    if Z.type(i) > 0
        F = [F, norm(xi(pointer + (1:Z.idx(i)),1), Z.type(i)) <= 1];
        gen_idx = gen_idx + 1;
    end
    % This part is only visited if a convex hull operation has occurred
    if Z.type(i) < 0
        F = [F, norm(xi(pointer + (1:Z.idx(i)),1), -Z.type(i)) + nonzeros(Z.weights(gen_idx,:))'*xi(nonzeros(Z.sidx(gen_idx,:)),1)<= Z.freeTerm(gen_idx)];
        gen_idx = gen_idx + 1;
    end
    pointer = pointer + Z.idx(i);
end

end

