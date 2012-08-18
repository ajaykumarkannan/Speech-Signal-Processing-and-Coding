scf();

// Non-Stationary Signal
[y, Fs, bits] = wavread('Sound1.wav');
y = y(1,:);				// Had recorded in stereo - Converting to mono
// Taking a portion of the input signal
y = y(1,182680:200000);
y = y./(abs(max(y)));		// Normalizing the signal
// Taking 30ms worth of signal
noSamples = Fs * 30 /1000;
y1 = y(1:noSamples);
Yt = 20*log10(abs(fftshift(fft(y1))));
Yt = Yt / abs(max(Yt));		// Normalizing
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / N;
subplot(3,2,3); plot2d(y1); title('Non-Stationary Signal - Time Domain Plot');
subplot(3,2,4); plot2d(F(N/2:N-1), Yt(N/2:N-1)); title('Non-Stationary Signal - Frequency Domain Plot');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];
y1 = y(noSamples+1:2*noSamples);
Yt = 20*log10(abs(fftshift(fft(y1))));
Yt = Yt / abs(max(Yt));		// Normalizing
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / N;
subplot(3,2,5); plot2d(y1); title('Non-Stationary Signal - Time Domain Plot - Shifted');
subplot(3,2,6); plot2d(F(N/2:N-1), Yt(N/2:N-1)); title('Non-Stationary Signal - Frequency Domain Plot - Shifted');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];

// Stationary Signal
// Sum of two sine waves i.e. x = a*sin(b*t)+c*sin(d*t)
t = 0:0.1:noSamples;
a = 5;
b = 0.7;
c = 2;
d = 0.2;
x = a*sin(b*t)+c*sin(d*t);
Xt = 20*log10(abs(fftshift(fft(x))));
Xt = Xt/abs(max(Xt));		// Normalizing
N = length(Xt);
F = -(N/2):(-1 + N/2);
F = Fs * F / N;
subplot(3,2,1); plot2d(x); title('Stationary Signal - Time Domain Plot');
subplot(3,2,2); plot2d(F(N/2:(N-1)), Xt(N/2:(N-1))); title('Stationary Signal - Frequency Domain Plot');
a = get("current_axes");
a.data_bounds = [0,min(Xt);24000, max(Xt)];
