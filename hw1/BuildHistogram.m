 
function ori_histo = BuildHistogram(grad_mag, grad_angle, cell_size) 
    [m,n]=size(grad_mag);
    M=floor(m/cell_size);
    N=floor(n/cell_size);
    ori_histo=zeros(M,N,6);
    for i=1:M
        for j=1:N
            for k=1:cell_size
                for l=1:cell_size
                    bin_number = GetBinNumber(grad_angle((8*(i-1))+k,(8*(j-1))+l));
                    ori_histo(i,j,bin_number)=ori_histo(i,j,bin_number)+grad_mag((8*(i-1))+k,(8*(j-1))+l);
                end
            end

        end
    end

end

function bin_number = GetBinNumber(grad_angle)
    theta=pi/12;
    
    if(grad_angle>=theta && grad_angle<3*theta)
        bin_number=2;
    elseif(grad_angle>=3*theta && grad_angle<5*theta)
        bin_number=3;
    elseif(grad_angle>=5*theta && grad_angle<7*theta)
        bin_number=4;
    elseif(grad_angle>=7*theta && grad_angle<9*theta)
        bin_number=5;
    elseif(grad_angle>=9*theta && grad_angle<11*theta)
        bin_number=6;
    elseif(grad_angle>=11*theta && grad_angle< pi ) || (grad_angle>=0 && grad_angle<theta)
        bin_number=1;
        
    end
        
end


   
