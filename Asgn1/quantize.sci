// This functions accepts only normalized indatas from -1:1
function quantdata = quantize(indata, numBits)
quantdata = zeros(size(indata));
step = 2 / (2^numBits);
for i = 1:length(indata)
	if numBits > 1
		for j=-1:step:1
			if indata(i) >= j
				if indata(i) < j + step
					quantdata(i) = j;
					continue;
				end
			end
		end
	else	
		if indata(i) > 0
			quantdata(i) = 1;
		else
			quantdata(i) = 0;
		end
	end
end
endfunction
