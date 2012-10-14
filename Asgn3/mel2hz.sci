function [freq_hz] = mel2hz(freq_mel)
    freq_hz = 700 * (-1 + 10^(freq_mel/2595))
endfunction