function [L, dLdy] = Loss_cross_entropy_softmax(x, y) 

softmax = SoftMax(x);
L=-y'*log(softmax);
dLdy=(softmax-y)';

end