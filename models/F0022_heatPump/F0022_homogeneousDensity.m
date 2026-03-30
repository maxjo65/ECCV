function rho_H = F0022_homogeneousDensity(x, rho_f, rho_g)

% thermopedia.com /cn/content/37/
rho_h = rho_f .* rho_g ./ ( x.* rho_f + (1-x) .* rho_g );

end