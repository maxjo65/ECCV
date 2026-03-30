function dp = F0017_restriction(W, rho, par)

% Discharge coefficient
C   = par.C;
d   = par.d;

% Area
A = pi .* d.^2 / 4;

% Laminar restriction
dp = 1./rho .* (W ./ (C.*A));