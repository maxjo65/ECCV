function dp = F0022_simpleExpansionValve(W, rho_us, alpha, par)

% parameters
M  = par.M;
Tc = par.Tc;
D  = par.D;
C  = par.C;

% constants
R = 8.314472;

% exv geometry
A = alpha .* D.^2 .* pi / 4;

% pressure drop
dp = 1./rho_us .* ( W ./ (C.*A) ).^2;

end