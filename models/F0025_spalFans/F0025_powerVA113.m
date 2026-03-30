function P = F0025_powerVA113(q, n)

% parameters
c = [921.12; -758.93; 1081.5; -464.8];

% function
P2 = c(1) + c(2) .* q + c(3) .* q.^2 + c(4) .* q.^3;

% affinity law
P = P2 .* (n./4750).^3;

end