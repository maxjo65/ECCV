function dp = F0025_pressureVA113(q, n)

% parameters
a = [859.99; -171.19; -292.55];

% function
dp2 = a(1) + a(2) .* q + a(3) .* q.^2;

% affinity law
dp = dp2 .* (n./4750).^2;

end