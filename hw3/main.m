run('C:/Users/shrey/Downloads/vlfeat-0.9.21-bin.tar/vlfeat-0.9.21/toolbox/vl_setup')
close all;
clear all;
clc;


%%
[confusion, accuracy] = ClassifyKNN_Tiny;

%%

file=fopen(".\scene_classification_data\train.txt");
end_of_file = fgetl(file);
% train_class=[];
training_image_cell={};
index=1;
while ischar(end_of_file)
    cell = strsplit(end_of_file);
    filename=".\scene_classification_data\"+cell{2};
    I=imread(filename);
    
    training_image_cell{index}=I;
    index=index+1;
    end_of_file = fgetl(file);
end

fclose(file);
%%
dic_size=50;
[vocab] = BuildVisualDictionary(training_image_cell, dic_size);
% pool=[];
% [~,n_train]=size(training_image_cell);
% for i=1:n_train
%     im=im2single(training_image_cell{i});
%     [~, features] = vl_dsift(im, 'Fast', 'Step', 20, 'size', 20);
%     pool=[pool,features];
% end
% 
% rng(1); % For reproducibility
% pool=double(pool);
% [~,vocab] = kmeans(pool',dic_size, 'MaxIter',1000);
% vocab=vocab';

%%
im=im2single(training_image_cell{1});
[~, feature] = vl_dsift(im, 'Fast', 'Step', 20, 'size', 20);
feature=feature';
vocab=vocab';
%%
[bow_feature] = ComputeBoW(feature, vocab);
% k=10;
% label_train=[1:dic_size];
% model = fitcknn(vocab,label_train,'NumNeighbors',k,'Distance', 'correlation');
% 
% pre_histogram = predict(model,feature);
% histo=histcounts(pre_histogram,dic_size);
% histo=histo/norm(histo);
%%
