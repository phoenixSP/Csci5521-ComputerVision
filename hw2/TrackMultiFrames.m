function [A_cell] = TrackMultiFrames(template, image_cell)

[~,n_image]=size(image_cell);
% disp("Finding match");
[x1, x2] = FindMatch(template, image_cell{1});

% % visualizing matched points
% figure; ax = axes;
% showMatchedFeatures(template,image_cell{1},x1,x2,'montage','Parent',ax)

% disp("Finding A");
ransac_thr=2;
ransac_iter=500;
A = AlignImageUsingFeature(x1, x2, ransac_thr, ransac_iter);

output_size=size(template);
A_cell=cell(n_image);

for i=1:n_image
%     disp("Finding A refined for");
%     i
    A = AlignImage(template, image_cell{i}, A);
    A_cell{i}=A;
    template = WarpImage(image_cell{i}, A, output_size);
end

end