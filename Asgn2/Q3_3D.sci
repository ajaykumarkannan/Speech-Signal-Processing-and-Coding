Nms = input("Enter the frame size in milliseconds: ");
Sfms = input("Enter the frame shift in milliseconds: ");
FileName = input("Enter the sound file name (Enclose in single quotes): ");

[y, Fs, bits] = wavread(FileName);
N = Nms * Fs / 1000;		// Number of frames for size
Sf = Sfms * Fs / 1000;		// Number of frames for shift
y = y(1,:);

clf();
subplot(2,1,1);
t = 0:(1/Fs):((-1+length(y))/Fs);
plot2d(t,y);
xlabel('Time');
ylabel('Input');
title('Input Signal');

auto = zeros(N, length(y) / Sf - 1);

for i = 1:Sf:(length(y)-N)
	for l = 0:N-1
		s = 0;
		for u = 0:(N-l-1)
			s = s + y(i+u) * y(i+u+l);
		end
		auto(l+1, ceil(i/Sf)) = s;
	end
end

subplot(2,1,2);
t = (0:(N-1))' / Fs;
TotalT = (0:Sf:(length(y)-N)) / Fs;
[tt kk zz] = genfac3d(t,TotalT,auto);
t = size(zz);
plot3d([tt],[ff],list([zz],[ones(1,t(2))]))
h=gce(); 				//get handle on current entity (here the surface)
k=gcf();				//get the handle of the parent figure    

k.color_map=bonecolormap(512);
h.color_flag=1; 		//color according to z
h.color_mode=-2;  		//remove the facets boundary by setting color_mode to white color
title('Short Term Auto Correlation');
