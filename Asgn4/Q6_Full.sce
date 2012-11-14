// This script perfoms PITCH DETECTION using the SIFT method. The basic components
// of the algorithm are as follows:
// LPF (900Hz) -> DECIMATION (2kHz) -> Analyzed using Autocorrelation (p=4) -> Inverse Filter

// Nms = input("Enter the frame size in milliseconds: ");
// Nfs = input("Enter frame shift in milliseconds: ");
Nms = 40;		// 20ms frame length
Nfs = 40;		// 20ms frame shift
FileName = input("Enter the sound file name (Enclose in single quotes): ");

[y, Fs, bits] = wavread(FileName);
y = y(1,:);

Nsamples = Nms * Fs / 1000;		// Number of samples for frame size
Nf = Nfs * Fs / 1000;		// Number of samples for frame shift

Nframes = floor((length(y) - Nsamples)/ Nf);			// Number of frames total
formant = zeros(1,Nframes);						// Contains the formants

fil = ffilt('lp',100,900);

for f = 1:Nframes
	start = f * Nf;
	findex = start:(start+Nsamples-1);

	// Take the samples within the frame
	frame = y(findex);

	// Apply Hamming Window
	// frame = frame .* window('hm', N);

	// FIR LPF ------------------------------------
	flpf = conv(frame, fil,'same');
	flpf = flpf / max(abs(flpf));

	// Decimation ------------------------------------------
	dec_factor = floor(Fs / 2000);
	framedec = flpf(1:dec_factor:length(flpf));
//	clf();
//	plot(framedec);
//	sleep(1000);
	// Fourth order LPC Analysis using LD method
	p = 4;
	R = zeros(1,p+1);
	N = length(framedec);
	for i = 0:(p)
		R(i+1) = sum(framedec(1,1:(N-p)).*framedec(1,(1+i):(N-p+i)));
	end

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

	// Caclulate LP Residual
	// Residual signal is given by: e(n) = s(n) - sum(a(k)s(n-k)) = G u(n)
	err = zeros(1,length(framedec));
	err(1:p) = framedec(1:p);
	for i = p+1:length(framedec)
		err(i) = framedec(i) - sum(a .* framedec(i-1:-1:i-p));
	end

	// Autocorrelation of residual
	p = 40;
	R = zeros(1,p+1);
	N = length(err);
	for i = 0:(p)
		R(i+1) = sum(err(1,1:(N-p)).*err(1,(1+i):(N-p+i)));
	end

	x = (0:length(R)-1) / 2000;
	hfindex = length(x(x <= 0.002));
	[a b] = max(R(x > 0.002 & x < 0.012));
	formant(f) = 1/x(b+hfindex);	
end

plot(formant);
