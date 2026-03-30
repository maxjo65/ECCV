function Fa = F0006_airDrag(v, par)
% inputs:
% v [m/s] - vehicle speed

% parameters:
rho_air = par.rho_air;
A_f     = par.A_f; % 10;
C_d     = par.C_d; % 0.5;

% output:
Fa = 1/2 * rho_air .* A_f .* C_d .* v.^2;
end