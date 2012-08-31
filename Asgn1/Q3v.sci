// Part 5, c, j
[ai Fsai bitsai] = wavread('c.wav');
[a Fsa bitsa]  = wavread('j.wav');

scf();
subplot(2,1,1);
plot2d(ai);
title('c');
subplot(2,1,2);
plot2d(a);
title('j');

NumSamples = Fsai * 30 / 1000;

scf();
F = Fsai*((0:NumSamples-1) - NumSamples/2) / NumSamples;

// For c
ai = ai(6484:6484+NumSamples);
ai = ai / abs(max(ai));
AI = 20*log10(abs(fftshift(fft(ai))));
AI = AI / abs(max(AI));
subplot(2,2,1);
plot2d(ai);
title('c');
subplot(2,2,2);
plot2d(F(NumSamples/2:NumSamples), AI(NumSamples/2:NumSamples));
title('c');
ax = get("current_axes");
ax.data_bounds = [0,min(AI); max(F), max(AI)]; 

// For j
a = a(5785:5785+NumSamples);
a = a / abs(max(a));
A = 20*log10(abs(fftshift(fft(a))));
A = A / abs(max(A));
subplot(2,2,3);
plot2d(a);
title('j');
subplot(2,2,4);
plot2d(F(NumSamples/2:NumSamples), A(NumSamples/2:NumSamples));
title('j');
ax = get("current_axes");
ax.data_bounds = [0,min(A); max(F), max(A)]; 
