clear;
[y, Fs, bits] = wavread('Voiced.wav');
y = y(1,:);				// Had recorded in stereo - Converting to mono
y = y./(abs(max(y)));		// Normalizing the signal
N = Fs * 30 /1000;            // 30ms block size
shift = Fs * 10 /1000;;        // 10ms shift

exec('find_peaks.sci');

ceps = zeros(N, (length(y)-N)/shift);
cepsl = zeros(N, (length(y)-N)/shift);
Y = zeros(N, (length(y)-N)/shift);
Ynew = zeros(N, (length(y)-N)/shift);
loc = zeros(3, (length(y)-N)/shift);

f = Fs* ((1-N/2):N/2) / N;
f2 = f;
f2(f2 < 0) = [];

si = size(ceps);
ed = si(1);
mid = si(1) / 2;
UF = 1400;                    // Setting 250 Hz as upper frequency bound
thres = 20;
lp = Fs / (UF+20);         

for i = 1:shift:(length(y)-N)
    temp = y(i:(i+N-1));
    Y(:,ceil(i/shift)) = log(abs(fft(temp)))';
    ceps(:,ceil(i/shift)) = ifft(Y(:,ceil(i/shift)));
    cepsl(:,ceil(i/shift)) = ceps(:,ceil(i/shift));
    cepsl(lp:ed-lp,ceil(i/shift)) = 0;
    Ynew(:,ceil(i/shift)) = fftshift(fft(cepsl(:,ceil(i/shift))));
    
    Ytemp = Ynew(:,ceil(i/shift));
    Ytemp(f < 0) = [];
    // Find first three formants
    loc(:, ceil(i/shift)) = find_peaks(Ytemp, 3);
//    clf();
//    plot(f2, Ytemp);
//    plot(f2(loc(:,ceil(i/shift))), Ytemp(loc(:,ceil(i/shift))),'.');
//    sleep(1000);
    
end
scf();
plot(Ynew(:,10));
//point = ceil(si(2)/2);
//
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
//subplot(2,2,3);
//temp = (fftshift(Y(:,point)))/max(real((fftshift(Y(:,point)))));
//plot(f, temp)
//title('Normalized Log Magnitude Spectrum of signal');
//a = get("current_axes");
//a.data_bounds = [0,min((temp));max(f), max((temp))];
//a.tight_limits = "on";
//
//subplot(2,2,4);
//temp = Ynew(:,point) / max(real(Ynew(:,point)));
//plot(f, temp);
//temp(f<0) = [];
//plot(f2(loc(:,point)), temp(loc(:,point)),'.');
//title('Normalized Log Magnitude Spectrum after lifering');
//b = get("current_axes");
//b.data_bounds = [0,min(real(temp));max(f), max(real(temp))];
//b.tight_limits = "on";

scf();
subplot(3,1,1);
title('First three formants');
plot(f2(loc(3,:)),'.r');
plot(f2(loc(2,:)),'.g');
plot(f2(loc(1,:)),'.b');
ylabel('Frequency in Hz');
xlabel('Frame Number');

// Averaging filter
filsize = 19;            // Use odd number here
rem = (filsize - 1) / 2;
subplot(3,1,2);
title('First three formants (Averaging Filter)');
j = convol(f2(loc(3,:)), ones(filsize,1)) / filsize;
j(1:rem) = [];
j(length(loc(1,:)):length(j)) = [];
plot(j,'r');
j = convol(f2(loc(2,:)), ones(filsize,1)) / filsize;
j(1:rem) = [];
j(length(loc(1,:)):length(j)) = [];
plot(j,'g');
j = convol(f2(loc(1,:)), ones(filsize,1)) / filsize;
j(1:rem) = [];
j(length(loc(1,:)):length(j)) = [];
plot(j,'b');
ylabel('Frequency in Hz');
xlabel('Frame Number');

// Median filtering
exec('median_filter.sci');
filsize = 19;
subplot(3,1,3);
title('First three formants (Median Filter)');
j = median_filter(f2(loc(3,:)), filsize);
plot(j,'r');
j = median_filter(f2(loc(2,:)), filsize);
plot(j,'g');
j = median_filter(f2(loc(1,:)), filsize);
plot(j,'b');
ylabel('Frequency in Hz');
xlabel('Frame Number');
