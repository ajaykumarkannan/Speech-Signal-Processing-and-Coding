clf();
[y, Fs, bits] = wavread('Sound1.wav');

y = y(1,:);				// Had recorded in stereo - Converting to mono
N = Fs * 30 / 1000; 				// Block size
F = ((0:(N-1)) - (N/2))/N;
t = 1:(length(y)/N);
Z = zeros(length(t), N);
for i = 1:length(y)/N
	Z(i,:) = 10*log10(%eps+abs(fftshift(fft(y((1+(i-1)*N):(i*N))))));
end

[tt ff zz] = genfac3d(t,F(N/2:(N-1)),Z(:,N/2:(N-1)));
t = size(zz);
plot3d([tt],[ff],list([zz],[ones(1,t(2))]))
h=gce(); 				//get handle on current entity (here the surface)
k=gcf();				//get the handle of the parent figure    

k.color_map=hotcolormap(512);
h.color_flag=1; 		//color according to z
h.color_mode=-2;  		//remove the facets boundary by setting color_mode to white color
