function [dLdw, dLdb] = Conv_backward(dLdy, x, w_conv, b_conv, y) 

[~,~,n_channels]=size(x);

    [~,kernel_size,~,n_filters]=size(w_conv);

    x_padded = padarray(x, [(kernel_size-1)/2,(kernel_size-1)/2]);
    dLdw = zeros(size(w_conv));
    dLdb = zeros(size(b_conv));
    for i=1:n_filters
        dldw = zeros([kernel_size,kernel_size,n_channels]);
        for j=1:n_channels
            dldy = dLdy(:,:,i);
            temp = im2col(x_padded(:,:,j),[kernel_size,kernel_size]);
            temp = temp';
            dldw(:,:,j) = reshape(dldy(:)'*temp, [kernel_size,kernel_size]);
        end
        dLdw(:,:,:,i) = dldw;
        dLdb(i) = sum(sum(dLdy(:,:,i)));
    end
end