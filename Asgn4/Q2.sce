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
p = input('Enter the order of the LP Analysis: ');

scf();

// Take a single frame
frame = y(length(y)/2:(length(y)/2)+N-1);

// Apply Hamming Window
frame = frame .* window('hm', N);

R = zeros(1,p+1);
for i = 0:(p)
    R(i+1) = sum(frame(1,1:(N-p)).*frame(1,(1+i):(N-p+i)));
end

clf();
subplot(3,1,1);
x = (0:length(frame)-1) / Fs;
plot(x, frame);
title('Windowed Input Signal');
xlabel('Time in seconds');
a = get("current_axes");
a.tight_limits = "on";

subplot(3,1,2);
x = (0:length(R)-1)/Fs;
plot(x, R);
title('Autocorrelation Function');
xlabel('Time in seconds');
a = get("current_axes");
a.tight_limits = "on";

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

subplot(3,1,3);
plot(a,'-o.');
title('LP Coefficients');
