// Nms = input("Enter the frame size in milliseconds: ");
Nms = 20;       // 20ms frame length
FileName = input("Enter the sound file name (Enclose in single quotes): ");

[y, Fs, bits] = wavread(FileName);
N = Nms * Fs / 1000;		// Number of frames for size
y = y(1,:);

// Order of LP Analysis
// p = input('Enter the order of the LP Analysis: ');
for p = 1:100
    // Take a single frame
    frame = y(length(y)/2:(length(y)/2)+N-1);

    // Apply Hamming Window
    frame = frame .* window('hm', N);

    R = zeros(1,p+1);
    for i = 0:(p)
        R(i+1) = sum(y(1,1:(N-p)).*y(1,(1+i):(N-p+i)));
    end

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

    minmeansqrerror = R(1) - alpha'*rvector;
    a(p) = minmeansqrerror;
    //    printf('The minimum mean square error is %f\n', minmeansqrerror);
    printf('%f\n', minmeansqrerror);
end

plot(a);
title('Variation of minimum mean square error with order');
