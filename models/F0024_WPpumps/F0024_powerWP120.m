function P = F0024_powerWP120(q, n)

% parameters
a = [-385.2919; 155.7472; 0.1219];

% function
P = a(1) + a(2) .* q + a(3) .* n; 

end