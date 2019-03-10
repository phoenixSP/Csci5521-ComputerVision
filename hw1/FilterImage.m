function [im_filtered] = FilterImage(im, filter) 
  
  %padding image
  im1=padarray(im, [1,1]);  
  [m,n]=size(im1);
  im_filtered=zeros(size(im1));
  for i=2:m-1     
      for j=2:n-1
          im_filtered(i,j)=sum(sum(filter.*im1(i-1:i+1,j-1:j+1)));
          
      end
          
          
      
  end

end