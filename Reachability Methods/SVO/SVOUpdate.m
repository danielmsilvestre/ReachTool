function nextX = SVOUpdate(system, X, u, y, noise)
%POLYUPDATE Summary of this function goes here
%   Detailed explanation goes here

n = X.n;
nextX.A = [X.A;
           kron([1;-1],system.C),zeros(2*size(system.C,1),size(X.A,2)-n)];
nextX.b = [X.b;[y;-y]+system.N * noise.b];
nextX.Aeq = [];
nextX.beq = [];
nextX.n = n;

if abs(noise.A) ~= ones(size(noise.A))
    disp('SVOs with general noise sets are still to be implemented');
end

if sum(sum(system.D)) ~= 0
    disp('SVOs with a nonzero D matrix are still to be implemented');
end
end

