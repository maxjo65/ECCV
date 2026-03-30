function m = F0004_pressureToMass(p, T, par)
% gas constants
R_r    = par.R_r;
R_H2O  = par.R_H2O;
R_N2   = par.R_N2;
Rj     = [R_r; R_H2O; R_N2];
V      = par.V;

% mass
m = p .* V ./ (Rj .* T);
end