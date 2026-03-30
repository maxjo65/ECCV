function dp = F0023_pressure(q, V)

% parameters
a = [-0.1990; 0.2290; 0.1984; -0.0313; -0.2935];

% function
dp = a(1) + a(2) .* q + a(3) .* V + a(4) .* q.* V + a(5) .* q.^2;

end