function P = F0025_powerVA164A(q, n)

% parameters
c = [1.304309138899855e+03; -1.023894573709462e+02];

% function
P2 = c(1) + c(2) .* q.^2;


% affinity law
P = P2 .* (n./3000).^3;

end