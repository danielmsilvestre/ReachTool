function vol = SVOVolume(X)
%POLYVOLUME Summary of this function goes here
%   Detailed explanation goes here

m = size(X.A,2);

if X.n == 1
    p = sdpvar(m,1);
    v = sdpvar(m,1);
    if isempty(X.Aeq)
        F =  X.A * p <= X.b;
    else
        F = [X.A * p <= X.b, X.Aeq * p == X.beq];
    end
    getExtremes = optimizer(F,v'*p,sdpsettings('solver','mosek'),v,v'*p);
    vol = -getExtremes(-e(1,m)) - getExtremes(e(1,m));
else
    
    p = sdpvar(m,1);
    if isempty(X.Aeq)
        F =  X.A * p <= X.b;
    else
        F = [X.A * p <= X.b, X.Aeq * p == X.beq];
    end
    
    % If 2D or 3D use Yalmip along with convhull
    if X.n <= 3
        vertices = plot(F,p(1:X.n),[],300);
        [~,vol] = convhull(vertices{1}','Simplify',true);
    else
        % Let us resort to an implementation of a ray shooting technique
        disp(['SVOVolume A is ',num2str(size(X.A,1)),'x',num2str(size(X.A,2)),', Aeq is ',num2str(size(X.Aeq,1)),'x',num2str(size(X.Aeq,2))]);
        vol = VolumeRayShooting(F,p,X.n,PolyCenter(X));
    end
    
end

