function p = randBallPoint(set,n,radius,samples)
% randBallPoint - Function that generates samples at random from some unit
% ball set with desired radius.
% 
% Syntax:  
%    p = randBallPoint(set,n,radius,samples)
%
% Inputs:
%    set - abstract description of the set.
%    n - size of the state space.
%    radius - length of the set.
%    samples - number of desired random points.
%
% Outputs:
%    p - matrix containing all points.
%
% Example: 
%    set = getSimpleSets('ball',2,5,inf);
%    p = randBallPoint(set,2,5,10)
%
% Other m-files required: none.
% Subfunctions: none
% MAT-files required: none
%
% See also: getSimpleSet.m.
 
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

if nargin < 3
  samples = 1;
end

switch lower(set.type)
    case 'ball'
        if isinf(set.index)
            p = -radius + 2*radius*rand(n,samples);
        elseif set.index == 2
            % First generate random directions by normalizing the length of a
            % vector of random-normal values (these distribute evenly on the ball).
            random_directions = randn(n,samples);
            random_directions = random_directions ./ vecnorm(random_directions);
            % Second generate a random radius with probability proportional to
            % the surface area of a ball with a given radius.
            random_radii = rand(1,samples) .^ (1/n);
            % Return the list of random (direction & length) points.
            p = radius * (random_directions .* random_radii);
        else
            error('There are no methods implemented to generate random noise of a ball other than inf and 2.');
        end
        
    otherwise
        error('There are no methods implemented to generate random noise from the desired set.');
end

end

