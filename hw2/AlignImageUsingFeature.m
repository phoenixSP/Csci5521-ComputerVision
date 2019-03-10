function [A] = AlignImageUsingFeature(x1, x2, ransac_thr, ransac_iter)

[m1,~]=size(x1);

rng('default');
max_inlier=-1;

for i=1:ransac_iter
    r = randperm(m1,3);
    coordinates=[x1(r,:) ones(3,1)];

    curr_A=[[coordinates zeros(3)]; [zeros(3) coordinates]];
    b=reshape(x2(r,:),[],1);
    param=pinv(curr_A'*curr_A)*(curr_A'*b);
    
    %counting the number of inliers
    affine_param=reshape(param,3,2)';
    x1_t=[x1 ones(size(x1(:,1)))];
    transformed_coordinated_0=affine_param*(x1_t');
    
    transformed_coordinated_0=transformed_coordinated_0';
    difference=zeros(size(x2(:,1)));
    
    for idex=1:size(x2(:,1))
        difference(idex)=norm(x2(idex,:)-transformed_coordinated_0(idex,:));
    end
    
    no_of_inliers=sum(difference<=ransac_thr);
    
    if max_inlier<no_of_inliers
        A=affine_param;
        max_inlier=no_of_inliers;
    end  
end
A=[A;[0,0,1]];
end