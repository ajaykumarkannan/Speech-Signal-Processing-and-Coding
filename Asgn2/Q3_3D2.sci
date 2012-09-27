Nms = input("Enter the frame size in milliseconds: ");
Sfms = input("Enter the frame shift in milliseconds: ");
FileName = input("Enter the sound file name (Enclose in single quotes): ");

[y, Fs, bits] = wavread(FileName);
N = Nms * Fs / 1000;		// Number of frames for size
Sf = Sfms * Fs / 1000;		// Number of frames for shift
y = y(1,:);

clf();
t = 0:(1/Fs):((-1+length(y))/Fs);
plot2d(t,y);
xlabel('Time');
ylabel('Input');
title('Input Signal');

auto = zeros(N, (length(y) / Sf) - 1);

index = 0;
for i = 1:Sf:(length(y)-N)
	index = index + 1;
	temp = zeros(1, 2*N);
	temp(1:N) = y(i:(i+N-1));
	for l = 1:N
		auto(:,index) = auto(:, index) + temp(l:(l+N-1))'*temp(l);
	end
end

scf();
t = (0:(N-1))' / Fs;
TotalT = (0:Sf:(length(y)-N)) / Fs;
[X Y] = meshgrid(TotalT, t);
auto = auto(1:length(t),1:length(TotalT));
surf(X, Y, auto);
h=gce(); 				//get handle on current entity (here the surface)
k=gcf();				//get the handle of the parent figure    
k.color_map=bonecolormap(1024);
h.color_flag=1; 		//color according to z
h.color_mode=-2;  		//remove the facets boundary by setting color_mode to white color
title('Short Term Auto Correlation');
xlabel('t - Time in Seconds');
ylabel('l - Time shift in seconds');
zlabel('R(l) - Autocorrelation function for l at time t')
