function [mini_batch_x, mini_batch_y] = GetMiniBatch(im_train, label_train, batch_size)

rand_index=randperm(size(label_train,2));

random_im_train=im_train(:,rand_index);
random_label_train=label_train(:,rand_index);

one_hot_label=zeros(10,size(label_train,2));
for i=1:size(label_train,2)
    one_hot_label(random_label_train(1,i)+1,i)=1;
end

n_batch=floor(size(label_train,2)/batch_size);
mini_batch_x={};
mini_batch_y={};


for i=1: n_batch
    mini_batch_x{i}=random_im_train(:,(i-1)*batch_size +1 : i*batch_size);
    mini_batch_y{i}=one_hot_label(:,(i-1)*batch_size +1 : i*batch_size);
end

mini_batch_x{i}=random_im_train(:,(n_batch-1)*batch_size+1: end);
mini_batch_y{i}=one_hot_label(:,(n_batch-1)*batch_size+1: end);

end