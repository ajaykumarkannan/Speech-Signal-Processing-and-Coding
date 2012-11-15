// Calculation of the LP Coefficients using the autocorrelation method

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

// Calculation of the Autocorrelation Function
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

// Autocorrelation Matrix - Row * Column notation
acmatrix = zeros(p,p);
rvector = zeros(p,1);
for i = 0:(p-1)
    index = i + 2;
    rvector(i+1) = R(index);
    for j = 0:(p-1)
        index = abs(i - j);
        acmatrix(i+1,j+1) = R(index+1);
    end
end

alpha = inv(acmatrix) * rvector;

subplot(3,1,3);
plot(alpha,'-o.');
title('LP Coefficients');
// a = get("current_axes");
// a.tight_limits = "on";

minmeansqrerror = R(1) - alpha'*rvector;
printf('The minimum mean square error is %f\n', minmeansqrerror);
