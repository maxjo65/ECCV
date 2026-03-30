function I = F0023_current(q, V)

% parameters
a = [-4.6456; 2.8036; 1.7966];

% function
I = a(1) + a(2) .* q + a(3) .* V; 

end