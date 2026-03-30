function T_ds = F0011_T_ds(Pi_c, T_us, eta_c, par)
% model constants
g = par.gamma_air;

% compressor out temperature (adiabatic)
T_ds = T_us + T_us ./ eta_c .* ( Pi_c.^((g-1)/g)  - 1  );
end