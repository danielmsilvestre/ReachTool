function Z = CCGMinkowskiSum(X,Y)
% CCGMinkowskiSum - Function that calculates the Minkowski sum of two
% Constrained Convex Generators.
% 
% Syntax:  
%    Z = CCGMinkowskiSum(X,Y)
%
% Inputs:
%    X - Constrained Convex Generator
%    Y - Constrained Convex Generator
%
% Outputs:
%    Z - Constrained Convex Generator that Z = {z = x+y: x \in X, y \in Y}
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    X.idx = [5 5];
%    X.type = [2 inf];
%    Y = X;
%    Y.G = rand(2,m);
%    Z = CCGMinkowskiSum(X,Y);
%    [Fx,px] = compileCCG(X);
%    [Fy,py] = compileCCG(Y);
%    [Fz,pz] = compileCCG(Z);
%    plot(Fz,pz,'b');hold on;
%    plot(Fx,px);
%    plot(Fy,py);
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

Z.G = [X.G Y.G];
Z.c = X.c + Y.c;
Z.A = blkdiag(X.A, Y.A);
Z.b = [X.b; Y.b];

if isinf(X.type(end)) && isinf(Y.type(1))
    Z.type = [X.type Y.type(2:end)];
    Z.idx = [X.idx(1:end-1) X.idx(end)+Y.idx(1) Y.idx(2:end)];
else
    Z.type = [X.type, Y.type];
    Z.idx = [X.idx, Y.idx];
end

% Only required to include sidx, weights and freeterms if at least one is
% the result of a convex hull operation. Otherwise omit and keep the
% structure simpler.

if isfield(X,'sidx') || isfield(Y,'sidx')
    
    if ~isfield(X,'sidx')
        X.sidx = [];
        X.weights = [];
        X.freeTerm = [];
    end
    
    if ~isfield(Y,'sidx')
        Y.sidx = [];
        Y.weights = [];
        Y.freeTerm = [];
    end
    
    Z.sidx = [X.sidx;Y.sidx];
    Z.weights = [X.weights;Y.weights];
    Z.freeTerm = [X.freeTerm,Y.freeTerm];
    
end

end

