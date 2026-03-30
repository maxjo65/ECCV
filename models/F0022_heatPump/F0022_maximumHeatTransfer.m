function Q_rmax = F0022_maximumHeatTransfer(W_r, h_r, cp_f, cp_g, h_f, h_g, T_sat, T_s)

if T_sat <= T_s
    % Evaporation
    h_fg = max(h_g - h_r, 0);
    
    % superheating
    h_sup = cp_g .* (T_s - T_sat);

    % maximum heat transfer
    Q_rmax = W_r .* (h_fg + h_sup);
else
    % Condensation
    h_fg = max(h_r - h_f, 0);

    % subcooling
    h_sub = cp_f .* (T_sat - T_s);
    
    % maximum heat transfer
    Q_rmax = W_r .* (h_fg + h_sub);
end



