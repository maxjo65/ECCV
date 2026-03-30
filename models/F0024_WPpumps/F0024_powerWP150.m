function P = F0024_powerWP150(q, n)

% parameters
a =  [-1578.62293476575; 122.984201937838; 0.569192422324180];

% function
P = a(1) + a(2) .* q + a(3) .* n; 

end