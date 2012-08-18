// Non-Stationary Signal
[y, Fs, bits] = wavread('Sound1.wav');
// Taking a portion of the input signal - Sampled at 48kHz	
y = y(1,182680:200000);
y = y./(abs(max(y)));		// Normalizing the signal
// Taking 30ms worth of signal
noSamples = Fs * 30 /1000;
y1 = y(1:noSamples);

y2 = y1(1:2:length(y1));		// Downsampled to 24kHz - same 30ms of signal
y3 = y1(1:4:length(y1));		// Downsampled to 12kHz - same 30ms of signal
y4 = y1(1:8:length(y1));		// Downsampled to 6kHz - same 30ms of signal

Yt = 20*log10(%eps+abs(fftshift(fft(y1))));
nval = abs(max(Yt));
Yt = Yt / nval;
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / N;
scf();
subplot(4,2,1); plot2d(y1); title('Time Domain Plot - 48kHz Sampling Frequency');
subplot(4,2,2); plot2d(F(N/2:N-1), Yt(N/2:N-1)); 
title('Frequency Domain Plot - 48kHz Sampling Frequency');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];

Yt = 20*log10(%eps+abs(fftshift(fft(y2))));
Yt = Yt / nval;
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / (2*N);
subplot(4,2,3); plot2d(y2); title('Time Domain Plot - 24kHz Sampling Frequency');
subplot(4,2,4); plot2d(F(N/2:N-1), Yt(N/2:N-1)); 
title('Frequency Domain Plot - 24kHz Sampling Frequency');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];

Yt = 20*log10(%eps+abs(fftshift(fft(y3))));
Yt = Yt / nval;
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / (4*N);
subplot(4,2,5); plot2d(y3); title('Time Domain Plot - 12kHz Sampling Frequency');
subplot(4,2,6); plot2d(F(N/2:N-1), Yt(N/2:N-1)); 
title('Frequency Domain Plot - 12kHz Sampling Frequency');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];

Yt = 20*log10(%eps+abs(fftshift(fft(y4))));
Yt = Yt / nval;
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / (8*N);
subplot(4,2,7); plot2d(y2); title('Time Domain Plot - 6kHz Sampling Frequency');
subplot(4,2,8); plot2d(F(N/2:N-1), Yt(N/2:N-1)); 
title('Frequency Domain Plot - 6kHz Sampling Frequency');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];

clear();
[y, Fs, bits] = wavread('Sound1.wav');
// Taking a portion of the input signal - Sampled at 48kHz	
y = y(1,182680:200000);
y = y./(abs(max(y)));		// Normalizing the signal
// Taking 30ms worth of signal
noSamples = Fs * 30 /1000;
y1 = y(1:noSamples);
exec quantize.sci;
y2 = quantize(y1,8);
y3 = quantize(y1,4);
y4 = quantize(y1,2);

Yt = 20*log10(%eps+abs(fftshift(fft(y1))));
nval = abs(max(Yt));
Yt = Yt / nval;
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / N;
scf();
subplot(4,2,1); plot2d(y1); title('Time Domain Plot - 16bit/48kHz Sampling Frequency');
subplot(4,2,2); plot2d(F(N/2:N-1), Yt(N/2:N-1)); 
title('Frequency Domain Plot - 16bit/48kHz Sampling Frequency');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];

Yt = 20*log10(%eps+abs(fftshift(fft(y2))));
Yt = Yt / nval;
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / N;
subplot(4,2,3); plot2d(y2); title('Time Domain Plot - 8bit/48kHz Sampling Frequency');
subplot(4,2,4); plot2d(F(N/2:N-1), Yt(N/2:N-1)); 
title('Frequency Domain Plot - 8bit/48kHz Sampling Frequency');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];

Yt = 20*log10(%eps+abs(fftshift(fft(y3))));
Yt = Yt / nval;
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / N;
subplot(4,2,5); plot2d(y3); title('Time Domain Plot - 4bit/48kHz Sampling Frequency');
subplot(4,2,6); plot2d(F(N/2:N-1), Yt(N/2:N-1)); 
title('Frequency Domain Plot - 4bit/48kHz Sampling Frequency');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];

Yt = 20*log10(%eps+abs(fftshift(fft(y4))));
Yt = Yt / nval;
N = length(Yt);
F = -(N/2):(-1 + N/2);
F = Fs * F / N;
subplot(4,2,7); plot2d(y4); title('Time Domain Plot - 2bit/48kHz Sampling Frequency');
subplot(4,2,8); plot2d(F(N/2:N-1), Yt(N/2:N-1)); 
title('Frequency Domain Plot - 2bit/48kHz Sampling Frequency');
a = get("current_axes");
a.data_bounds = [0,min(Yt);24000, max(Yt)];
