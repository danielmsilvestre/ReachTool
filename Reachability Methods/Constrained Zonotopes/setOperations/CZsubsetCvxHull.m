function result = CZsubsetCvxHull(Y)
% CZsubsetCvxHull - Function that checks for all Constrained Zonotopes if each is
% contained in a convex hull of the remaining. It returns a boolean vector
% that identifies which sets are a subset of the others. It resorts to the
% implementation for A-H polytopes by converting each CZ to its A-H
% counterpart.
% 
% Syntax:  
%    result = CZsubsetCvxHull(Y)
%
% Inputs:
%    Y - cell array of Constrained Zonotopes
%
% Outputs:
%    result - boolean vector that asserts whether each set is a subset of
%    the others.
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    Y{1} = X;
%    Y{2} = X;
%    Y{2}.G = 0.5*Y{2}.G;
%    result = CZsubsetCvxHull(Y) % second one is trivially a subset of the
%    first
%
% Other m-files required: convertCZ2AH.m.
% Subfunctions: Solver Mosek. It works without it but is highly recommended
% for a faster computation or it will resort to fmincon.
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

Y = convertCZ2AH(Y);

result = AHsubsetCvxHull(Y);

end

