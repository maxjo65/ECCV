function m = F0010_pressureToMass(p, T, par)
% parameters
Rj     = par.R_j;
V      = par.V;

% mass
m = p .* V ./ (Rj .* T);
end