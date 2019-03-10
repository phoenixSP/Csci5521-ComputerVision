function [filter_x, filter_y] = GetDifferentialFilter() 

    filter_y=[-1 -1 -1; 0 0 0; 1 1 1];
    filter_x=[-1 0 1; -1 0 1; -1 0 1];

end