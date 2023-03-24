function nextX = CCGIntersect(C, X, Y)
% CCGIntersect - Function that calculates the points in X such that if
% multiplied by matrix C would be in Y.
% 
% Syntax:  
%    nextX = CCGIntersect(C, X, Y)
%
% Inputs:
%    C - measurement matrix
%    X - Constrained Convex Generator
%    Y - Constrained Convex Generator
%
% Outputs:
%    Z - Constrained Convex Generator that Z = {z: z \in X,  Cz \in Y}
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
%    Z = CCGIntersect(2*eye(2),X,Y);
%    [Fx,px] = compileCCG(X);
%    [Fy,py] = compileCCG(Y);
%    [Fz,pz] = compileCCG(Z);
%    plot(Fx,px);hold on;
%    plot(Fy,py);
%    plot(Fz,pz,'b');
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

nextX.G = [X.G zeros(size(X.G,1) , size(Y.G,2))];
nextX.c = X.c;
nextX.A = [blkdiag(X.A,Y.A);C*X.G -Y.G];
% if isempty(Y.A) && ~isempty(X.A)
%     nextX.A = [X.A zeros(size(X.A,1),size(Y.G,1));C*X.G -Y.G];
% else
%     nextX.A = [blkdiag(X.A,Y.A);C*X.G -Y.G];
% end

nextX.b = [X.b;Y.b;Y.c - C*X.c];

if isinf(X.type(end)) && isinf(Y.type(1))
    nextX.type = [X.type Y.type(2:end)];
    nextX.idx = [X.idx(1:end-1) X.idx(end)+Y.idx(1) Y.idx(2:end)];
else
    nextX.type = [X.type, Y.type];
    nextX.idx = [X.idx, Y.idx];
end

if isfield(X,'sidx') && ~isfield(Y,'sidx') 
    nextX.sidx = X.sidx;
    nextX.weights = X.weights;
    nextX.freeTerm = X.freeTerm;
end

if isfield(Y,'sidx')
    error('Not implemented intersection with Y set resulting from a convex hull operation');
end


end

