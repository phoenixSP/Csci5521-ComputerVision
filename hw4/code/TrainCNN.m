function [w_conv, b_conv, w_fc, b_fc] = TrainCNN(mini_batch_x, mini_batch_y) 

%parameters
gamma=0.0675;
decay_rate=0.9;
nIters=10000;

%initialization
m=size(mini_batch_x{1},1);
n=size(mini_batch_y{1},1);
k=1;
minibatch_size=size(mini_batch_x{1},2);
n_minibatch=size(mini_batch_x,2);
iter_loss=[];


%TO-DO: change hardcoded parts
w_conv=rand(3,3,1,3);
b_conv=rand(3, 1);

w_fc=rand(10,147);
b_fc=rand(10,1);

for iter=1:nIters
   if mod(iter,1000)==0
       gamma=decay_rate*gamma;
   end
   
   dLdw_fc=zeros(size(w_fc));
   dLdb_fc= zeros(size(b_fc));
   dLdw_conv=zeros(size(w_conv));
   dLdb_conv=zeros(size(b_conv));
   minibatch_loss=[];
   for i=1:minibatch_size
       x=mini_batch_x{k}(:,i);
       x = reshape(x, [14, 14, 1]);

       pred1=Conv(x,w_conv,b_conv);
       pred2=ReLu(pred1);
       pred3=Pool2x2(pred2);
       
       pred4=Flattening(pred3);
       y=FC(pred4,w_fc,b_fc);
       [l, dldy] =Loss_cross_entropy_softmax(y,mini_batch_y{k}(:,i));
       minibatch_loss=[minibatch_loss, l];
       
       [dl_fc_dx, dl_fc_dw, dl_fc_db] = FC_backward(dldy, pred4, w_fc, b_fc, y);
       [dl_flat_dx]=Flattening_backward(dl_fc_dx,pred3,pred4);
       [dl_pool_dx]=Pool2x2_backward(dl_flat_dx,pred2,pred3);
       dl_relu_dx = ReLu_backward(dl_pool_dx, pred1, pred2);
       [dldw,dldb]=Conv_backward(dl_relu_dx,x,w_conv,b_conv,pred1);
       
       dLdw_fc=dLdw_fc+dl_fc_dw;
       dLdb_fc=dLdb_fc+dl_fc_db;
       dLdw_conv=dLdw_conv+dldw;
       dLdb_conv=dLdb_conv+dldb;
       
   end
   iter_loss=[iter_loss, mean(minibatch_loss)];
   if k>=n_minibatch
       k=1;
   else
       k=k+1;
   end
   
   R=minibatch_size;
   
   w_conv=w_conv-(gamma/R)*dLdw_conv;
   b_conv=b_conv-(gamma/R)*dLdb_conv';
   w_fc=w_fc-(gamma/R)*dLdw_fc;
   b_fc=b_fc-(gamma/R)*dLdb_fc';
   
end

fig_handle = figure(1);
clf;
plot(iter_loss,'Linewidth',1);
xlabel("Number of iteration");
ylabel("Loss");
end