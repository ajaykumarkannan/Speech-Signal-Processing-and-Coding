// Part 1 a, e, i, o, u
[a Fsa bitsa] = wavread('a.wav');
[e Fse bitse]  = wavread('e.wav');
[i Fsi bitsi] = wavread('i.wav');
[o Fso bitso] = wavread('o.wav');
[u Fsu bitsu] = wavread('u.wav');

subplot(5,1,1);
plot2d(a);
subplot(5,1,2);
plot2d(e);
subplot(5,1,3);
plot2d(i);
subplot(5,1,4);
plot2d(o);
subplot(5,1,5);
plot2d(u);
