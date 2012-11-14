// This script calculates the value of the LPC coefficients using the Levinson-
// Durbin (LD) method. The LD method calculates the nth order coefficients using
// the (n-1)th order coefficients. 

// Nms = input("Enter the frame size in milliseconds: ");
Nms = 20;       // 20ms frame length
FileName = input("Enter the sound file name (Enclose in single quotes): ");

[y, Fs, bits] = wavread(FileName);
N = Nms * Fs / 1000;		// Number of frames for size
y = y(1,:);

// Order of LP Analysis
p = input('Enter the maximum order of the LP Analysis: ');

// Take a single frame
frame = y(length(y)/2:(length(y)/2)+N-1);

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
a = a_last;
E(1+1) = E(0+1) * (1 - lambda^2);

err = zeros(p,length(frame));

i = 1;
for k = i+1:length(frame)
	err(i, k) = frame(k) - sum(a .* frame(k-1:-1:k-i));
end

for i = 2:p
	lambda = (R(i+1)-sum(a_last .* R(i-1+1:-1:1+1)) ) / E(i+1-1);
	a = [(a_last - lambda * a_last(i-1:-1:1)) lambda];
	E(i+1) = E(i-1+1) * (1 - lambda^2);
	a_last = a;

	// Caclulate LP Residual
	// Residual signal is given by: e(n) = s(n) - sum(a(k)s(n-k)) = G u(n)
	for k = i+1:length(frame)
		err(i, k) = frame(k) - sum(a .* frame(k-1:-1:k-i));
	end
end

plot(sum(err.^2,'c')/sum(frame.^2),'-o.');
title('Normailzed Mean Square Error with Order of LP Analysis');
xlabel('Order of LP Analysis');
