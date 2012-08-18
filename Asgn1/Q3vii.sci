// Part 7 - y, i, a
[ai Fsai bitsai] = wavread('y.wav');
[i Fsa bitsa]  = wavread('i.wav');
[a Fsi bitsi] = wavread('a.wav');

scf();
subplot(3,1,1);
plot2d(ai);
title('y');
subplot(3,1,3);
plot2d(a);
title('a');
subplot(3,1,2);
plot2d(i);
title('i');

NumSamples = Fsai * 30 / 1000;

scf();
F = Fsai*((0:NumSamples-1) - NumSamples/2) / NumSamples;

// For y
ai = ai(20000:20000+NumSamples);
ai = ai / abs(max(ai));
AI = 20*log10(abs(fftshift(fft(ai))));
AI = AI / abs(max(AI));
subplot(3,2,1);
plot2d(ai);
title('y');
subplot(3,2,2);
plot2d(F(NumSamples/2:NumSamples), AI(NumSamples/2:NumSamples));
title('y');
ax = get("current_axes");
ax.data_bounds = [0,min(AI); max(F), max(AI)]; 

// For a
a = a(25000:25000+NumSamples);
a = a / abs(max(a));
A = 20*log10(abs(fftshift(fft(a))));
A = A / abs(max(A));
subplot(3,2,5);
plot2d(a);
title('a');
subplot(3,2,6);
plot2d(F(NumSamples/2:NumSamples), A(NumSamples/2:NumSamples));
title('a');
ax = get("current_axes");
ax.data_bounds = [0,min(A); max(F), max(A)]; 

// For i
i = i(30000:30000+NumSamples);
i = i / abs(max(i));
I = 20*log10(abs(fftshift(fft(i))));
I = I / abs(max(I));
subplot(3,2,3);
plot2d(i);
title('i');
subplot(3,2,4);
plot2d(F(NumSamples/2:NumSamples), I(NumSamples/2:NumSamples));
title('i');
ax = get("current_axes");
ax.data_bounds = [0,min(I); max(F), max(I)];
