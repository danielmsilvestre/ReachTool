function X = SVOPropagate(system, prevX, u, d)
%POLYPROPAGATE Summary of this function goes here
%   Detailed explanation goes here

n = prevX.n;

F = system.A;
[r,c] = size(F);

if r == c && rank(F) == r % matrix A is invertible
    X.A = [prevX.A(:,1:n) / F, prevX.A(:,(n+1):end),-prevX.A(:,1:n) / F * system.L;...
           zeros(size(d.A,1),size(prevX.A,2)), d.A];
    X.b = [prevX.b + prevX.A(:,1:n) / F * system.B * u;...
           d.b];
    if ~isempty(prevX.Aeq)
        X.Aeq = [prevX.Aeq(:,1:n) / F, prevX.Aeq(:,(n+1):end),-prevX.Aeq(:,1:n) / F * system.L;...
                 zeros(size(d.A,1),size(prevX.Aeq,2)), d.A];
        X.beq = [prevX.beq + prevX.Aeq(:,1:n) / F * system.B * u;...
                 d.b];
    else
        X.Aeq = [];
        X.beq = [];
    end
    X.n = r;
else
    disp('Still to be implemented the SVO propagation with a singular A matrix!');
end
end

