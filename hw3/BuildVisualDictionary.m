function [vocab] = BuildVisualDictionary(training_image_cell, dic_size) 
pool=[];
[~,n_train]=size(training_image_cell);
for i=1:n_train
    im=im2single(training_image_cell{i});
    [~, features] = vl_dsift(im, 'Fast', 'Step', 20, 'size', 20);
    pool=[pool,features];
end

rng(1); % For reproducibility
pool=double(pool);
[~,vocab] = kmeans(pool',dic_size, 'MaxIter',1000);
vocab=vocab';
end