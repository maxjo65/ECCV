function dp = F0022_expansionValve(W, p_us, T_us, rho_us, T_sat, alpha, par)

% parameters
M  = par.M;
Tc = par.Tc;
D  = par.D;

% constants
R = 8.314472;

% exv geometry
A = alpha .* D.^2 .* pi / 4;

% degree of subcooling
T_sub = max(T_sat - T_us, 0);

% flow coefficient
a  = [ 0.7568; -1.7428; 1.0530; 2.2342; 2.9406;  -8.4168 ];
AA = [ones(size(p_us)), alpha, alpha.^2, alpha .* T_sub/Tc, T_sub/Tc,  (T_sub/Tc).^2 ];
C  = AA * a;

% pressure drop
dp = 1./rho_us .* ( W ./ (C.*A) ).^2;

% pressure drop
% dp = p_us - p_ds;

% flow
% W = C.*A .* sqrt( rho_us .* max(dp,0) );

end