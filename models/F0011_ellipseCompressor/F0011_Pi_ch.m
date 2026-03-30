function Pi_ch = F0011_Pi_ch(N_corr_n, par)
% parameters
PI_max = par.PI_max_map;
a1     = par.C_PIch(1);
a2     = par.C_PIch(2);
a3     = par.C_PIch(3);

% Speed ratio
N = N_corr_n;

% output
Pi_ch  = PI_max .* ( a1 + a2.*N.^a3 );
end