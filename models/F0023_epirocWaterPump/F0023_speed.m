function w = F0023_speed(q, V)

% parameters
b = [1.6954; 0.3962; 0.4124; -0.0700];

% function
w = 1000 * (b(1) + b(2) .* q + b(3) .* V + b(4) .* q.* V) .* 2.*pi/60; 

end