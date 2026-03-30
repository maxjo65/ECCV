function h = F0022_coolantSideHTC(G, cp, mu, lam, par)

G = max(1,G);

% hydraulic diameter
D_h = par.D_h;

% Reynolds number
Re = G .* D_h ./ mu;

% Prandtl number
Pr = cp .* mu ./ lam;

% HTC
h = 0.494 .* G .* cp .* Re.^(-0.426) .* Pr.^(-2/3);

end

