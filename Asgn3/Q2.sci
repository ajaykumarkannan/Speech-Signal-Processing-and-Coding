fh = 0:200:20000;
fmel = 2595*log10(1+fh/700);
plot(fh, fmel);
title('Plot between f_hz vs f_mel');
xlabel('f_hz');
ylabel('f_mel');
