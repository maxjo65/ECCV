function T_ds = F0007_compressorTemperature(p_us, p_ds, T_us, eta_c)

% model constants
g = 1.4;

% pressure ratio
PiC = p_ds./p_us;

% compressor out temperature (adiabatic)
T_ds = T_us + T_us ./ eta_c .* ( PiC.^((g-1)/g)  - 1  );

end