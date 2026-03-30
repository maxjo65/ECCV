function dp = F0017_incompressibleRestriction(W, dr, rho,  par)

% parameters
C_d = par.C_d;
d   = par.d;

% restriction area
Ar = dr.^2 * pi / 4;

% diameter ratio
beta = dr./d;

% volumetric flow
% Q = W ./ rho;

% pressure drop
% dp = 1/2 .* rho .* (1 - beta.^4) .* (W ./ (C_d .* Ar)).^2;
dp = 1/rho .* (1 - beta.^4) .* (W ./ (C_d .* Ar)).^2;