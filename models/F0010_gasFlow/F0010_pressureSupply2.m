function [p_H2, p_O2, p_H2O, p_N2] = F0010_pressureSupply2(p_tot, x_H2_dry, x_O2_dry, RH, p_sat, par)

% mole fraction of vapor
x_H2O = RH .* p_sat ./ p_tot;

% mole fraction hydrogen
x_H2 = (1-x_H2O).*x_H2_dry;

% mole fraction hydrogen
x_O2 = (1-x_H2O).*x_O2_dry;

% mole fraction nitrogen
x_N2 = 1 - x_H2 - x_O2 - x_H2O;

% output
p_H2  = x_H2  .* p_tot;
p_O2  = x_O2  .* p_tot;
p_H2O = x_H2O .* p_tot;
p_N2  = x_N2  .* p_tot;

end