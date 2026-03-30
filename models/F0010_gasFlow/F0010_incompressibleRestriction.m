function W = F0010_incompressibleRestriction(p_1, T_1,  p_2, T_2, par)
% output size
W = zeros(4,1);

% parameters
C_d = par.C_d;   % [?]      - Convective flow coefficient
D_t = par.D_t;        % [m]   - Nozzle throat diameter
A_t = pi*(D_t/2)^2;   % [m2]  - Nozzle throat area
M_j = par.M_j; % [kg/mol] - Molar masses
R_j = par.R_j; % [J/kgK]  - Specific gas constants

% Upstream & downstream total pressure
p_1_tot  = sum(p_1);
p_2_tot  = sum(p_2);

% Pressure & temperature drop
dp = p_1_tot - p_2_tot;

dp_tan = dp.*par.tan_par;

% Switch variable
y = (tanh(dp_tan) + 1)/2;

% Upstream pressure, temperature & concentration
p_us = y.*p_1 + (1-y).*p_2;
T_us = y.*T_1 + (1-y).*T_2;

% Upstream total pressure
p_tot = sum(p_us);

% Upstream mole fractions
x_us = p_us ./ p_tot;

% Average molar mass
M_avg = sum(x_us .* M_j);

% Mole fraction to mass fraction
w_us = x_us .* M_j ./ M_avg;

% mixture gas constant
R_m = sum(w_us .* R_j);

% Total mass flow
W_c = C_d .* A_t .* sqrt(p_tot./(R_m.*T_us)).*sqrt(abs(dp));
W_c = tanh(dp_tan) .* W_c;

% linear region
dp_lin  = par.dp_lin;
W_c_lin = C_d .* A_t .* sqrt(p_tot./(R_m.*T_us)) .* abs(dp) ./ sqrt(dp_lin);
W_c(abs(dp) < dp_lin) = tanh(dp_tan) .* W_c_lin;

% Distribute mass flow accoring to mass ratios
W   = W_c .* w_us;
end












