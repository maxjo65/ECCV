function h = F0022_OSFPHEX(G, x, rho_f, rho_g, cp_f, cp_g, mu_f, mu_g, k_f, k_g, sigma, par)

% parameters
D_h = par.D_h;

% output size
h = zeros(size(x));

% Bond number
g   = 9.81;
B_d = g .* (rho_f - rho_g) .* D_h.^2 ./ sigma;

% liquid & gas Prandtl number
Pr_f = cp_f .* mu_f ./ k_f;
Pr_g = cp_g .* mu_g ./ k_g;

% minimum mass flux
G = max(G, 1);

% refrigerant side heat transfer coefficient
G_eq  = G .* ( (1-x) + (rho_f./rho_g).^0.5 .* x );
Re_f  = G    .* D_h ./ mu_f;
Re_g  = G    .* D_h ./ mu_g;
Re_eq = G_eq .* D_h ./ mu_f;
Nu    = 3.918 .* Re_eq.^0.505 .* Re_f.^(-0.1354) .* B_d.^0.213 .* Pr_f.^(1/3);
h_tp     = Nu .* k_f ./ D_h;

% single phase correlation
h_f = 0.494 .* G .* cp_f .* Re_f.^(-0.426) .* Pr_f.^(-2/3);
h_g = 0.494 .* G .* cp_g .* Re_g.^(-0.426) .* Pr_g.^(-2/3);

% smooth transition to subcooled liquid & superheated vapor
y = (x-0.1) / 0.1;
y = tanh(y*5)/2 + 1/2;
z =  (x-0.90) / 0.1;
z = tanh(z*5)/2 + 1/2;

h = h_tp .* y .* (1-z) + h_f .* (1-y) + h_g .* z;

% output
% h       = h_tp;
% h(x==0) = h_f(x==0);
% h(x==1) = h_g(x==1);



end