function dp = F0014_restrictionPressureDrop2(T,p,W,par)

% parameters
zeta = par.zeta;
R    = par.R_air;

% density
rho = p ./ (R.*T);

% pressure drop
dp = zeta .* W.^2 ./ rho;

