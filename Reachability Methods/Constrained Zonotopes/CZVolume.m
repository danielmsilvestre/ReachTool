function vol = CZVolume(X)
% CZVolume - Function that calculates the hypervolume of the Constrained
% Zonotope.
% 
% Syntax:  
%    vol = CZVolume(X)
%
% Inputs:
%    X - Constrained Zonotope
%
% Outputs:
%    vol - volume
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    vol = CZVolume(X)
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
[F,p] = compileCZ(X);

if n == 1
    v = sdpvar;
    
    getExtremes = optimizer(F,v*p,sdpsettings('solver','mosek,sedumi,quadprog'),v,p);
    vol = getExtremes(-1) - getExtremes(1);
else
    % If 2D or 3D use Yalmip along with convhull
    if n <= 3
        vertices = plot(F,p(1:n),[],300);
        [~,vol] = convhull(vertices{1}','Simplify',true);
    else
        % Let us resort to an implementation of a ray shooting technique
        disp(['CZVolume G is ',num2str(size(X.G,1)),'x',num2str(size(X.G,2)),', A is ',num2str(size(X.A,1)),'x',num2str(size(X.A,2))]);
        vol = VolumeRayShooting(F,p,n,CZCenter(X));
    end
    
end
end

