function P = F0025_powerVA195(q, n)

% parameters
c = [33.581405740918410; -4.335839924811192e+02];

% function
P2 = c(1) + c(2) .* q.^2;


% affinity law
P = P2 .* (n./5000).^3;

end