function [I_warped] = WarpImage(I, A, output_size)

I_warped=zeros(output_size, class(I));
for i=1:output_size(1)
    for j=1:output_size(2)
        loc2 = [j, i];
        loc1=floor(A*[j i 1]');
        
%         if loc1(2)<1 || loc1(2)> output_size(1)  || loc1(1)<1 || loc1(1)> output_size(2)
%               continue;
%         end
        I_warped(loc2(2),loc2(1))=I(loc1(2),loc1(1));
    end
end

end