function dp = F0014_variableAreaPressureDrop(T,p,W,open,par)

% parameters
zeta = par.zeta;
R    = par.R_air;
A    = par.A .* open;

% density
rho = p ./ (R.*T);

% velocity
v = W ./ (rho.*A);

% pressure drop
dp = 1/2 .* zeta .* rho .* v.^2;

