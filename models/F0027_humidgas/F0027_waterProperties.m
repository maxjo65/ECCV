function [cp, mu, lam] = water_properties(p_H2O, T)

% reference constants
T_ref   = 647.096;
rho_ref = 322.0;
p_ref   = 22.064e6;
mu_ref  = 1e-6;
lam_ref = 1e-3;

% partial density
R   = 8.314;
rho = 18.015e-3 .* p_H2O ./ (R .* T);

% ideal gas heat capacity
% n1 = -8.32044648201;
% n2 = 6.6832105268;
n3 = 3.00632;
n   = [0.012436 0.97315 1.27950 0.96956 0.24873];
g   = [1.28728967 3.53734222 7.74073708 9.24437796 27.5075105];
tau = T_ref ./ T;
cp = 1./18.015e-3 .* R .* ( ...
    1 + n3 + sum( ...
    n .* (g .* tau).^2 .* exp(-g .* tau) ./ (1 - exp(-g .* tau)).^2 ) );

% coefficients for zero density viscosity
H0 = [1.67752, 2.20462, 0.6366564, -0.241605];

% zero density limit viscosity
mu0 = 100 .* sqrt(T./T_ref) ./ sum( H0 ./ (T/T_ref).^(0:3) , 2);

% coefficients or the residual term
H1 = [5.20094e-1, 8.50895e-2, -1.08374, -2.89555e-1, 2.22531e-1, 9.99115e-1, 1.88797, 1.26613, ...
        1.20573e-1, -2.81378e-1, -9.06851e-1, -7.72479e-1, -4.89837e-1, -2.57040e-1, 1.61913e-1, ...
            2.57399e-1, -3.25372e-2, 6.98452e-2, 8.72102e-3, -4.35673e-3, -5.93264e-4];

% exponents
i = [0 1 2 3 0 1 2 3 5 0 1 2 3 4 0 1 0 3 4 3 5];
j = [0 0 0 0 1 1 1 1 1 2 2 2 2 2 3 3 4 4 5 6 6];

% residual viscosity (due to increasing density)
mu1 = exp( rho./rho_ref .* sum( (1./(T./T_ref) - 1 ).^i .* H1 .* (rho./rho_ref - 1).^j, 2));

% dynamic viscosity (excluding critical region)
mu = mu_ref .* mu0 .* mu1;

% normalized variables
tau(1,1,:) = T   ./ T_ref;
del(1,1,:) = rho ./ rho_ref; 

% zero-density conductivity
L    = [2.443221e-3, 1.323095e-2, 6.770357e-3, -3.454586e-3, 4.096266e-4];
lam0 = sqrt(tau) ./ sum( L ./ tau.^(0:4), 2);

% residual parameters
L0 = [1.60397357 -0.646013523 0.111443906 0.102997357 -0.0504123634 0.00609859258];
L1 = [2.33771842 -2.78843778 1.53616167 -0.463045512 0.0832827019 -0.00719201245];
L2 = [2.19650529 -4.54580785  3.55777244 -1.40944978 0.275418278 -0.0205938816];
L3 = [-1.21051378 1.60812989 -0.621178141 0.0716373224 0 0 ];
L4 = [-2.7203370 4.57586331 -3.18369245 1.1168348 -0.19268305 0.012913842];
L = [L0; L1; L2; L3; L4];

% summation terms
tmp = del .* (1./tau - 1).^((0:4)') .* L .* (del-1).^(0:5);

% lam1      = ones(length(T),1);
lam1 = exp( sum(sum(tmp) ) );

% thermal conductivity
lam = lam_ref .* lam0 .* lam1;

end