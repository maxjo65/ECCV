function W_corr_surge = F0011_linearSurgeFlow(W_ZSL, Pi_ZSL, Pi_c, par)
% Surge flow
W_corr_surge = W_ZSL - (Pi_c - Pi_ZSL)./par.alpha_kPiW0;

% Saturation
W_corr_surge(W_corr_surge < 1e-4) = 1e-4;
end