function [w1, b1, w2, b2] = TrainMLP(mini_batch_x, mini_batch_y) 

%parameters
gamma=0.03;
decay_rate=0.95;
nIters=10000;
hidden_layer_size=30;

%initialization
m=size(mini_batch_x{1},1);
n=size(mini_batch_y{1},1);
k=1;
minibatch_size=size(mini_batch_x{1},2);
n_minibatch=size(mini_batch_x,2);
iter_loss=[];

w1=rand(hidden_layer_size, m);
b1=rand(hidden_layer_size, 1);

w2=rand(n,hidden_layer_size);
b2=rand(n,1);

for iter=1:nIters
   if mod(iter,1000)==0
       gamma=decay_rate*gamma;
   end
   dLdw1=zeros(hidden_layer_size,m);
   dLdb1=zeros(1,hidden_layer_size);
   dLdw2=zeros(n,hidden_layer_size);
   dLdb2=zeros(1,n);
   minibatch_loss=[];

   for i=1:minibatch_size
       x=mini_batch_x{k}(:,i);
       x_hidden = FC(x, w1, b1);
       x_fc = ReLu(x_hidden);
       y = FC(x_fc, w2, b2);
       
       [l, dldy] = Loss_cross_entropy_softmax(y,mini_batch_y{k}(:,i));
       minibatch_loss=[minibatch_loss, l];

       
       [dl_fc_dx, dl_fc_dw, dl_fc_db] = FC_backward(dldy, x_fc, w2, b2, y);
       dl_relu_dx = ReLu_backward(dl_fc_dx, x_hidden, x_fc);
       [dl_fc1_dx, dl_fc1_dw, dl_fc1_db] = FC_backward(dl_relu_dx, x, w1, b1, x_hidden);
       

       dLdw1=dLdw1+dl_fc1_dw;
       dLdb1=dLdb1+dl_fc1_db;
       dLdw2=dLdw2+dl_fc_dw;
       dLdb2=dLdb2+dl_fc_db;
       
   end
   iter_loss=[iter_loss, mean(minibatch_loss)];

   if k>=n_minibatch
       k=1;
   else
       k=k+1;
   end
   
   R=minibatch_size;
   
   w1=w1-(gamma/R)*dLdw1;
   b1=b1-(gamma/R)*dLdb1';
   w2=w2-(gamma/R)*dLdw2;
   b2=b2-(gamma/R)*dLdb2';
   
end
fig_handle = figure(1);
clf;
plot(iter_loss,'Linewidth',1);
xlabel("Number of iteration");
ylabel("Loss");
end