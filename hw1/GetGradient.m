function [grad_mag, grad_angle] = GetGradient(im_dx, im_dy)

    grad_mag=sqrt(im_dx.^2 + im_dy.^2);
    grad_angle=atan2(im_dy, im_dx);
    grad_angle(grad_angle<0)=grad_angle(grad_angle<0) + pi;
    grad_angle(grad_angle==pi)=0;
    
end