// Part 1 a, e, i, o, u
[a Fsa bitsa] = wavread('a.wav');
[e Fse bitse]  = wavread('e.wav');
[i Fsi bitsi] = wavread('i.wav');
[o Fso bitso] = wavread('o.wav');
[u Fsu bitsu] = wavread('u.wav');

subplot(5,1,1);
plot2d(a);
title('a');
subplot(5,1,2);
plot2d(e);
title('e');
subplot(5,1,3);
plot2d(i);
title('i');
subplot(5,1,4);
plot2d(o);
title('o');
subplot(5,1,5);
plot2d(u);
title('u');

NumSamples = Fsa * 30 / 1000;

scf();
F = Fsa*((0:NumSamples-1) - NumSamples/2) / NumSamples;

// For a
a = a(20000:20000+NumSamples);
a = a / abs(max(a));
A = 20*log10(abs(fftshift(fft(a))));
A = A / abs(max(A));
subplot(5,2,1);
plot2d(a);
title('a');
subplot(5,2,2);
plot2d(F(NumSamples/2:NumSamples), A(NumSamples/2:NumSamples));
title('a');
ax = get("current_axes");
ax.data_bounds = [0,min(A); max(F), max(A)]; 

// For e
e = e(20000:20000+NumSamples);
e = e / abs(max(e));
E = 20*log10(abs(fftshift(fft(e))));
E = E / abs(max(E));
subplot(5,2,3);
plot2d(e);
title('e');
subplot(5,2,4);
plot2d(F(NumSamples/2:NumSamples), E(NumSamples/2:NumSamples));
title('e');
ax = get("current_axes");
ax.data_bounds = [0,min(E); max(F), max(E)]; 

// For i
i = i(30000:30000+NumSamples);
i = i / abs(max(i));
I = 20*log10(abs(fftshift(fft(i))));
I = I / abs(max(I));
subplot(5,2,5);
plot2d(i);
title('i');
subplot(5,2,6);
plot2d(F(NumSamples/2:NumSamples), I(NumSamples/2:NumSamples));
title('i');
ax = get("current_axes");
ax.data_bounds = [0,min(I); max(F), max(I)]; 

// For o
o = o(25000:25000+NumSamples);
o = o / abs(max(o));
O = 20*log10(abs(fftshift(fft(o))));
O = O / abs(max(O));
subplot(5,2,7);
plot2d(o);
title('o');
subplot(5,2,8);
plot2d(F(NumSamples/2:NumSamples), O(NumSamples/2:NumSamples));
title('o');
ax = get("current_axes");
ax.data_bounds = [0,min(O); max(F), max(O)]; 

// For u
u = u(20000:20000+NumSamples);
u = u / abs(max(u));
U = 20*log10(abs(fftshift(fft(u))));
U = U / abs(max(U));
subplot(5,2,9);
plot2d(u);
title('u');
subplot(5,2,10);
plot2d(F(NumSamples/2:NumSamples), U(NumSamples/2:NumSamples));
title('u');
ax = get("current_axes");
ax.data_bounds = [0,min(U); max(F), max(U)]; 
