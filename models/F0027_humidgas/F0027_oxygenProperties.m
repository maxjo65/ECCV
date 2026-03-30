function [cp, mu, lam] = oxygen_properties(p_O2, T)

% Oxygen parameters
Tc   = 154.581;  % K
rhoc = 13.63;  % mol / dm3
M    = 31.9988; % g / mol
ek   = 118.5;    % -
sig  = 0.3428;   % nm

% partial density
R   = 8.314;
rho = 31.9988e-3 .* p_O2 ./ (R .* T);

% ideal gas heat capacity
N   = [1.06778 3.50042 0.166961e-7 1.01258 0.944365 2242.45 11580.4];
eta = N(7) ./ T;
u   = N(6) ./ T;
cp  = 1./(31.9988e-3) .* R .* ( ...
    N(1) .* T^-1.5 + ...
    N(2) + ...
    N(3) .* T.^2 + ...
    N(4) .* u.^2 .* exp(u)./(exp(u) - 1).^2 + ...
    N(5) .* 2/3 .* eta.^2 .* exp(-eta) ./ (1 + 2/3 .* exp(-eta) ).^2 ...
    );

% change units on density from kg / m3 --> mol / dm3
rho = 1e-3 .* rho ./ (M * 1e-3);

% reduced temperature and density
tau =  Tc ./ T;
del = rho ./ rhoc;

% dilute gas contributoin
Ts    = T ./ ek;
b     = [0.431, -0.4623, 0.08406, 0.005341, -0.00331];
Omega = exp( sum( b .* log(Ts).^(0:4), 2) );
mu0   = 0.0266958 .* sqrt(M .* T) ./ (sig.^2 .* Omega );

% residual contribution
N = [17.67, 0.4042, 0.0001077, 0.3510, -13.67];
t = [0.05 0.0 2.10 0.0 0.5];
d = [1 5 12 8 1];
l = [0 0 0 1 2];
g = [0 0 0 1 1];
mur = sum( N .* tau.^t .* del.^d .* exp( -g .* del.^l), 2);

% viscosity
mu = 1e-6 .* ( mu0 + mur );

% dilute gas thermal conductivity
N = [1.036 6.283 -4.262];
t = [0 -0.9 -0.6];
lam0 = N(1) .* mu0 + N(2) .* tau.^t(2) + N(3) .* tau.^t(3);

% residual contribution
N = [15.31 8.898 -0.7336 6.728 -4.374 -0.4747];
t = [0.0 0.0 0.3 4.3 0.5 1.8];
d = [1 3 4 5 7 10];
l = [0 0 0 2 2 2];
g = [0 0 0 1 1 1];
lamr = sum( N .* tau.^t .* del.^d .* exp( -g .* del.^l ), 2);

% thermal conductivity
lam = 1e-3 .* ( lam0 + lamr );

end