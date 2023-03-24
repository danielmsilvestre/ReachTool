function nextX = ZonotopeUpdate(system, X, u, y, noise)
% ZonotopeUpdate - Function encapsulating the update phase of a
% set-valued state estimation for a linear system with no uncertainties.
% 
% The function returns the set X(k) that satisfies the measurement set Y(k):
% X(k) = Xp(k) intersect_C Y(k) 
% 
% Syntax:  
%    nextX = ZonotopeUpdate(system, X, u, y, noise)
%
% Inputs:
%    system - structure with all the matrices from the dynamical model
%    X - propagated set-valued estimate X(k)
%    u - value of the actuation
%    y - measurement
%    noise - set for the noise
%
% Outputs:
%    nextX - Zonotope with all values that can result in the
%    measurement y given the noise set.
%
% Example: 
%    m = 10;
%    X.H = rand(2,m);
%    X.p = zeros(2,1);
%    noise = X; % assume noise is equal to the state for illustration
%    system = struct('C',eye(2),'N',eye(2),'D',zeros(2));
%    X = ZonotopeUpdate(system, X, ones(2,1), 2*ones(2,1), noise)
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


% fast method
Y = ZonotopeLinMap(-system.N,noise,y - system.D * u);
Y = boxZonotope(Y);

n = size(X.H,1);

H = X.H;
p = X.p;

for jout = 1:size(system.C,1) % take each measurement as independent and intersect 
    c = system.C(jout,:)';
    d = Y.p(jout,1);
    sigma = Y.H(jout,jout);
    
    % compute the intersection with the strip for the jout measurement
    % Test added to avoid numerical problems
    if abs((c'*(H*H')*c+sigma^2)) < 1E-8
        if abs(c'*p - d) <= 1E-8
            continue;
        else
            nextX.H = nan(size(H));
            nextX.p = nan(size(p));
            return;
        end
    end
    lstar = (H*H'*c)/(c'*H*H'*c+sigma^2);
    H = [(eye(n)-lstar*c')*H, sigma*lstar];
    p = p + lstar * (d - c'*p);
    
end
nextX.H = H;
nextX.p = p;



end

