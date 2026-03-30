function [P, eta, T4] = F0026_turbine(W, p3, p4, T3, N, par)
D = par.D;
% x = par.x;
y = par.y;

% pressure ratio
Pi = p4./p3;

% ratio of specific heats
g = 1.4;

% efficiency
BSR = pi .* D .* N  ./ ( 60 .* sqrt(2 .* 1e3 .* T3 .* ( 1 - Pi.^((g-1)./g) ) ) );
A   = [ones(length(BSR), 1), N./sqrt(T3), (N./sqrt(T3)).^2];
B   = [A, A .* BSR, A.*BSR.^2];
eta = B * y;

% eta saturation
eta = min(eta,   1);
eta = max(eta,   0);

% Power
cp = 1e3;
P  = W .* cp .* eta .* T3 .* (1 - Pi.^((g-1)./g) );

% Temperature
T4 = T3 .* ( 1 - eta .* (1 - Pi.^((g-1)./g) ));

end