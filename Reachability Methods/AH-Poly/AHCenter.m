function c = AHCenter(X)
% AHCenter - Function that calculates the center of a A-H polytope by
% framing it as the Chebyshev center.
% 
% Syntax:  
%    c = AHcenter(X)
%
% Inputs:
%    X - A-H polytope
%
% Outputs:
%    c - Chebyshev center 
%
% Example: 
%    m = 10;
%    X.G = rand(2,m);
%    X.c = zeros(2,1);
%    X.H = [eye(m);-eye(m)];
%    X.h = ones(2*m,1);
%    c = AHCenter(X)
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

n = size(X.H,2);

% Create optimization variables for the center and radius of the ball
xc = sdpvar(n,1);
Rc = sdpvar;

% Trivially get the polytope generating the A-H polytope
P = X.H;
p = X.h;

% Chebyshev optimization
F = P * xc + sqrt(sum(P.^2,2)) * Rc <= p;

optimize(F,-Rc,sdpsettings('verbose',0));

% Apply the linear map to get the image of the center of the generator set
c = X.G*value(xc) + X.c;
end

