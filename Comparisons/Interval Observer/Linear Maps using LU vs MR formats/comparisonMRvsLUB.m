% comparisonMRvsLUB - Script comparing the speed of performing linear maps using the extreme
% values or the midpoints and radius formats
%
% It clearly shows that for large matrices the midpoints/radius are a better format for the interval observer.
% 
% Syntax:  
%    run the script
%
% Inputs:
%    none
%
% Outputs:
%    total time spent doing the linear maps for both formats
%
% Example: 
%    random linear maps
%
% Other m-files required: intervalLinMapLUB.m, intervalLinMap.m
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

s = 50;

% Generate some arbitrary input
A = magic(s);
bvalues = -10+randi(20,[s,2]);
bvalues = sort(bvalues,2);

% Create the interval data structure
b.lb = bvalues(:,1);
b.ub = bvalues(:,2);

% Create the same but in midpoints and radius representation
Bi.midpoints = 0.5*(b.lb+b.ub);
Bi.radius = 0.5*(b.ub-b.lb);
times = zeros(2,1);

for i = 1:1e3
    tic;
    resultLUB = intervalLinMapLUB(A,b,zeros(s,1));
    t = toc;
    times(1,1) = times(1,1) + t;
    
    tic;
    result = intervalLinMap(A,Bi,zeros(s,1));
    t = toc;
    times(2,1) = times(2,1) + t;
    
    if any(abs(result.midpoints + result.radius - resultLUB.ub) > 1e-3) || any(abs(result.midpoints - result.radius - resultLUB.lb) > 1e-3)
        disp('Error');
    end
end

fprintf('Time spent by LinMap LUB: %8.4f\nTime spent by LinMap MR:  %8.4f \n',times);
    
