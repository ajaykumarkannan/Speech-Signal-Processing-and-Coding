fh = 0:20000;
exec('hz2mel.sci');
exec('mel2hz.sci');
fmel = hz2mel(fh);
plot(fh, fmel);
title('Plot between f_hz vs f_mel');
a = get("current_axes");
a.tight_limits = "on"
xlabel('f_hz');
ylabel('f_mel');