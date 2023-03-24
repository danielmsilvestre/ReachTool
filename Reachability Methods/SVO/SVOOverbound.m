function X = SVOOverbound(set)
%POLYOVERBOUND Summary of this function goes here
%   Detailed explanation goes here

n = set.n;
switch lower(set.type)
    case 'ball'
        X = struct('A',kron([1;-1],eye(n)),'b',kron(ones(2,1),set.radius),'Aeq',[],'beq',[],'n',n);
    otherwise
        error('Not implemented the overbounding function for SVO sets.');
%         X = struct('A',kron([1;-1],eye(n)),'b',set.radius*ones(2*n,1),'Aeq',[],'beq',[],'n',n);
end
end

