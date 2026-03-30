function dh_is = F0011_dh_is(Pi_c, par)
% inputs
u1 = Pi_c;

% parameters
cp_air = par.Cp_air;
T_ref  = par.T_ref;
g      = par.gamma_air;

% isentropic enthalpy change
dh_is = cp_air .* T_ref .* ( u1.^((g - 1)./g) - 1 );
end