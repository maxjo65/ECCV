function W_corr = F0011_ellipseModel(Pi_c, Pi_ch, PI_ZSL, CUR, W_ZSL, W_ch, par)
% inputs
u1 = min(Pi_c, PI_ZSL);
u2 = Pi_ch;
u3 = PI_ZSL;
u4 = CUR;
u5 = W_ZSL;
u6 = W_ch;


% inputs
u1 = min(Pi_c, PI_ZSL);
u2 = Pi_ch;
u3 = PI_ZSL;
u4 = CUR;
u5 = W_ZSL;
u6 = W_ch;

% Surge / Regular / Choke
if (Pi_c >  PI_ZSL)
    W_corr = W_ZSL - (Pi_c - PI_ZSL)./par.alpha_kPiW0;
elseif (Pi_c < Pi_ch)
    W_corr = W_ch;
else
    W_corr = u5 + (u6-u5).*( (1 - ( (u1-u2)./(u3-u2) ).^u4).^(1./u4) );
end