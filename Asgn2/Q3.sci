Nms = input("Enter the frame size in milliseconds: ");

clf();

[y, Fs, bits] = wavread('Voiced.wav');
N = Nms * Fs / 1000;		// Number of frames for size
y = y(1,1:N);

subplot(3,2,1);
t = 0:(1/Fs):((-1+length(y))/Fs);
plot2d(t,y);
xlabel('Time');
ylabel('Input');
title('Voiced Input Signal');

auto = zeros(length(y), 1);

for l = 0:length(y)-1
	s = 0;
	for u = 1:length(y) - l
		s = s + y(u) * y(u+l);
	end
	auto(l+1) = s;
end

subplot(3,2,2);
t2 = 0:1/Fs:(length(y)-1)/Fs;
plot2d(t2,auto);
xlabel('Time');
ylabel('Auto Correlation');
title('Short Term Auto Correlation - Voiced');

[y, Fs, bits] = wavread('Unvoiced.wav');
N = Nms * Fs / 1000;		// Number of frames for size
y = y(1,1:N);

subplot(3,2,3);
t = 0:(1/Fs):((-1+length(y))/Fs);
plot2d(t,y);
xlabel('Time');
ylabel('Input');
title('Unvoiced Input Signal');

auto = zeros(length(y), 1);

for l = 0:length(y)-1
	s = 0;
	for u = 1:length(y) - l
		s = s + y(u) * y(u+l);
	end
	auto(l+1) = s;
end

subplot(3,2,4);
t2 = 0:1/Fs:(length(y)-1)/Fs;
plot2d(t2,auto);
xlabel('Time');
ylabel('Auto Correlation');
title('Short Term Auto Correlation - Unvoiced');

[y, Fs, bits] = wavread('Silence.wav');
N = Nms * Fs / 1000;		// Number of frames for size
y = y(1,1:N);

subplot(3,2,5);
t = 0:(1/Fs):((-1+length(y))/Fs);
plot2d(t,y);
xlabel('Time');
ylabel('Input');
title('Silence Input Signal');

auto = zeros(length(y), 1);

for l = 0:length(y)-1
	s = 0;
	for u = 1:length(y) - l
		s = s + y(u) * y(u+l);
	end
	auto(l+1) = s;
end

subplot(3,2,6);
t2 = 0:1/Fs:(length(y)-1)/Fs;
plot2d(t2,auto);
xlabel('Time');
ylabel('Auto Correlation');
title('Short Term Auto Correlation - Silence');
