function PI_ZSL = F0011_PI_ZSL(N_corr_n, par)
% parameters
PI_max = par.PI_max_map;
a1     = par.C_PIzs(1);
a2     = par.C_PIzs(2);

% Speed ratio
N = N_corr_n;

% output
PI_ZSL  = 1 + (PI_max - 1) .* ( a1.*N.^a2 );
end