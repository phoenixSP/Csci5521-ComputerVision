function [A_refined] = AlignImage(template, target, A)
[i_x,i_y] = imgradientxy(template);

[m,n]=size(template);
steepest_descent_images=[];
% disp("getting J and sdi");
for i=1:m
    for j=1:n
        J=[i_x(i,j) i_y(i,j)]*[[j i 1 0 0 0];[0 0 0 j i 1]];
%         H=H+J'*J;
        steepest_descent_images=[steepest_descent_images; J];
    end
end

H=steepest_descent_images'*steepest_descent_images;
epsilon=0.01;
del_p=ones(6,1);
A_refined=A;
iter=0;
error=[];

% disp("Refining");
while norm(del_p)>epsilon
    iter=iter+1;
    
    I_warped=WarpImage(target, A_refined, size(template));
    err=reshape((I_warped-template)',[],1);
    
    error=[error norm(double(err))];
    
    F=double(steepest_descent_images)'*double(err);
    del_p=H\F;
    p_prime=reshape(del_p,3,2)';
    del_A=[p_prime;[0 0 1]];
    del_A(1,1)=del_A(1,1)+1;
    del_A(2,2)=del_A(2,2)+1;
    A_refined=A_refined*pinv(del_A);
end

%plotting error vs iterations
x=1:iter;
figure;
plot(x,error,'linewidth',2);
ylabel("Error");
xlabel("Number of iteration");
end