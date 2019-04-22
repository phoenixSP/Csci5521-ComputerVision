function [dLdx] = Flattening_backward(dLdy, x, y) 
    dLdx = reshape(dLdy, size(x));
end