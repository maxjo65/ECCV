function P_c = F0011_P_c(W_c, T_us, T_ds, par)
% parameters
cp  = par.Cp_air;

% compressor work
P_c = cp .* W_c .* (T_ds - T_us);
end