function [F,p] = compileSVO(X)
%COMPILEPOLY Summary of this function goes here
%   Detailed explanation goes here

p = sdpvar(size(X.A,2),1);

if ~isempty(X.Aeq)
    F = [X.A*p<=X.b,X.Aeq * p == X.beq];
else
    F = [X.A*p<=X.b];
end
end

