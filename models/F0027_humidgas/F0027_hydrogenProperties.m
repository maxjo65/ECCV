function [cp, mu, lam] = hydrogen_properties(p_H2, T)

% parameters
Tc   = 33.145;
rhoc = 31.262;
sig  = 0.297;
ek   = 30.41;
M    = 2.01588;

% partial density
R   = 8.314;
rho = 2.016e-3 .* p_H2 ./ (R .* T);

% ideal gas heat capacity
u  = [1.616 -0.4117 -0.792 0.758 1.217]';
v  = [531 751 1989 2484 6859]';
cp = 1./(2.01568e-3) .* R .* ( 2.5 + ... 
    sum( u .* (v./T).^2 .* exp(v ./ T) ./ ( exp(v./T) - 1).^2 ));

% zero density limit viscosity
a   = [2.09630e-1, -4.55274e-1, 1.43602e-1, -3.35325e-2, 2.76981e-3];
S   = exp( sum( a .* log(T ./ ek).^(0:4), 2) );
mu0 = 0.021357 .* (M .* T).^0.5 ./ ( sig.^2 .* S );

% excess contribution density coefficient
NA  = 6.02214129e23;
b   = [-0.1870, 2.4871, 3.7151, -11.0972, 9.0965, -3.8292, 0.5166];
B   = NA .* (sig .* 1e-9).^3 .* sum( b .* (T./ek).^(0:-1:-6), 2);
mu1 = B .* mu0 ./ (M .* 1e-3);

% excess contribution intercept
Tr    = T ./ Tc;
rhor  = rho./ 90.909090909; 
c     = [6.43449673, 4.56334068e-2, 2.32797868e-1, 9.58326120e-1, 1.27941189e-1, 3.63576595e-1];
dmuh  = c(1) .* rhor.^2 .* exp( c(2) .* Tr + ...
    c(3)./Tr + ...
    c(4) .* rhor.^2 ./ (c(5) + Tr) + c(6) .* rhor.^6 );

% viscosity
mu = 1e-6 .* (mu0 + mu1 .* rho + dmuh);

% zero density limit
A1   = [-3.40976e-1,  4.58820e0, -1.45080e0, 3.26394e-1, 3.16939e-3, 1.90592e-4, -1.13900e-6];
A2   = [  1.38497e2, -2.21878e1,   4.57151e0, 1.00e0 ];
lam0 = sum(A1 .* (T./Tc).^(0:6), 2) ./ sum( A2 .* (T./Tc).^(0:3), 2);

% excess contribution
B1 = [ 3.63081e-2, -2.07629e-2, 3.14819e-2, -1.43097e-2, 1.74980e-3 ];
B2 = [ 1.83370e-3, -8.86716e-3, 1.58260e-2, -1.06283e-2, 2.80673e-3 ];
dlam = sum( (B1 + B2 .* (T./Tc) ) .* (rho./rhoc).^(1:5) , 2);

% thermal conductivity;
lam = lam0 + dlam;

end




