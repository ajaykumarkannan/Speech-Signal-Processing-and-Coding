clear;
[y, Fs, bits] = wavread('Sound2.wav');
y = y(1,:);				// Had recorded in stereo - Converting to mono
y = y./(abs(max(y)));		// Normalizing the signal
// Taking 20ms worth of signal
N = Fs * 20 /1000;
shift = N /2 ;        // 10ms shift

ceps = zeros(N, (length(y)-N)/shift);
si = size(ceps);
ed = si(1);
mid = si(1) / 2;
UF = 1000;                    // Setting 250 Hz as upper frequency bound
thres = 20;
lp = Fs / (UF+20);     

i = 50;
temp = y(i:(i+N-1));
scf();
temp = log(abs(fft(temp)))';
subplot(3,1,1);
plot(temp);
cept1 = ifft(temp);
cept2 = cept1;

subplot(3,1,2);
plot(fft(cept1(1:13)));
cept2(lp:ed-lp) = 0;
subplot(3,1,3);
plot(fft(cept2));

for i = 1:shift:(length(y)-N)
    temp = y(i:(i+N-1));
    ceps(:,ceil(i/shift)) = real(fftshift(ifft(log(abs(fft(temp))))'));
end


//scf();
//
//si = size(ceps);
//frame = 1:si(2);
//t = linspace(-0.01, 0.01, N);
//[X Y] = meshgrid(frame, t);
//surf(X, Y, ceps);
//xlabel('Frame Number');
//ylabel('Cepstral Coefficients');
//h=gce(); 				//get handle on current entity (here the surface)
//k=gcf();				//get the handle of the parent figure    
//k.color_map=hsvcolormap(1024);
//h.color_flag=1; 		//color according to z
//h.color_mode=-2;  		//remove the facets boundary by setting color_mode to white color

scf();
si = size(ceps);
ceps = ceps(1:13,:);
ceps = ceps/max(abs(ceps));
delceps = diff(ceps,1,2);
deldelceps = diff(ceps, 2, 2);
ceps = ceps(1:13,1:(si(2)-2));
delceps = delceps(:, 1:(si(2)-2));
feature = cat(1, ceps, delceps, deldelceps);

si = size(feature);
frame = 1:si(2);
t = 1:si(1);
[X Y] = meshgrid(frame, t);
surf(X, Y, feature);
xlabel('Frame Number');
ylabel('Cepstral Coefficients');
h=gce(); 				//get handle on current entity (here the surface)
k=gcf();				//get the handle of the parent figure    
k.color_map=hsvcolormap(1024);
h.color_flag=1; 		//color according to z
a = gca();
a.rotation_angles=[45 45];
