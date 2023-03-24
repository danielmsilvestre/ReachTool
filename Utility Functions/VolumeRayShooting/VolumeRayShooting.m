function vol = VolumeRayShooting(F,p,n,center)
% VolumeRayShooting - Function that approximates the volume of any set by
% the volume of an inner polytope until the growth of collecting another
% set of points on the surface would result in less than 1% growth.
% 
% Syntax:  
%    vol = VolumeRayShooting(F,p,n,center)
%
% Inputs:
%    F - Yalmip constraint set representing the reachable set.
%    p - sdpvar to represent a point in the set.
%    n - size of the state space.
%    center - a guess for the center.
%
% Outputs:
%    vol - underapproximation of the real volume.
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.A = zeros(0,m);
%    X.b = zeros(0,1);
%    [F,p] = compileCZ(X);
%    vol = VolumeRayShooting(F,p,2,X.c)
%
% Other m-files required: rayShooting.m, convhulln.m.
% Subfunctions: none
% MAT-files required: none
%
% See also: Volume functions for CCGs and anything representing a polytope.
 
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

prev_vol = 1E-10;
vol = 0;
allPoints = [];
while abs(vol/prev_vol-1) >= 1e-2
    prev_vol = vol;
    allPoints = rayShooting(allPoints,F,p,n,center);
    [~,vol] = convhulln(allPoints');
    disp(['Volume: ', num2str(vol), ' increment: ',num2str((vol/prev_vol-1)*100), '% nb_points: ',num2str(size(allPoints,2))]);
end
end

