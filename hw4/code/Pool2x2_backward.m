function [dLdx] = Pool2x2_backward(dLdy, x, y) 

    dLdx = zeros(size(x));
    
    for i=1:size(x,3)
        x_temp = im2col(x(:,:,i),[2,2],'distinct');
        y_temp = y(:,:,i);
        y_temp = reshape(y_temp,[],1);
        dldy = dLdy(:,:,i);
        dldy_temp = dldy(:);
        dldx = zeros(size(x_temp));

        for j=1:size(x_temp,2)
            temp = find(x_temp(:,j)==y_temp(j));
            dldx(temp,j) = dldy_temp(j);
        end

        dldx = col2im(dldx,[2,2],size(x),'distinct');
        dLdx(:,:,i) = dldx;

    end
end