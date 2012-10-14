function [freq_mel] = hz2mel(freq_hz)
    freq_mel = 2595*log10(1+freq_hz/700);
endfunction