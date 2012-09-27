Nms = input("Enter the frame size in milliseconds: ");
Sfms = input("Enter the frame shift in milliseconds: ");
FileName = input("Enter the sound file name (Enclose in single quotes): ");

[y, Fs, bits] = wavread(FileName);
N = Nms * Fs / 1000;		// Number of frames for size
Sf = Sfms * Fs / 1000;		// Number of frames for shift
y = y(1,:);

t = 0:(1/Fs):((-1+length(y))/Fs);
clf();
subplot(2,1,1);
plot2d(t, y);
title('Input Signal');
xlabel('Time');
ylabel('Input');

E = zeros(length(y) / Sf, 1);

index = 0;
for i = 1:Sf:(length(y)-N)
	index = index + 1; 
	for j = 0:(N-1)
		E(index) = E(index) + y(i+j)*y(i+j);
	end
end

t2 = 0:Sf/Fs:Sf*(length(E)-1)/Fs;
subplot(2,1,2);
plot2d(t2,E);
title('Short Term Energy');
xlabel('Time');
ylabel('Short Term Energy');
