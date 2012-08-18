// Part 2 ai, a2, i2
[ai Fsai bitsai] = wavread('ai.wav');
[a2 Fsa2 bitsa2]  = wavread('a2.wav');

scf();
subplot(3,1,1);
plot2d(ai);
subplot(3,1,2);
plot2d(a2);

NumSamples = Fsai * 30 / 1000;

scf();
F = Fsai*((0:NumSamples-1) - NumSamples/2) / NumSamples;

// For ai
ai = ai(20000:20000+NumSamples);
ai = ai / abs(max(ai));
AI = 20*log10(abs(fftshift(fft(ai))));
AI = AI / abs(max(AI));
subplot(3,2,1);
plot2d(ai);
subplot(3,2,2);
plot2d(F(NumSamples/2:NumSamples), AI(NumSamples/2:NumSamples));
ax = get("current_axes");
ax.data_bounds = [0,min(AI); max(F), max(AI)]; 

// For a2
a2 = a2(25000:25000+NumSamples);
a2 = a2 / abs(max(a2));
A2 = 20*log10(abs(fftshift(fft(a2))));
A2 = A2 / abs(max(A2));
subplot(3,2,3);
plot2d(a2);
subplot(3,2,4);
plot2d(F(NumSamples/2:NumSamples), A2(NumSamples/2:NumSamples));
ax = get("current_axes");
ax.data_bounds = [0,min(A2); max(F), max(A2)]; 

