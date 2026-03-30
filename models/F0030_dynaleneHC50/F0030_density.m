function rho = F0030_density(T)

% parameters
x = [1502.1; -0.55464];

% density
rho = x(1) + x(2) .* T;

end