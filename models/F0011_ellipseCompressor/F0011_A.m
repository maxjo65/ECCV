function A = F0011_A(N_corr_n, par)
% parameters
u1 = N_corr_n;
u2 = par.C_a(1);
u3 = par.C_a(2);
u4 = par.C_a(3);
u5 = par.Delta_h_max;
u6 = par.Wc_max_map;

% output
A = -( u5./u6 ).*( u2.*u1 ./( (1 + u3.*u1.^2).^u4 ));
end