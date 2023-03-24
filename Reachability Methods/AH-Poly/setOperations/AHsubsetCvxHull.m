function result = AHsubsetCvxHull(Y)
% AHcvxHull - Function that checks for all A-H polytopes if each is
% contained in a convex hull of the remaining. It returns a boolean vector
% that identifies which sets are a subset of the others.
% 
% Syntax:  
%    result = AHsubsetCvxHull(Y)
%
% Inputs:
%    Y - cell array of A-H polytopes
%
% Outputs:
%    result - boolean vector that asserts whether each set is a subset of
%    the others.
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.H = [eye(m);-eye(m)];
%    X.h = ones(2*m,1);
%    Y{1} = X;
%    Y{2} = X;
%    Y{2}.G = 0.5*Y{2}.G;
%    result = AHsubsetCvxHull(Y) % second one is trivially a subset of the
%    first
%
% Other m-files required: none.
% Subfunctions: Solver Mosek. It works without it but is highly recommended
% for a faster computation or it will resort to fmincon.
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

N = length(Y)-1;

persistent sizes;
persistent subsetCheck

%% Create the optimizer object

X = Y{1}; % any set in Y has the same size

if isempty(subsetCheck) || any(sizes.G ~= size(X.G)) || any(sizes.c ~= size(X.c)) || any(sizes.H ~= size(X.H)) || any(sizes.h ~= size(X.h))
    sizes.G = size(X.G);
    sizes.c = size(X.c);
    sizes.H = size(X.H);
    sizes.h = size(X.h);
    % input variables
    Yc = cell(1,N);
    YG = cell(1,N);
    YH = cell(1,N);
    Yh = cell(1,N);
    XG = sdpvar(size(X.G,1),size(X.G,2),'full');
    XH = sdpvar(size(X.H,1),size(X.H,2),'full');
    Xh = sdpvar(size(X.h,1),size(X.h,2));
    Xc = sdpvar(size(X.c,1),size(X.c,2));
    for i = 1:N
        Yc{i} = sdpvar(size(X.c,1),size(X.c,2));
        YG{i} = sdpvar(size(X.G,1),size(X.G,2),'full');
        YH{i} = sdpvar(size(X.H,1),size(X.H,2),'full');
        Yh{i} = sdpvar(size(X.h,1),size(X.h,2));
    end
    
    suml = 0;
    sumxbar = 0;
    sumX = zeros(size(X.G));
    
    % Constraint set
    C = [];
    Lambda = cell(1,N);
    Gamma = cell(1,N);
    beta = cell(1,N);
    lambda = cell(1,N);
    
    for i = 1:N
        m = size(Y{i}.G,2);
        Lambda{i} = sdpvar(size(Y{i}.H,1),size(X.H,1),'full');
        Gamma{i} = sdpvar(size(Y{i}.H,2),size(X.H,2),'full');
        lambda{i} = sdpvar;
        beta{i} = sdpvar(m,1);
        
        suml = suml + lambda{i};
        sumxbar = sumxbar + lambda{i} * Yc{i} - YG{i}*beta{i};
        sumX = sumX + YG{i} * Gamma{i};
        
        C = [C, Lambda{i} >= 0,...
            lambda{i} >= 0,...
            Lambda{i}*XH == YH{i}*Gamma{i},...
            Lambda{i}*Xh <= lambda{i} * Yh{i} + YH{i}*beta{i}];
    end
    C = [C, suml == 1, Xc == sumxbar, XG == sumX];
    s = sdpsettings('solver','mosek','verbose',0,'cachesolvers',1);
    parameters_in = {[YG{:}],[Yc{:}],[YH{:}],[Yh{:}],XG,Xc,XH,Xh};
    solutions_out = [];
    % We try to create the optimizer object with mosek if it is available.
    % This could not be done with ('solver','mosek,*') because Yalmip goes
    % to the default of using fmincon (1 order of magnitude slower)
    try
        subsetCheck = optimizer(C,0,s,parameters_in,solutions_out);
    catch 
        s = sdpsettings(s,'solver','');
        subsetCheck = optimizer(C,0,s,parameters_in,solutions_out);
    end
end

%% Check each set if it belongs to the convex hull of the remaining
result = zeros(1,length(Y));
for setId = 1:length(Y)
    X = Y{setId};
    
    YGs = cellfun(@(x) x.G,Y(1:end ~= setId),'UniformOutput',false);
    Ycs = cellfun(@(x) x.c,Y(1:end ~= setId),'UniformOutput',false);
    YHs = cellfun(@(x) x.H,Y(1:end ~= setId),'UniformOutput',false);
    Yhs = cellfun(@(x) x.h,Y(1:end ~= setId),'UniformOutput',false);
    
    inputs = {[YGs{:}],[Ycs{:}],[YHs{:}],[Yhs{:}],X.G,X.c,X.H,X.h};
    
    [~,diagnostics] = subsetCheck(inputs);
    
    result(setId) = ~diagnostics;
end

