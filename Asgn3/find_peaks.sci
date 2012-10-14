function [peaks] = find_peaks(in_vect,n)
t1 = real(in_vect);
t2 = diff(t1);
t2 = t2 / max(real(t2));
t3 = diff(t2);
t3 = t3/max(real(t3));
x = zeros(1, length(t1));

peaks = zeros(n,1);
index = 1;
for i=2:length(t2)-1
    if index > n then
        break;
    end
    
    if abs(t2(i)) < thres then
        // Check if it is a max or min and if this is indeed the peak
        if abs(t2(i+1)) < abs(t2(i)) | abs(t2(i-1)) < abs(t2(i)) then
            continue;
        elseif real(t3(i)) < 0 then
            peaks(index) = i;
            index = index + 1;
        end
    end
end
peaks = peaks+1;
endfunction