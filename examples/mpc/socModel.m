function [dx, g] = socModel(x, u)

% states
SOC = x(1);

% controls
I_fc = u(2);

% fuel cell model
n_c         = 375 * 2;
par.A_fc    = 500; % cell area [cm2]
PI          = 2;
p_tot       = PI .* 1.010315e5;
T_fc        = 273.15 + 80;
RH          = 0.8;
p_sat       = F0010_vaporSaturationPressure(T_fc);
[p_H2, ~, p_H2O, ~] = F0010_pressureSupply2(p_tot,  1, 0.00, RH, p_sat, par);
[~, p_O2,     ~, ~] = F0010_pressureSupply2(p_tot,  0, 0.21, RH, p_sat, par);
a                   = F0003_vaporActivity(p_H2O, p_sat);
lambda_m            = F0003_waterContent(a);
[V_fc, ~] = F0003_outputVoltage2(I_fc, p_tot, p_H2, p_O2, p_sat, lambda_m, T_fc, par);
P_fc      = V_fc .* I_fc .* n_c .* 0.99;

% battery cell power
n_p      = 120; % cells in parallel 
n_s      = 180; % cells in series
P_b      = P_fc - P_em;
P_b_cell = P_b ./ (n_p .* n_c);

% battery cell current
U        = F0001_ocvSOC(SOC);
R        = 0.0358;
a        = R;
b        = -U ./ R;
c        = P_b_cell./R;
I_b_cell = (-b - sqrt(b.^2 - 4 .* a .* c) ) ./ (2.*a);
V_b_cell = U - I_b_cell .* R;

% pack current & voltage
I_b = I_b_cell .* n_p;
V_b = V_b_cell .* n_s;

% state of charge
T_b  = 273.15 + 25;
Q0   = F0001_cellCapacity(T_b);
dSOC = -1./ (3.6e3 .* Q0) .* I_b_cell;

% state
dx = dSOC;

% constraints
g(1) =  I_b;
g(2) = -I_b;




