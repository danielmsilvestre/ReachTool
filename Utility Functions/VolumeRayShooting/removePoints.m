function V = removePoints(Vtemp)
% removePoints - Function used to remove points from a list that are
% 'close' to others in order to avoid errors when using functions like
% convhull.
% 
% Syntax:  
%    V = removePoints(Vtemp)
%
% Inputs:
%    Vtemp - vertex set from some set.
%
% Outputs:
%    V - vertex set with only points that are not very similar.
%
% Example: 
%    m = 10;
%    P = rand(2,m);
%    [F,p] = compilePoints(P);
%    V = rayShooting([],F,p,2,PointsCenter(P));
%    Vredux = removePoints(V);
%    plot(F,p); hold on; scatter(V(1,:),V(2,:),'b');
%    scatter(Vredux(1,:),Vredux(2,:),'k');
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

% let us remove duplicate points in V to avoid errors in convhulln
[~,I] = sort(Vtemp(1,:));
Vtemp = Vtemp(:,I);

V = zeros(size(Vtemp));
V(:,1) = Vtemp(:,1);
j = 2;
for i = 2:length(Vtemp)
    if norm(Vtemp(:,i) - Vtemp(:,i-1)) >= 1E-2
        V(:,j) = Vtemp(:,i);
        j = j + 1;
    end
end

% Return only the filled entries
V = V(:,1:j-1);
end

