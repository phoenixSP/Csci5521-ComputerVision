function [w, b] = TrainSLP(mini_batch_x, mini_batch_y)

%parameters
gamma=1;
decay_rate=0.8;
nIters=10000;

%initializations
m=size(mini_batch_x{1},1);
n=size(mini_batch_y{1},1);
k=1;
minibatch_size=size(mini_batch_x{1},2);
n_minibatch=size(mini_batch_x,2);
iter_loss=[];

w=rand(n,m);
b=rand(n,1);

for iter=1:nIters
   if mod(iter,1000)==0
       gamma=decay_rate*gamma;
   end
   dLdw=zeros(n,m);
   dLdb=zeros(1,n);  
   minibatch_loss=[];

   
   for i=1:minibatch_size
       x=mini_batch_x{k}(:,i);
       
       y = FC(x, w, b);       
       [l, dldy] = Loss_cross_entropy_softmax(y, mini_batch_y{k}(:,i));
       minibatch_loss=[minibatch_loss, l];
       
       [dldx, dldw, dldb] = FC_backward(dldy, x, w, b, y);
       
       dLdw=dLdw+dldw;
       dLdb=dLdb+dldb;
       
   end
   
   iter_loss=[iter_loss, mean(minibatch_loss)];
   if k>=n_minibatch
       k=1;
   else
       k=k+1;
   end
   
   R=minibatch_size;
   w=w-(gamma/R)*dLdw;
   b=b-(gamma/R)*dLdb';
   
end
fig_handle = figure(1);
clf;
plot(iter_loss,'Linewidth',1);
xlabel("Number of iteration");
ylabel("Loss");
end
