[y, Fs, bits] = wavread('Sound2.wav');
y = y(1,:);				// Had recorded in stereo - Converting to mono
y = y./(abs(max(y)));		// Normalizing the signal
// Taking 20ms worth of signal
N = Fs * 20 /1000;
shift = N /2 ;        // 10ms shift

ceps = zeros(N, (length(y)-N)/shift);
for i = 1:shift:(length(y)-N)
    temp = y(i:(i+N-1));
    ceps(:,ceil(i/shift)) = fftshift(ifft(log(abs(fft(temp))))');
end

scf();

si = size(ceps);
frame = 1:si(2);
t = linspace(-0.01, 0.01, N);
[X Y] = meshgrid(frame, t);
surf(X, Y, ceps);
h=gce(); 				//get handle on current entity (here the surface)
k=gcf();				//get the handle of the parent figure    
k.color_map=hsvcolormap(1024);
h.color_flag=1; 		//color according to z
h.color_mode=-2;  		//remove the facets boundary by setting color_mode to white color