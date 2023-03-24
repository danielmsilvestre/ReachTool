function methods = getReachabilityFcns(names)
% getReachabilityFcns - Function to return a data structure containing all
% methods for the specified types of reachable sets given in 'names'. This
% function could later become deprecated once objects representing the sets
% are also included in the toolbox. 
% 
% Syntax:  
%    methods = getReachabilityFcns(names)
%
% Inputs:
%    names - cell array of strings identifying the sets to be used.
%
% Outputs:
%    methods - cell array with data structures containing all the methods
%    for each set type.
%
% Example: 
%    methods = getReachabilityFcns({'Intervals','Zonotopes','Polytopes','Constrained Zonotopes','CCG'})
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

% initialize the methods functions
methods = cell(1,length(names));

for i = 1:length(names)
    switch lower(names{i})
        case 'intervals'
            methods{i} = struct('propagate',@intervalPropagate,'update',@intervalUpdate, 'estimate', @intervalCenter, 'volume', @intervalVolume, 'space', @intervalNbDoubles, 'overbound', @intervalOverbound, 'minkowskiSum', @intervalMinkowskiSum, 'linMap', @intervalLinMap, 'compile', @compileInterval);
        case 'zonotopes'
            methods{i} = struct('propagate',@ZonotopePropagate,'update',@ZonotopeUpdate, 'estimate', @ZonotopeCenter, 'volume', @ZonotopeVolume, 'space', @ZonotopeNbDoubles, 'overbound', @ZonotopeOverbound, 'minkowskiSum', @ZonotopeMinkowskiSum, 'linMap', @ZonotopeLinMap, 'compile', @compileZonotope);
        case 'polytopes'
            methods{i} = struct('propagate',@PolyPropagate,'update',@PolyUpdate, 'estimate', @PolyCenter, 'volume', @PolyVolume, 'space', @PolyNbDoubles, 'overbound', @PolyOverbound, 'minkowskiSum', @PolyMinkowskiSum, 'linMap', @PolyLinMap, 'compile', @compilePoly);
        case 'svos'
            methods{i} = struct('propagate',@SVOPropagate,'update',@SVOUpdate, 'estimate', @SVOCenter, 'volume', @SVOVolume, 'space', @SVONbDoubles, 'overbound', @SVOOverbound, 'minkowskiSum', @SVOMinkowskiSum, 'linMap', @SVOLinMap, 'compile', @compileSVO);
        case 'constrained zonotopes'
            methods{i} = struct('propagate',@CZPropagate,'update',@CZUpdate, 'estimate', @CZCenter, 'volume', @CZVolume, 'space', @CZNbDoubles, 'overbound', @CZOverbound, 'cvxHull', @CZcvxHull, 'subsetCvxHull', @CZsubsetCvxHull, 'minkowskiSum', @CZMinkowskiSum, 'linMap', @CZLinMap, 'compile', @compileCZ);
        case 'ccg'
            methods{i} = struct('propagate',@CCGPropagate,'update',@CCGUpdate, 'estimate', @CCGCenter, 'volume', @CCGVolume, 'space', @CCGNbDoubles, 'overbound', @CCGOverbound, 'minkowskiSum', @CCGMinkowskiSum, 'linMap', @CCGLinMap, 'compile', @compileCCG);
        case 'ellipsoids'
            methods{i} = struct('propagate',@EllipsoidsPropagate,'update',@EllipsoidsUpdate, 'estimate', @EllipsoidsCenter, 'volume', @EllipsoidsVolume, 'space', @EllipsoidsNbDoubles, 'overbound', @EllipsoidsOverbound, 'minkowskiSum', @EllipsoidsMinkowskiSum, 'linMap', @EllipsoidsLinMap, 'compile', @compileEllipsoid);
        case 'points'
            methods{i} = struct('propagate',@PointsPropagate,'update',@PointsUpdate, 'estimate', @PointsCenter, 'volume', @PointsVolume, 'space', @PointsNbDoubles, 'overbound', @PointsOverbound, 'cvxHull', @PointscvxHull, 'minkowskiSum', @PointsMinkowskiSum, 'linMap', @PointsLinMap, 'compile', @compilePoints);
        case 'ah-polytopes'
            methods{i} = struct('propagate',@AHPropagate,'update',@AHUpdate, 'estimate', @AHCenter, 'volume', @AHVolume, 'space', @AHNbDoubles, 'overbound', @AHOverbound, 'cvxHull', @AHcvxHull, 'subsetCvxHull', @AHsubsetCvxHull, 'minkowskiSum', @AHMinkowskiSum, 'linMap', @AHLinMap, 'compile', @compileAH);
        otherwise
            error(['Method ', names{i}, ' currently not implemented. Please implement it and add to the getReachabilityFcns function.']);
    end
end

