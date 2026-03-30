function [cp, cv] = F0004_mixtureMassSpecificHeat(p, par)
% total pressure
p_tot = sum(p);

% mass specific heat capacity
cp_r  = par.cp_r;
cp_v  = par.cp_H2O;
cp_N2 = par.cp_N2;
R_r    = par.R_r;
R_H2O  = par.R_H2O;
R_N2   = par.R_N2;

% partial pressures
p_r  = p(1);
p_v  = p(2);
p_N2 = p(3);

% mole fractions
x_r   = p_r  ./ p_tot;
x_v   = p_v  ./ p_tot;
x_N2  = p_N2 ./ p_tot;

% average mass
M_avg = sum([x_r, x_v, x_N2] .* [par.M_r, par.M_H2O, par.M_N2]);

% mole fraction to mass fraction
w_r   = x_r  .* par.M_r   ./ M_avg;
w_v   = x_v  .* par.M_H2O ./ M_avg;
w_N2  = x_N2 .* par.M_N2  ./ M_avg;

% mixture gas constant
Rm = w_r.*R_r + w_v.*R_H2O + w_N2 .* R_N2;

% ideal mixture heat capacity
cp = w_r.*cp_r + w_v.*cp_v + w_N2 .* cp_N2;
cv = cp - Rm;

end