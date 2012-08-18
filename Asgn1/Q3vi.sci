// Part 6 k, kh
[ai Fsai bitsai] = wavread('N.wav');
[a Fsa bitsa]  = wavread('n2.wav');

scf();
subplot(2,1,1);
plot2d(ai);
title('N');
subplot(2,1,2);
plot2d(a);
title('n');

NumSamples = Fsai * 30 / 1000;

scf();
F = Fsai*((0:NumSamples-1) - NumSamples/2) / NumSamples;

// For k
ai = ai(5500:5500+NumSamples);
ai = ai / abs(max(ai));
AI = 20*log10(abs(fftshift(fft(ai))));
AI = AI / abs(max(AI));
subplot(2,2,1);
plot2d(ai);
title('N');
subplot(2,2,2);
plot2d(F(NumSamples/2:NumSamples), AI(NumSamples/2:NumSamples));
title('N');
ax = get("current_axes");
ax.data_bounds = [0,min(AI); max(F), max(AI)]; 

// For kh
a = a(7900:7900+NumSamples);
a = a / abs(max(a));
A = 20*log10(abs(fftshift(fft(a))));
A = A / abs(max(A));
subplot(2,2,3);
plot2d(a);
title('n');
subplot(2,2,4);
plot2d(F(NumSamples/2:NumSamples), A(NumSamples/2:NumSamples));
title('n');
ax = get("current_axes");
ax.data_bounds = [0,min(A); max(F), max(A)]; 
