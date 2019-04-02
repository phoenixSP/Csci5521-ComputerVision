function [label_test_pred] = PredictSVM(feature_train, label_train, feature_test) 


lambda = 0.00005; % Regularization parameter
% maxIter = 1000 ; % Maximum number of iterations

w={};
b={};
for i=1:15
    new_label=-1*ones(size(label_train,1),1);
    new_label(label_train==i)=1;
    [w{i}, b{i} ,~] = vl_svmtrain(feature_train', new_label, lambda);
end

scores=zeros(size(label_train,1),15);

for i=1:15
    [~,~,~, scores(:,i)] = vl_svmtrain(feature_test', new_label, 0, 'model', w{i}, 'bias', b{i}, 'solver', 'none') ;
end

[~,label_test_pred]=max(scores');
label_test_pred=label_test_pred';

%%using MATLAB's svm 
% rng(1);
% scores=zeros(size(label_train,1),15);
% for i=1:15
%     new_label=-1*ones(size(label_train,1),1);
%     new_label(label_train==i)=1;
%     model=fitcsvm(feature_train, new_label, 'KernelScale','auto');
%     [~,b] = predict(model,feature_test);
%     scores(:,i)=b(:,2);
% end
% [~,label_test_pred]=max(scores');
% label_test_pred=label_test_pred';
end