function Z = CCGcvxHull(X,Y)
% CCGcvxHull - Function that calculates the convex hull of two Constrained
% Convex Generators.
% 
% Syntax:  
%    Z = CCGcvxHull(X,Y)
%
% Inputs:
%    X - Constrained Convex Generator
%    Y - Constrained Convex Generator
%
% Outputs:
%    Z - Constrained Convex Generator that Z = {z = lambda*x+(1-lambda)*y: x \in X, y \in Y}
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
%    Z = CCGcvxHull(X,Y);
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

ngX = nnz(X.type);
ngY = nnz(Y.type);

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

[nX,mX] = size(X.sidx);
[nY,mY] = size(Y.sidx);

depth = max(mX,mY);

% resize X.sidx to match ngX
X.sidx = [X.sidx;zeros(ngX-nX,mX)];
X.weights = [X.weights;zeros(ngX-nX,mX)];

% resize X.sidx,X.weights to fit the convex hull with Y
X.sidx = reshape([X.sidx(:);zeros(ngX*(depth-mX),1)],ngX,[]);
X.weights = reshape([X.weights(:);zeros(ngX*(depth-mX),1)],ngX,[]);

% resize Y.sidx to match ngY
Y.sidx = [Y.sidx;zeros(ngY-nY,mY)];
Y.weights = [Y.weights;zeros(ngY-nY,mY)];

% resize Y.sidx to fit the convex hull with X
Y.sidx = reshape([Y.sidx(:);zeros(ngY*(depth-mY),1)],ngY,[]);
Y.weights = reshape([Y.weights(:);zeros(ngY*(depth-mY),1)],ngY,[]);

% Adjust counting of sidx for Y to prepare for the concatenation
patternOFnonzerosY = Y.sidx ~= 0;
Y.sidx = patternOFnonzerosY.*(Y.sidx + size(X.G,2));


Z.G = [X.G Y.G (X.c-Y.c)];
Z.c = 0.5*(Y.c+X.c);
Z.A = [blkdiag(X.A,Y.A),[-X.b;Y.b]];
Z.b = 0.5*[X.b;Y.b];
Z.type = -abs([X.type,Y.type,0]);
Z.idx = [X.idx,Y.idx,1];
% Z.sidx = [[X.sidx;zeros(ngX-size(X.sidx,1),size(X.sidx,2));Y.sidx;zeros(ngY-size(Y.sidx,1),size(Y.sidx,2))],size(Z.G,2)*ones(ngX+ngY,1)];
Z.sidx = [[X.sidx;Y.sidx],size(Z.G,2)*ones(ngX+ngY,1)];
% Z.weights = [X.weights,-X.freeTerm';
%              zeros(ngX-size(X.weights,1),size(X.weights,1)-1),-ones(ngX-size(X.weights,1),1);
%              Y.weights,Y.freeTerm';
%              zeros(ngY-size(Y.weights,1),size(Y.weights,1)-1),ones(ngY-size(Y.weights,1),1)];
Z.weights = [X.weights,[-X.freeTerm';-ones(ngX-nX,1)];
             Y.weights,[Y.freeTerm';ones(ngY-nY,1)]];
Z.freeTerm = 0.5*[X.freeTerm,ones(ngX-nX,1),Y.freeTerm,ones(ngY-nY,1)];

% In the constraints we are not adding 0 <= lambda <= 1 because it is
% assumed that the original polytope H xi <= h includes the origin making 
% h >= 0. For that reason, if lambda < 0 it makes the generator set of X
% empty and if lambda > 1 it makes the generator set of Y empty.

end

