function vol = PolyVolume(X)
% PolyVolume - Function that calculates the hypervolume of a Polytope.
% 
% Syntax:  
%    vol = PolyVolume(X)
%
% Inputs:
%    X - Polytope
%
% Outputs:
%    vol - volume
%
% Example: 
%    m = 10;
%    X.n = 2;
%    X.A = randn(m,2);
%    X.b = rand(m,1)*m;
%    X.Aeq = zeros(0,2);
%    X.beq = zeros(0,1);
%    vol = PolyVolume(X)
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


[F,p] = compilePoly(X);

if X.n == 1
    v = sdpvar;
    
    getExtremes = optimizer(F,v*p,sdpsettings('solver','mosek,sedumi,quadprog'),v,p);
    vol = getExtremes(-1) - getExtremes(1); % max - min
else
    % If 2D or 3D use Yalmip along with convhull
    if X.n <= 3
        vertices = plot(F,p(1:X.n),[],300);
        [~,vol] = convhull(vertices{1}','Simplify',true);
    else
        % Let us resort to an implementation of a ray shooting technique
        disp(['PolyVolume A is ',num2str(size(X.A,1)),'x',num2str(size(X.A,2)),', Aeq is ',num2str(size(X.Aeq,1)),'x',num2str(size(X.Aeq,2))]);
        vol = VolumeRayShooting(F,p,X.n,PolyCenter(X));
    end
    
end
end

