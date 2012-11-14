// This script calculates the value of the LPC coefficients using the Levinson-
// Durbin (LD) method. The LD method calculates the nth order coefficients using
// the (n-1)th order coefficients. The calculation is done frame-wise 

// Nms = input("Enter the frame size in milliseconds: ");
// Nfs = input("Enter frame shift in milliseconds: ");
Nms = 20;		// 20ms frame length
Nfs = 20;		// 20ms frame shift
FileName = input("Enter the sound file name (Enclose in single quotes): ");

[y, Fs, bits] = wavread(FileName);
y = y(1,:);

N = Nms * Fs / 1000;		// Number of samples for frame size
Nf = Nfs * Fs / 1000;		// Number of samples for frame shift

// Order of LP Analysis
p = input('Enter the order of the LP Analysis: ');

Nframes = floor((length(y) - N)/ Nf);			// Number of frames total
LPC_Coefs = zeros(Nframes, p);
for f = 1:Nframes
	start = f * Nf;
	findex = start:(start+N-1);

	// Take the samples within the frame
	frame = y(findex);

	// Apply Hamming Window
	frame = frame .* window('hm', N);

	R = zeros(1,p+1);
	for i = 0:(p)
		R(i+1) = sum(frame(1,1:(N-p)).*frame(1,(1+i):(N-p+i)));
	end

	// Reflection coefficients
	k = zeros(p,1);

	// Prediction Error - E(1) = Prediction error of 0
	E = zeros(p+1,1);

	// Solving size 0 & 1 problem
	// R(1) + R(0) * a1_1 = 0
	E(0+1) = R(0+1);
	lambda = R(1+1) / E(0+1);
	a_last = lambda;
	E(1+1) = E(0+1) * (1 - lambda^2);
	for i = 2:p
		lambda = (R(i+1)-sum(a_last .* R(i-1+1:-1:1+1)) ) / E(i+1-1);
		a = [(a_last - lambda * a_last(i-1:-1:1)) lambda];
		E(i+1) = E(i-1+1) * (1 - lambda^2);
		a_last = a;
	end
	LPC_Coefs(f, :) = a;
end

surf(1:p, (0:Nframes-1) * Nf / Fs, LPC_Coefs);
title('LPC Coefficients vs Time');
xlabel('LPC Coefficient');
ylabel('Time in seconds');
a = get("current_axes");
a.tight_limits = "on";
