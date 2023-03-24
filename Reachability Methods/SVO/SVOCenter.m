function c = SVOCenter(X)
%POLYCENTER Summary of this function goes here
%   Detailed explanation goes here

option = true;

if option
    
    
    n = size(X.A,2);
    
    xc = sdpvar(n,1);
    Rc = sdpvar;
    
    P = [X.A;X.Aeq;-X.Aeq];
    p = [X.b;X.beq;-X.beq];
    
    F = P * xc + sqrt(sum(P.^2,2)) * Rc <= p;
    
    optimize(F,-Rc,sdpsettings('solver','mosek','verbose',0));
    
    c = value(xc);
    c = c(1:X.n);
    
else
    [Fp,pp] = compilePoly(X);
    
    vertices = plot(Fp,pp(1:2));
    V = vertices{1}';
    verticesRedux = V(1,:);
    n = size(V,1);
    for i = 2:size(V,1)
        V(i,:)
        if all(sum(abs(kron(V(i,:),ones(size(verticesRedux,1),1))-verticesRedux),2)>1E-3)
            verticesRedux = [verticesRedux; V(i,:)];
        end
    end
    
    U=unionHull('vert',verticesRedux);
    Xr.A = U.lcon{1};
    Xr.b = U.lcon{2};
    Xr.Aeq = U.lcon{3};
    Xr.beq = U.lcon{4};
    Xr.n = 2;
    
    n = size(Xr.A,2);
    
    xc = sdpvar(n,1);
    Rc = sdpvar;
    
    P = [Xr.A;Xr.Aeq;-Xr.Aeq];
    p = [Xr.b;Xr.beq;-Xr.beq];
    
    F = P * xc + sqrt(sum(P.^2,2)) * Rc <= p;
    
    optimize(F,-Rc,sdpsettings('solver','mosek','verbose',0));
    
    c = value(xc);
end
end

