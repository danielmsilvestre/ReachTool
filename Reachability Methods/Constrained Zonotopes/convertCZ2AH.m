function X_AH = convertCZ2AH(X)
% convertCZ2AH - Function that converts Constrained Zonotopes to A-H
% polytopes representation.
% 
% Syntax:  
%    X_AH = convertCZ2AH(X)
%
% Inputs:
%    X - cell array of or a single Constrained Zonotopes.
%
% Outputs:
%    X-AH - X but in A-H polytope format.
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    X_AH = convertCZ2AH(X);
%    [Fx,px] = compileCZ(X);
%    [Fy,py] = compileAH(X_AH);
%    plot(Fx,px);hold on;
%    plot(Fy,py,'b'); % same set in A-H-rep
%
% Other m-files required: none.
% Subfunctions: cz2ah(X)
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

if ~iscell(X)
    X_AH = cz2ah(X);
else
    X_AH = cellfun(@cz2ah,X,'UniformOutput',false);
end


% Auxiliary function to convert a single Constrained Zonotope to A-H-rep
function X_AH = cz2ah(X)
    ng = size(X.G,2);
    X_AH.G = X.G;
    X_AH.c = X.c;
    X_AH.H = [X.A;-X.A;eye(ng);-eye(ng)];
    X_AH.h = [X.b;-X.b;ones(2*ng,1)];
end
    

end
