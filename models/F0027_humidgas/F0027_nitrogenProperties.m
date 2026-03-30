function [cp, mu,lam] = nitrogen_properties(p_N2, T)

% Nitrogen parameters
Tc   = 126.192;  % K
rhoc = 11.1839;  % mol / dm3
pc   = 3.3958;   % MPa
M    = 28.01348; % g / mol
ek   = 98.94;    % -
sig  = 0.3656;   % nm

% partial density
R   = 8.314;
rho = 28.01348e-3 .* p_N2 ./ (R .* T);

% ideal gas heat capacity
u  = 3364.011./T;
a  = [3.5 3.066469e-6 4.701240e-9 -3.987984e-13 1.012941]';
cp = 1./28.01348e-3 .* R .* ( ...
    a(1) + a(2) .* T + a(3) .* T.^2 + a(4) .* T.^3 + ...
    a(5) .* u.^2 .* exp(u) ./ (exp(u) - 1).^2 );

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
N = [10.72, 0.03989, 0.001208, -7.402, 4.620];
t = [0.1, 0.25, 3.2, 0.9, 0.3];
d = [2, 10, 12, 2, 1];
l = [0, 1, 1, 2, 3];
g = [0, 1, 1, 1, 1];
mur = sum( N .* tau.^t .* del.^d .* exp( -g .* del.^l), 2);

% viscosity
mu = 1e-6 .* ( mu0 + mur );

% dilute gas thermal conductivity
N = [1.511 2.117 -3.332];
t = [0 -1.0 -0.7];
lam0 = N(1) .* mu0 + N(2) .* tau.^t(2) + N(3) .* tau.^t(3);

% residual contribution
N = [8.862 31.11 -73.13 20.03 -0.7096 0.2672];
t = [0 0.03 0.2 0.8 0.6 1.9];
d = [1    2   3   4   8  10];
l = [0 0 1 2 2 2];
g = [0 0 1 1 1 1];
lamr = sum( N .* tau.^t .* del.^d .* exp( -g .* del.^l ), 2);

% thermal conductivity
lam = 1e-3 .* ( lam0 + lamr );

end