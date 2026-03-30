function W_split = F0010_multicomponentFlow(p_us, W_tot, par)
% Parameters
cp_j = par.cp_j; % [J/kgK]  - Specific heats
M_j  = par.M_j;  % [kg/mol] - Molar masses
R_j  = par.R_j;  % [J/kgK]  - Specific gas constant

% Mole fractions
p_tot = sum(p_us);
x     = p_us ./ p_tot;

% Average molar mass
M_avg = sum(x .* M_j);

% Mole fraction to mass fraction
w = x .* M_j ./ M_avg;

% outlet species convective mass flow
W_split = W_tot .* w;

end