function dp = F0014_radiatorAirPressureDrop(v, par)
% parameters
CdT   = par.CdT;
c_dp  = par.c_dp_air;
rho   = par.rho_air;

% pressure drop
dp = CdT .* rho .* ( c_dp(1) .* v.^2 + c_dp(2) .* v );

