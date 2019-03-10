function ori_histo_normalized = GetBlockDescriptor(ori_histo, block_size) 
    e=0.001;
    [M,N,P]=size(ori_histo);
    ori_histo_normalized=zeros(M-(block_size -1), N-(block_size -1), P*(block_size)^2);
    
    for i=1: M-(block_size -1)
        for j=1: N-(block_size -1)
            temp=ori_histo(i:i+block_size-1,j:j+block_size-1,:);
            temp=permute(temp,[3 2 1]);
            temp=temp(:);
            denom=sqrt(sum(temp)+e^2);
            ori_histo_normalized(i,j,:)=temp./denom;           
        end
    end
    
    
end

   
