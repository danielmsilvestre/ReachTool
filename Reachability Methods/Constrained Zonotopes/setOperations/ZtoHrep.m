function [C,d] = ZtoHrep(G,c)
% ZtoHrep - Function that computes the H-representation for a Constrained
% Zonotope by providing its lifted zonotope representation.
% 
% Syntax:  
%    [C,d] = ZtoHrep(G,c)
%
% Inputs:
%    G - linear map of the lifted zonotope format
%    c - translation vector of the lifted zonotope format
%
% Outputs:
%    C - matrix such that Cx <= d, for all points x in Zonotope(G,c)
%    d - vector such that Cx <= d, for all points x in Zonotope(G,c)
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    G = [X.G;X.A];
%    c = [X.c;-X.b];
%    [C,d] = ZtoHrep(G,c);
%    [Fx,px] = compileCZ(X);
%    py = sdpvar(2,1);
%    Fy = C*[py;sdpvar(size(C,2)-size(py,1),1)]<=d;
%    plot(Fx,px);hold on;
%    plot(Fy,py,'b'); % same set in H-rep
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


[n,p] = size(G);

pcombs = nchoosek(1:p,n-1);
nb_combinations = size(pcombs,1);

Cplus = zeros(nb_combinations,n);
dplus = zeros(nb_combinations,1);
dminus = zeros(nb_combinations,1);

for i = 1:nchoosek(p,n-1)
    Gr = G(:,pcombs(i,:));
    nXGr = nX(Gr);
    Cplus(i,:) = nXGr'/norm(nXGr,2);
    
    delta = 0;
    for v = 1:p
        delta = delta + abs(Cplus(i,:)*G(:,v));
    end
    
    dplus(i,:) = Cplus(i,:)*c + delta;
    dminus(i,:) = -Cplus(i,:)*c + delta;


end

nanIndex = any(isnan(Cplus),2);
Cplus(nanIndex,:) = [];
dplus(nanIndex,:) = [];
dminus(nanIndex,:) = [];

C = [Cplus;-Cplus];
d = [dplus;dminus];

