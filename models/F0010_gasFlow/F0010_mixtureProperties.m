function [x, cp_m, cv_m, R_m] = F0010_mixtureProperties(p, par)
% Parameters
cp_j = par.cp_j; % [J/kgK]  - Specific heats
M_j  = par.M_j;  % [kg/mol] - Molar masses
R_j  = par.R_j;  % [J/kgK]  - Specific gas constant

% Mole fractions
p_tot = sum(p);
x     = p ./ p_tot;

% Average molar mass
M_avg = sum(x .* M_j);

% Mole fraction to mass fraction
w = x .* M_j ./ M_avg;

% Mixture gas constant
R_m = sum(w .* R_j);

% Mixture specific heats
cp_m = sum(w .* cp_j);
cv_m = cp_m - R_m;

end