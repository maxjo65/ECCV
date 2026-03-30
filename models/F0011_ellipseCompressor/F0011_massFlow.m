function W_c = F0011_massFlow(p_1, p_2, T_1, w_c, par)
% pressure ratio
Pi_c = p_2 ./ p_1;

% speed correction
[~, N_corr_n] = F0011_speedCorrection(w_c, T_1, par);

% base functions
Pi_ch  = F0011_Pi_ch(N_corr_n, par);
PI_ZSL = F0011_PI_ZSL(N_corr_n, par);
CUR    = F0011_CUR(N_corr_n, par);
W_ZSL  = F0011_W_ZSL(N_corr_n, par);
W_ch   = F0011_W_ch_atan(N_corr_n, par);

% corrected flow
W_corr = F0011_ellipseModel(Pi_c, Pi_ch, PI_ZSL, CUR, W_ZSL, W_ch, par);

% Uncorrect
W_c = W_corr .* (p_1./par.p_ref) ./ sqrt( T_1./par.T_ref);

end