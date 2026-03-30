function CUR = F0011_CUR(N_corr_n, par)
% parameters
a1     = par.C_cur(1);
a2     = par.C_cur(2);
a3     = par.C_cur(3);

% Speed ratio
N = N_corr_n;

% output
CUR = a1 + a2.*N.^a3;
end