run('C:/Users/shrey/Downloads/vlfeat-0.9.21-bin.tar/vlfeat-0.9.21/toolbox/vl_setup')
close all;
clear all;
clc;

%actual data
template=rgb2gray(imread("TEMPLATE_1.png"));
Frame1=rgb2gray(imread("IMAGE1.png"));
Frame2=rgb2gray(imread("IMAGE2.png"));
Frame3=rgb2gray(imread("IMAGE3.png"));
Frame4=rgb2gray(imread("IMAGE4.png"));

image_cell={Frame1,Frame2,Frame3,Frame4};
A_cell= TrackMultiFrames(template, image_cell);

[height,width]=size(template);
template_coordinates=[[1,1];[1,height];[width,height];[width,1]];
template_coordinates=[template_coordinates ones(size(template_coordinates(:,1)))];

for i=1:4
    transformed_coordinates=A_cell{i}*template_coordinates';
    figure;
    im=image_cell{i};
    imshow(im);
    hold on;

    plot([transformed_coordinates(1,:) transformed_coordinates(1,1)],[transformed_coordinates(2,:) transformed_coordinates(2,1)],'color','r','linewidth',2);
end


