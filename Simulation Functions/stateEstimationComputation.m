function [estimationErrors, computationTimes, volumes, nb_doubles, X] = stateEstimationComputation(methods, x, u, y, system, bounds)
% stateEstimationComputation - Runs the list of reachability methods using y
% to get an estimate xhat of x. It allows to specify combinations of bounds
% for noise, disturbance and x(0) signals such that multiple tests can be
% performed with a single use of this function.
%   Currently is running:
%       1) Intervals
%       2) Zonotopes
%       3) Polytopes
%       4) Constrained Zonotopes
%       5) Constrained Convex Generators
%       6) Ellipsoids
%       7) A-H Polytopes
%       8) Point-based
%       9) Set-Valued Observers (resort to polytopes)
% 
% Syntax:  
%    ... = stateEstimationComputation(...)
%
% Inputs:
%    methods - cell array of data structures containing all set functions.
%    x - cell array with the state trajectories to compute the error.
%    u - cell array of sequence of inputs used for x.
%    y - cell array of measurements for each simulation.
%    system - data structure with all the system parameters.
%    bounds - cell array of bounds for noise, disturbances and X(0).
%
% Outputs:
%    estimationErrors - estimation errors for each combination of bounds.
%    computationTimes - computing time for each combination of bounds.
%    volumes - hyper-volumes for all sets based on the Volume function.
%    nb_doubles - size of the data structures used by each set.
%    X - cell arry with data structures representing each X(k).
%
% Example: 
%    see ExampleStateEstimation.m that runs the state estimation example
%    and heavily resorts on this function.
%
% Other m-files required: none.
% Subfunctions: none
% MAT-files required: none
%
% See also: ExampleStateEstimation.m.
 
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

nb_methods = length(methods);
nb_bounds = length(bounds);

% simulation time used when computing the system data
simulationTime = size(x{1},2);

% system variables sizes
n = system.n;
nd = system.nd;
nn = system.nn;

% Initialization of the metrics used to compare the set representations
estimationErrors = zeros(nb_methods,nb_bounds,simulationTime);
computationTimes = zeros(nb_methods,nb_bounds,simulationTime);
volumes = zeros(nb_methods,nb_bounds,simulationTime);
nb_doubles = zeros(nb_methods,nb_bounds,simulationTime);
X = cell(nb_methods,nb_bounds);


% Run each of the reachability methods and obtain the metrics data

for id = 1:nb_methods
    
    for boundId = 1:nb_bounds
        % Create the sets D and N for the disturbance and noise values
        Disturbance = methods{id}.overbound(bounds{boundId}.disturbance);
        Noise = methods{id}.overbound(bounds{boundId}.noise);
        
        
        % Estimate the state for each iteration
        for k = 1:simulationTime
            if k == 1
                % Initialize the estimate using the specific data structure
                tic;
                X{id,boundId}{1} = methods{id}.overbound(bounds{boundId}.initial);
            else
                tic;
                % propagate
                X{id,boundId}{k} = methods{id}.propagate(system,X{id,boundId}{k-1},u{boundId}(:,k-1),Disturbance);
                % update
                X{id,boundId}{k} = methods{id}.update(system,X{id,boundId}{k},u{boundId}(:,k),y{boundId}(:,k),Noise);
            end
            
            % Compute metrics
            % Estimation error
            estimationErrors(id,boundId,k) = norm(methods{id}.estimate(X{id,boundId}{k})-x{boundId}(:,k),2);
            
            % Computation time including the time it takes to compute an
            % estimate out of the set
            computationTimes(id,boundId,k) = toc;
            
            % Hyper-volume of the sets
            volumes(id,boundId,k) = methods{id}.volume(X{id,boundId}{k});
            
            % Number of double variables used in the data structures
            nb_doubles(id,boundId,k) = methods{id}.space(X{id,boundId}{k});
        end
    end
end

