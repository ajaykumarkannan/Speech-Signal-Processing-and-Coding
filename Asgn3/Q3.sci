clear;
exec('hz2mel.sci');
exec('mel2hz.sci');
[y, Fs, bits] = wavread('Sound4_16hz.wav');
y = y(1,:);				// Had recorded in stereo - Converting to mono
y = y./(abs(max(y)));		// Normalizing the signal
N = Fs * 30 /1000;            // 30ms block size
shift = Fs * 10 /1000;;        // 10ms shift

// Calculating the melbands
NBands = 26;
melbands = linspace(1,hz2mel(Fs/2),NBands);


mfcc = zeros(length(melbands)-2, (length(y)-N)/shift);

fhz = Fs* ((1-N/2):N/2) / N; 
fhzpos = fhz;
fhzpos(fhz < 0) = [];
Emel = zeros(length(melbands) - 2, (length(y)-N)/shift);
exec('mel_energy.sci');

for i = 1:shift:(length(y)-N)
    temp = y(i:(i+N-1));
    Y(:,ceil(i/shift)) = fftshift(log(abs(fft(temp))))';
    temp = Y(:,ceil(i/shift));
    temp(fhz < 0) = [];
    if(i ~= 1) then 
        Emel(:, ceil(i/shift)) = mel_energy(temp, fhzpos, melbands, 0);
    else 
        Emel(:, ceil(i/shift)) = mel_energy(temp, fhzpos, melbands, 1);
    end
    mfcc(:, ceil(i/shift)) = idct(Emel(:, ceil(i/shift)));
end

t = mfcc(:,1:50);
s = size(t);
a = 1:s(1);
b = 1:s(2);
scf();
subplot(1,2,1);
plot3d(a, b,t);
title('MFCC of first fifty frames');
xlabel('Band number');
ylabel('Frame Number');
zlabel('Value of MFCC');
a = gca();
a.rotation_angles=[89.8 -60];
a.tight_limits = "on";

t = Emel(:,1:50);
s = size(t);
a = 1:s(1);
b = 1:s(2);
subplot(1,2,2);
plot3d(a, b,t);
title('Energy of first fifty frames');
xlabel('Band number');
ylabel('Frame Number');
zlabel('Energy');
a = gca();
a.rotation_angles=[85.9 -48.8];
a.tight_limits = "on";

t = Y(:,1:50);
scf();
TotalT = 1:50;
[X Yplot] = meshgrid(fhz, TotalT);
stft = Y(1:length(fhz),1:length(TotalT));
surf(X, Yplot, stft');
h=gce(); 				//get handle on current entity (here the surface)
k=gcf();				//get the handle of the parent figure    
k.color_map=hsvcolormap(1024);
h.color_flag=1; 		//color according to z
h.color_mode=-2;  		//remove the facets boundary by setting color_mode to white color
title('Magnitude Spectrum of first fifty frames');
ylabel('Frame Number');
xlabel('F - Frequency');
a = gca();
a.data_bounds=[0,min(TotalT);max(fhz), max(TotalT)];
a.tight_limits = "on";
