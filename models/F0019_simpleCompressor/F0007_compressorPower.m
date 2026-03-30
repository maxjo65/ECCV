function P_c = F0007_compressorPower(W_c, T_us, T_ds)

% model constants
g   = 1.4;
R   = 280;
cp  = g*R/(g-1);

% compressor work
P_c = cp .* W_c .* (T_ds - T_us);

end