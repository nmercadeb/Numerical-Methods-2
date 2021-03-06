% Function that computes the jacobian matrix of a vector function f, at a point x
% Input:   x - [Rn column vector] - Evaluation point
%          f - [vector function (Rm --> Rn)] - continuous and differentiable function 
%
% Output: Df - [n x m Matrix] - Jacobian matrix of f at x 
function Df=jacmod(f,x,T)
fa=f(x,T); n=length(fa); m=length(x);
Df=zeros(n,m);
H=sqrt(eps)*eye(m);
for j=1:m
    fb=f(x+H(:,j),T); Df(:,j)=(fb-fa)/H(j,j);
end
end