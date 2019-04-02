function [feature] = GetTinyImage(I, output_size) 

feature=double(imresize(I,output_size));
feature=reshape(feature,[],1);
feature=feature-mean(feature);
feature=feature/norm(feature);
%     figure;
%     imagesc(feature);
%     figure;
%     imshow(reshape(feature,[],16));

end