function W_ch_atan = F0011_W_ch_atan(N_corr_n, par)
% parameters
Wc_max = par.Wc_max_map;
a1     = par.C_Wch(1);
a2     = par.C_Wch(2);
a3     = par.C_Wch(3);
a4     = par.C_Wch(4);

% Speed ratio
N = N_corr_n;

% output
W_ch_atan = Wc_max .* (a1 + a2 .* atan( a3.*N - a4));
end