function W = F0010_linearRestriction(p_us,  p_ds,  par)
% parameters
C_d = par.C_d;   % [?]    - Convective flow coefficient

% Pressure & temperature drop
dp = p_us - p_ds;

% linear flow
W = C_d .* max(dp,0) ;

end







