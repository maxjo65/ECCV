function W = F0010_compressibleRestriction(p_us, p_ds, T_us, cp_m, R_m, A_t, par)
W = 0;

% parameters
C_d    = par.C_d;        % [?]      - discharge coefficient

Pi_lin = par.Pi_lin;

% Ratio of specific heats
g = cp_m/(cp_m - R_m);

% Pressure ratio
pr = p_ds ./ p_us;

% Flow
pr_crit = (2/(1+g)).^( g/(g-1) );
Pi      = max(pr, pr_crit);
Pi      = min(Pi,1);
Phi     = sqrt( 2*g./(g-1) .* ( Pi.^(2/g) - Pi.^((g+1)/g)) );
Phi_lin = sqrt( 2*g./(g-1) .* ( Pi_lin.^(2/g) - Pi_lin.^((g+1)/g)) );
Phi(Pi > Pi_lin) = Phi_lin .* (1-Pi)./(1-Pi_lin);
W       = p_us ./ sqrt(R_m.*T_us) .* A_t .* C_d .* Phi;

















