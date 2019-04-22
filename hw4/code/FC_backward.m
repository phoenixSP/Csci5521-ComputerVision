function [dLdx, dLdw, dLdb] = FC_backward(dLdy, x, w, b, y) 

dydx=w;
dLdx=dLdy * dydx;
dLdb=dLdy;
dLdw=dLdy'*x';

end

