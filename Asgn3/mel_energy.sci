function [Emel] = mel_energy(Y_in, fhz, FreqBands, pl)
    exec('hz2mel.sci');
    exec('mel2hz.sci');
    exec('trianglefilter.sci');
    n = length(FreqBands) - 2;

    fmel = linspace(FreqBands(1), FreqBands(length(FreqBands)),2000);
    Emel = zeros(n, 1);
    for i = 1:n
        [a start] = min(abs(fhz - mel2hz(FreqBands(i)) * ones(1, length(fhz)))); 
        [a mid] = min(abs(fhz - mel2hz(FreqBands(i+1)) * ones(1, length(fhz))));
        [a last] = min(abs(fhz - mel2hz(FreqBands(i+2)) * ones(1, length(fhz))));
        fil = trianglefilter(start, mid, last, length(Y_in));

        [a start] = min(abs(fmel - (FreqBands(i)) * ones(1, length(fmel)))); 
        [a mid] = min(abs(fmel - (FreqBands(i+1)) * ones(1, length(fmel))));
        [a last] = min(abs(fmel - (FreqBands(i+2)) * ones(1, length(fmel))));
        fil2 = trianglefilter(start, mid, last, length(fmel));
        if(pl == 1) then 
            subplot(2,1,1);
            plot(fhz, fil);
            xlabel('Frequency in Hz');
            title('Non-Uniform Filter Bank on Physical Frequency Scale');
            a = gca();
            a.tight_limits = "on";

            subplot(2,1,2);
            plot(fmel,fil2);
            xlabel('Mel Frequency');
            title('Uniform Filter Bank on Mel Frequency Scale');
            a = gca();
            a.tight_limits = "on";
        end
        Emel(i) = sum((Y_in.*fil').^2);
    end
endfunction