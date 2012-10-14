function [result] = median_filter(in_val, n)
    len = length(in_val);
    local_in = zeros(len+n, 1);
    local_in(1:len) = in_val(1:len)';

    result = zeros(len, 1);
    
    for i=1:len
        ltemp = local_in(i:(i+n));
        result(i) = median(ltemp)
    end
endfunction