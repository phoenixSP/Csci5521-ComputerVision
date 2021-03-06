function [vocab] = BuildVisualDictionary(training_image_cell, dic_size) 
pool=[];
[~,n_train]=size(training_image_cell);
for i=1:n_train
    im=im2single(training_image_cell{i});
%     [~, features] = vl_dsift(im, 'Step', 20, 'size', 10);
    [~, features] = vl_dsift(im,'fast', 'Step', 5);
    pool=[pool,features];
end

rng(1); % For reproducibility
pool=double(pool);
[~,vocab] = kmeans(pool',dic_size, 'MaxIter',1000 );

end