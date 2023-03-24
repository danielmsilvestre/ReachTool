function vol = AHVolume(X)
% AHVolume - Function that calculates the hypervolume of the A-H polytope.
% 
% Syntax:  
%    vol = AHVolume(X)
%
% Inputs:
%    X - A-H polytope
%
% Outputs:
%    vol - volume
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.H = [eye(m);-eye(m)];
%    X.h = ones(2*m,1);
%    vol = AHVolume(X)
%
% Other m-files required: VolumeRayShooting.m.
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

[n,~] = size(X.G);
[F,p] = compileAH(X);

if n == 1
    v = sdpvar;
    
    getExtremes = optimizer(F,v*p,sdpsettings('solver','mosek,*'),v,p);
    vol = getExtremes(-1) - getExtremes(1);
else
    % If 2D or 3D use Yalmip along with convhull
    if n <= 3
        vertices = plot(F,p(1:n),[],300);
        [~,vol] = convhull(vertices{1}','Simplify',true);
    else
        % Let us resort to an implementation of a ray shooting technique
        disp(['AHVolume G is ',num2str(size(X.G,1)),'x',num2str(size(X.G,2)),', H is ',num2str(size(X.H,1)),'x',num2str(size(X.H,2))]);
        vol = VolumeRayShooting(F,p,n,AHCenter(X));
    end
    
end
end

