function dp = F0014_restrictionPressureDrop(T,p,W,par)

% parameters
zeta = par.zeta;
R    = par.R_air;
A    = par.A;

% density
rho = p ./ (R.*T);

% velocity
v = W ./ (rho.*A);

% pressure drop
dp = 1/2 .* zeta .* rho .* v.^2;

