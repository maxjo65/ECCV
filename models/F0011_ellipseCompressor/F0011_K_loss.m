function K_loss = F0011_K_loss(W_corr, N_corr, par)
% parameters
rho1   = par.rho1;
D      = par.D_2;
C_loss = par.C_loss;

% output
K_loss = 1 + C_loss .* ( rho1.*D.^3 .* pi/60 ) .* (N_corr./W_corr);
end