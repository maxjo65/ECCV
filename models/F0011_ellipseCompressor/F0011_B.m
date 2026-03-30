function B = F0011_B(N_corr_n, par)
% parameters
u1 = N_corr_n;
u2 = par.C_b(1);
u3 = par.C_b(2);
u4 = par.Delta_h_max;

% output
B = u4 .* ( u2 .* u1.^2 + u3 .* u1.^3 );
end