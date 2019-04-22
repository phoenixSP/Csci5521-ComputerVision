function [y] = Pool2x2(x)

[h,w,n_channels]=size(x);
y=zeros(h/2,w/2,n_channels);

for i=1:n_channels
    maxpool=im2col(x(:,:,i),[2 2],'distinct');
    y(:,:,i)=reshape(max(maxpool,[],1),h/2,w/2);
end

end