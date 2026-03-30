function e = F0022_homogeneousVoidFraction(x, rho_liq, rho_vap)

% from Engineering Data Book II, Wolverine Tube Inc.

e = 1 ./ ( 1 + (1-x)./x .* rho_vap ./ rho_liq );


end