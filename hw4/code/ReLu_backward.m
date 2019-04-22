function [dLdx] = ReLu_backward(dLdy, x, y)

if size(size(x))==2
    dydx=x>0;
    dLdx=(dLdy.*dydx');
else
    dLdx=dLdy;
    dLdx(x<0)=0;
end

end