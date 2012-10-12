Nms = input("Enter the frame size in milliseconds: ");
FileName = input("Enter the sound file name (Enclose in single quotes): ");

[y, Fs, bits] = wavread(FileName);
N = Nms * Fs / 1000;		// Number of frames for size
y = y(1,:);

clf();
t = 0:(1/Fs):((-1+length(y))/Fs);

i = (1/4) * length(y);
temp = y(i:(i+N-1));
t = linspace(0,Nms, N);

subplot(3,2,1);
plot(t,temp);
xlabel('Time');
ylabel('Input');
title('Rectangular Window Signal');
rectstft = 10*log(abs(%eps+fftshift(fftw(temp))'));

subplot(3,2,3);
temp2 = temp.*window('hn',N);
plot(t,temp2);
xlabel('Time');
ylabel('Input');
title('Hann Window Signal');
hannstft = 10*log(abs(%eps+fftshift(fftw(temp2))'));

subplot(3,2,5);
temp2 = temp.*window('hm',N);
plot(t,temp2);
xlabel('Time');
ylabel('Input');
title('Hamming Window Signal');
hammingstft = 10*log(abs(%eps+fftshift(fftw(temp2))'));
f = (0:(N-1)) - N/2;
f = Fs * f / N;

subplot(3,2,2);
plot(f, rectstft);
a = get("current_axes");
a.data_bounds = [0,min(rectstft);24000, max(rectstft)];
xlabel('Frequency');
ylabel('STFT');
title('Rectangular Window');

subplot(3,2,4);
plot(f, hannstft);
a = get("current_axes");
a.data_bounds = [0,min(hannstft);24000, max(hannstft)];
xlabel('Frequency');
ylabel('STFT');
title('Hann Window');

subplot(3,2,6);
plot(f, hammingstft);
a = get("current_axes");
a.data_bounds = [0,min(hammingstft);24000, max(hammingstft)];
xlabel('Frequency');
ylabel('STFT');
title('Hamming Window');
