function X_tt = F0022_LockhartMartinelliParameter(x, rho_g, rho_f, mu_g, mu_f)

% Lockhart-Martinelly Parameter (nuclear-power.com)
X_tt = ((1-x)./x).^0.9 .* (rho_g ./ rho_f).^0.5 .* (mu_f ./ mu_g ).^0.1;


end