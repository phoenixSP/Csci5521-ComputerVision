function [y] = Conv(x, w_conv, b_conv) 

h=size(x,1);
w=size(x,2);

[kernel_x,kernel_y,n_channels,n_filters]=size(w_conv);

y=zeros(h,w,n_filters);
x_padded=padarray(x,[1 1],0,'both');

for i=1:n_filters
    conv_product=zeros(h,w,n_channels);
    for j=1:n_channels
        im_col=im2col(x_padded(:,:,j),[kernel_x kernel_y]);
        kernel=w_conv(:,:,j,i);
        temp=im_col.*reshape(kernel,[],1);
        temp1=sum(temp,1);
        conv_product(:,:,j)=reshape(temp1,14,14);
    end
    bias=b_conv(i)*ones(h,w);
    y(:,:,i)=sum(conv_product,3)+bias;
end

end