function dp = F0014_intakePressureIncrease(T, p, v, par)

% parameters
zeta = par.zeta;
R    = par.R_air;

% density
rho = p ./ (R.*T);

% pressure drop
dp = 1/2 .* zeta .* rho .* v.^2;