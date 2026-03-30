function W_corr = F0011_flowCorrection(W_c, p1, T1,  par)

% corrected flow
W_corr = W_c .* sqrt( T1./par.T_ref) ./ (p1./par.p_ref);

end