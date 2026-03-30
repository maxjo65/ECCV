function W_ZSL = F0011_W_ZSL(N_corr_n, par)
% parameters
Wc_max = par.Wc_max_map;
a1     = par.C_Wzs(1);
a2     = par.C_Wzs(2);

% Speed ratio
N = N_corr_n;

% output
W_ZSL = Wc_max .* a1 .* N.^a2;
end