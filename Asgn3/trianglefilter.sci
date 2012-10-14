function [filval] = trianglefilter(start, mid, last, len)
    // Start, mid and last are indexes
    filval = zeros(1,len);
    filval(mid) = 1;
    filval(start:mid) = linspace(0,1, 1+mid-start);
    filval(mid:last)  = linspace(1,0, 1+last-mid);    
    filval = filval / sum(filval);
endfunction