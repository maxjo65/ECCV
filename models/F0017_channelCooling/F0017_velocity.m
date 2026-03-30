function v = F0017_velocity(W, rho, par)

% parameters
d   = par.d;

% area
A = pi .* d.^2 / 4;

% velocity
v = W ./ (rho .* A);
