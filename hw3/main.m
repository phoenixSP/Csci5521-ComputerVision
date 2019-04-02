run('C:/Users/shrey/Downloads/vlfeat-0.9.21-bin.tar/vlfeat-0.9.21/toolbox/vl_setup')
close all;
clear all;
clc;


%%
[confusion, accuracy] = ClassifyKNN_Tiny;
imagesc(confusion);
%23.8667


%%
[confusion, accuracy] = ClassifyKNN_BoW;
imagesc(confusion);


%%
[confusion, accuracy] = ClassifySVM_BoW ;
imagesc(confusion);

