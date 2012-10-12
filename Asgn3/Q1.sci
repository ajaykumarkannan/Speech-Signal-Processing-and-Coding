scf();

[y, Fs, bits] = wavread('Voiced.wav');
y = y(1,:);				// Had recorded in stereo - Converting to mono
y = y./(abs(max(y)));		// Normalizing the signal
// Taking 20ms worth of signal
noSamples = Fs * 30 /1000;
start = 5000;
y1 = y(start:(-1+start+noSamples));
t = linspace(0,0.02,length(y1));		
w = window('hn', noSamples);

y = y1.*w;
// y = y1;
Yt = fft(y);
N = noSamples; 
F = -(N/2):(-1 + N/2);
F = Fs * F / N;

subplot(5,1,1);
plot(t,y1); 
title('Selected frame of voiced speech');

subplot(5,1,2);
plot(t,y);
title('Hann Windowed Function');

subplot(5,1,3);
plot(F(N/2:N-1), abs(Yt(1:N/2)));
title('DFT of the signal');
a = get("current_axes");
a.data_bounds = [0,min(abs(Yt));24000, max(abs(Yt))];
subplot(5,1,4);
Yt2 = log(abs(Yt));
plot(F(N/2:N-1), Yt2(1:N/2));
a = get("current_axes");
a.data_bounds = [0,min(Yt2);24000, max(Yt2)];
title('Log magnitude spectrum');
Yt3 = ifft(Yt2);
subplot(5,1,5);
t = t - 0.01;
plot(Yt3(1:300));
title('Cepstrum');

scf();
y = y1;
Yt = fft(y);
N = noSamples; 
F = -(N/2):(-1 + N/2);
F = Fs * F / N;

subplot(5,1,1);
plot(t,y1); 
title('Selected frame of voiced speech');

subplot(5,1,2);
plot(t,y);
title('Rectangular Windowed Function');

subplot(5,1,3);
plot(F(N/2:N-1), abs(Yt(1:N/2)));
title('DFT of the signal');
a = get("current_axes");
a.data_bounds = [0,min(abs(Yt));24000, max(abs(Yt))];
subplot(5,1,4);
Yt2 = log(abs(Yt));
plot(F(N/2:N-1), Yt2(1:N/2));
a = get("current_axes");
a.data_bounds = [0,min(Yt2);24000, max(Yt2)];
title('Log magnitude spectrum');
Yt3 = ifft(Yt2);
subplot(5,1,5);
t = t - 0.01;
plot(Yt3(1:300));
title('Cepstrum');