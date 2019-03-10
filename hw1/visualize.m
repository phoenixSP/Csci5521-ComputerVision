im=imread("Einstein.jpg");
im=rgb2gray(im);
imshow(im);

[filter_x, filter_y]=GetDifferentialFilter();
im_filtered_x = FilterImage(im, filter_x);
im_filtered_y = FilterImage(im, filter_y);

[grad_mag, grad_angle] = GetGradient(im_filtered_x, im_filtered_y);
ori_histo = BuildHistogram(grad_mag, grad_angle, 8);
ori_histo_normalized = GetBlockDescriptor(ori_histo, 2);

%[m,n,p]=size(ori_histo_normalized);
 [m,n,p]=size(ori_histo);

x_dir=5:8:8*n;
y_dir=5:8:8*m;

[X,Y]=meshgrid(x_dir,y_dir);
U=ones(m,n);
V=ones(m,n);

figure;
imshow(im);
hold on;
for d=0:5
    theta=d*pi/6;

    %visualization of ori_histo
    U=ori_histo(:,:,d+1).*cos(theta-pi/2);
    V=ori_histo(:,:,d+1).*sin(theta-pi/2);

    %visualization of normalized histogram
%     mag=ori_histo_normalized(:,:,d+1)+ori_histo_normalized(:,:,d+7)+ori_histo_normalized(:,:,d+13)+ori_histo_normalized(:,:,d+19);
%     U=mag.*cos(theta-pi/2);
%     V=mag*sin(theta-pi/2);
    
    q=quiver(X,Y,U,V);
    q.Color="red";
    q.AutoScaleFactor=0.5;
    q.LineWidth=1;
    
    hold on;
   
end
