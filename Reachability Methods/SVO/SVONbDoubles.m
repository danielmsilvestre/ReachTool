function total = SVONbDoubles(X)
%PolyNBDOUBLES Summary of this function goes here
%   Detailed explanation goes here

[np,n] = size(X.A);
[npeq,neq] = size(X.Aeq);

total = np*(n + 1) + npeq*(neq + 1);
end

