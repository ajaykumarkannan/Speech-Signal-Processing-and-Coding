[y, Fs, bits] = wavread('Sound2.wav');
y = y(1,:);				// Had recorded in stereo - Converting to mono
y = y./(abs(max(y)));		// Normalizing the signal
N = Fs * 30 /1000;            // 30ms block size
shift = Fs * 10 /1000;;        // 10ms shift

ceps = zeros(N, (length(y)-N)/shift);
cepsl = zeros(N, (length(y)-N)/shift);
Y = zeros(N, (length(y)-N)/shift);
Ynew = zeros(N, (length(y)-N)/shift);
f = Fs* (1:N) / N;

si = size(ceps);
ed = si(1);
mid = si(1) / 2;
lp = 50;


for i = 1:shift:(length(y)-N)
    temp = y(i:(i+N-1));
    Y(:,ceil(i/shift)) = log(abs(fft(temp)))';
    ceps(:,ceil(i/shift)) = ifft(Y(:,ceil(i/shift)));
    cepsl(:,ceil(i/shift)) = ceps(:,ceil(i/shift));
    cepsl(lp:ed-lp,ceil(i/shift)) = 0;
    Ynew(:,ceil(i/shift)) = fft(cepsl(:,ceil(i/shift)));
end

scf();
subplot(2,2,1);
plot(fftshift(ceps(:,1)));
title('Cepstral Coefficients');
// Low time lifering
subplot(2,2,2);
plot(fftshift(cepsl(:,1)));
title('Cepstral Coefficients after Low Time Lifering');

f = Fs* ((1-N/2):N/2) / N;
subplot(2,2,3);
plot(f, abs(fftshift(Y(:,1))));
title('Log Magnitude Spectrum of signal');
a = get("current_axes");
temp = Y(:,1);
a.data_bounds = [0,min(abs(temp));max(f), max(abs(temp))];
subplot(2,2,4);
plot(f, abs(fftshift(Ynew(:,1))));
title('Log Magnitude Spectrum after lifering');
b = get("current_axes");
temp = Ynew(:,1);
b.data_bounds = [0,min(abs(temp));max(f), max(abs(temp))];