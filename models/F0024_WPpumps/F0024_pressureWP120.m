function dp = F0024_pressureWP120(q, n)

% parameters
a = 1.0e+04 * [0.8098; 0.0038; 0.0013; -5.4000];

% function
dp = a(1) + a(2) .* n + a(3) .* q.* n + a(4) .* q.^2;

end