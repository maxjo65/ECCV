function dp = F0022_smoothTubePressureDrop(W, x, rho_f, rho_g, mu_f, mu_g, sigma, par)

% parameters
D = par.D;
L = par.L;

% gravitation
g = 9.82;

% minimum mass flux
W = max(W, 1e-4);

% mass flux
G_tp = 4.*W ./ (pi.*D.^2);

% liquid-only friction factor
Re_lo = G_tp .* D ./ mu_f;
f_lo  = 0.25 .* ( log10(  150.39 ./ (Re_lo.^0.98865) - 152.66./(Re_lo)  ) ).^(-2);

% gas-only friction factor
Re_go = G_tp .* D ./ mu_g;
f_go  = 0.25 .* ( log10(  150.39 ./ (Re_go.^0.98865) - 152.66./(Re_go)  ) ).^(-2);

% Laplace constant
La = sqrt( sigma ./ (g.*(rho_f - rho_g) ) ) ./ D;

% liquid-only pressure gradient
dp_dz_lo = G_tp.^2 ./(2.*D.*rho_f) .* f_lo;

% gas-only pressure gradient
dp_dz_go = G_tp.^2 ./(2.*D.*rho_g) .* f_go;

% two phase multiplier
Y       = sqrt(dp_dz_go ./ dp_dz_lo);
phi2_lo = (Y.^2 .* x.^3 + (1-x).^(1/3) .* (1+2.*x.*(Y.^2 -1)) ) .* ...
    (1 + 1.54 .*(1-x).^0.5 .* La.^1.47); 

% two-phase pressure gradient
dp_dz_tp = dp_dz_lo .* phi2_lo; 

% pressure drop
dp = dp_dz_tp .* L;

end