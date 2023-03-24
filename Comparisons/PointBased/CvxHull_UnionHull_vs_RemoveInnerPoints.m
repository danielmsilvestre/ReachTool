% CvxHull_UnionHull_vs_RemoveInnerPoints - Script that compares the speed
% of performing the convex hull of two polytopes as the union hull of their
% points in comparison with the concatenation followed by a removal of
% the points that lie in the interior of the set.
% 
% Syntax:  
%    run the script
%
% Inputs:
%    none
%
% Outputs:
%    total time spent doing the convex hull with the two methods
%
% Example: 
%    random sets represented by vertices
%
% Other m-files required: removeInnerPoints.m
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

clearvars;
close all;

m = 1E2;
N = 1E3; % number of tests

times = zeros(2,N);

for i = 1:N
    
    % generate set P
    P = rand(2,m);
    P = removeInnerPoints(P);
    
    % generate set Q
    Q = rand(2,m);
    Q = removeInnerPoints(Q);
    
    % Calculate the convex hull of P and Q using unionHull
    tic;
    U = unionHull('vert',P','vert',Q'); % transpose to convert to 1 point per row format
    
    X = U.vert'; % convert back to 1 point per column
    times(1,i) = toc;
    
    % Calculate the convex hull of P and Q using concatenation followed by
    % removing inner points
    tic;
    Y = removeInnerPoints([P,Q]);
    times(2,i) = toc;
    
end

meanTimes = mean(times,2);

if meanTimes(1,1) < meanTimes(2,1)
    fprintf('It is faster to perform unionHull!\n');
else
    fprintf('It is faster to remove inner points!\n');
end

fprintf('The method %18s took %1.4e seconds \n',[["UnionHull","RemoveInnerPoints"];meanTimes']);


