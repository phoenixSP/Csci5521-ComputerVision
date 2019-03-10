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