function S = getSimpleSets(type, n, uncertainty, subtype)
% getSimpleSets - Function to prepare a data structure containing the
% information to be used to mention a norm (or possibly other type) set.
% This set can be overbounded using the specific functions from each set
% representation.
% 
% Syntax:  
%    S = getSimpleSets(type, n, uncertainty, subtype)
%
% Inputs:
%    type - 'ball' to mention a norm bound
%    n - size of the state space for that set
%    uncertainty - radius for that set
%    subtype - type of norm used
%
% Outputs:
%    S - set description without any given representation.
%
% Example: 
%    S = getSimpleSets('ball',2,5,inf)
%
% Other m-files required: overbound function for each set.
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

switch lower(type)
    case 'ball'
        S.type = 'ball';
        S.subtype = subtype;
        if length(uncertainty) == 1
            S.radius = uncertainty * ones(n,1);
        else
            S.radius = uncertainty;
        end
        S.n = n;
    otherwise
        error(['The requested set has not been defined in the getSimpleSets function.' newline 'Either declare it there or create the structure corresponding to the desired set.']);
end

end

