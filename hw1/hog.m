function hog=hog(im)

im=rgb2gray(im);
im=im2double(im);

[filter_x, filter_y]=GetDifferentialFilter();
im_filtered_x = FilterImage(im, filter_x);
im_filtered_y = FilterImage(im, filter_y);

[grad_mag, grad_angle] = GetGradient(im_filtered_x, im_filtered_y);
ori_histo = BuildHistogram(grad_mag, grad_angle, 8);
ori_histo_normalized = GetBlockDescriptor(ori_histo, 2);

temp=permute(ori_histo_normalized, [3 2 1]);
hog=reshape(temp,[],1);
%hog=ori_histo_normalized;

end

    



