function [x1, x2] = FindMatch(I1, I2)
I1 = single(I1);
[f_template,d_template] = vl_sift(I1) ;

I2 = single(I2);
[f_target,d_target] = vl_sift(I2) ;

d_target_t=double(transpose(d_target));
d_template_t=double(transpose(d_template));

[index, distance]=knnsearch(d_target_t,d_template_t,'K',2);

x1=[];
x2=[];
[m,~]=size(distance);
for i=1:m
    if distance(i,1)/distance(i,2)<0.7
        [index_rev, ~]=knnsearch(d_template_t,d_target_t(index(i),:));
        
        if i==index_rev
            x1=[x1,f_template(1:2,i)];
            x2=[x2,f_target(1:2,index(i))];
        end
    end
end

x1=transpose(x1);
x2=transpose(x2);
end
