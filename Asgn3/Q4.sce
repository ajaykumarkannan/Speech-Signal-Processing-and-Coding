clear;
[y, Fs, bits] = wavread('Sound4.wav');
y = y(1,:);				// Had recorded in stereo - Converting to mono
y = y./(abs(max(y)));		// Normalizing the signal
N = Fs * 40 /1000;            // 30ms block size
shift = Fs * 10 /1000;;        // 10ms shift

ceps = zeros(N, (length(y)-N)/shift);
cepsl = zeros(N, (length(y)-N)/shift);
Y = zeros(N, (length(y)-N)/shift);
Ynew = zeros(N, (length(y)-N)/shift);
loc = zeros(1, (length(y)-N)/shift);
f = Fs* (1:N) / N;

si = size(ceps);
ed = si(1);
mid = si(1) / 2;
UF = 250;                    // Setting 250 Hz as upper frequency bound
thres = 20;
lp = Fs / (UF+20);         

for i = 1:shift:(length(y)-N)
    temp = y(i:(i+N-1));
    Y(:,ceil(i/shift)) = log(abs(fft(temp)))';
    ceps(:,ceil(i/shift)) = ifft(Y(:,ceil(i/shift)));
    cepsl(:,ceil(i/shift)) = ceps(:,ceil(i/shift));
    cepsl(1:lp,ceil(i/shift)) = 0;
    cepsl((ed-lp):ed+1,ceil(i/shift)) = 0;
    Ynew(:,ceil(i/shift)) = fft(cepsl(:,ceil(i/shift)));
    [pt loc(ceil(i/shift))] = max(real(cepsl(:,ceil(i/shift))));
end

point = ceil(si(2)/2);

//scf();
//subplot(2,2,1);
//plot(fftshift(ceps(:,point)));
//title('Cepstral Coefficients');
//my = get("current_axes");
//// High time lifering
//subplot(2,2,2);
//plot(fftshift(cepsl(:,point)));
//title('Cepstral Coefficients after Low Time Lifering');
//
//f = Fs* ((1-N/2):N/2) / N;
//subplot(2,2,3);
//plot(f, abs(fftshift(Y(:,1))));
//title('Log Magnitude Spectrum of signal');
//a = get("current_axes");
//temp = Y(:,1);
//a.data_bounds = [0,min(abs(temp));max(f), max(abs(temp))];
//subplot(2,2,4);
//plot(f, abs(fftshift(Ynew(:,1))));
//title('Log Magnitude Spectrum after lifering');
//b = get("current_axes");
//temp = Ynew(:,1);
//b.data_bounds = [0,min(abs(temp));max(f), max(abs(temp))];

scf();
loc = Fs./loc;
plot(loc,'.');
c = get("current_axes");
c.data_bounds = [1,0;length(loc), UF];
title('Pitch Estimate by low time lifering');
xlabel('Frame');
ylabel('Frequency in Hz');