function dp = F0025_pressureVA164A(q, n)

% parameters
a = [1.013138031041656e+03; -4.046095247275258e+02];

% function
dp2 = a(1) + a(2) .* q;

% affinity law
dp = dp2 .* (n./3000).^2;

end