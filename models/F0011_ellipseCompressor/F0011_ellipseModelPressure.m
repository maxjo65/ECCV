function Pi_c = F0011_ellipseModelPressure(W_corr, Pi_ch, PI_ZSL, CUR, W_ZSL, W_ch, par)

% inputs
W_corr = min(W_corr, W_ch);
W_corr = max(W_corr, W_ZSL);

% Surge / Regular / Choke
if (W_corr <  W_ZSL)
    Pi_c = PI_ZSL;
elseif (W_corr > W_ch)
    Pi_c = Pi_ch;
else
    Pi_c   = Pi_ch + ...
    (PI_ZSL - Pi_ch) .* ... 
    (1 - ((W_corr - W_ZSL)./(W_ch - W_ZSL)).^CUR ).^(1./CUR);
end