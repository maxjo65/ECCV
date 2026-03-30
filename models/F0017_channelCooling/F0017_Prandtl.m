function Pr = F0017_Prandtl(cp, mu, lam, par)

% Prandtl number
Pr = cp .* mu ./ lam;