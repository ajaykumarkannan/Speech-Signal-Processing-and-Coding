Nms = input("Enter the frame size in milliseconds: ");
Sfms = input("Enter the frame shift in milliseconds: ");
FileName = input("Enter the sound file name (Enclose in single quotes): ");

[y, Fs, bits] = wavread(FileName);
N = Nms * Fs / 1000;		// Number of frames for size
Sf = Sfms * Fs / 1000;		// Number of frames for shift
y = y(1,:);

clf();
t = 0:(1/Fs):((-1+length(y))/Fs);
plot(t,y);
xlabel('Time');
ylabel('Input');
title('Input Signal');

stft = zeros(N, (length(y) / Sf) - 1);

index = 0;
for i = 1:Sf:(length(y)-N)
	index = index + 1;
	temp = y(i:(i+N-1));
	stft(:,index) = 10*log(%eps+fftshift(fft(temp))');
end

scf();
f = (0:(N-1)) - N/2;
f = Fs* f / N;
stft(f < 0,:) = [];
f(f<0) = [];
TotalT = (0:Sf:(length(y)-N)) / Fs;
TotalT = TotalT(1:50);
[X Y] = meshgrid(f, TotalT);
stft = stft(1:length(f),1:length(TotalT));
surf(X, Y, stft');
h=gce(); 				//get handle on current entity (here the surface)
k=gcf();				//get the handle of the parent figure    
k.color_map=hsvcolormap(1024);
h.color_flag=1; 		//color according to z
h.color_mode=-2;  		//remove the facets boundary by setting color_mode to white color
a = gca();
a.tight_limits = "on";
title('Short Term Fourier Transform - Log Magnitude Spectrum - First 50 Frames');
ylabel('t - Time in Seconds');
xlabel('F - Frequency');
zlabel('Short Term Fourier Transform')
