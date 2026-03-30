function [dx, g] = vehicleModel(x, u, d, gear)

% states
v   = x(1);
SOC = x(2);

% controls
Tq_ref = u(1);
I_fc   = u(2);
P_bf   = u(3) * 1e3;

% measured disturbance
alpha  = d(1);

% chassis parameters
par = struct;
par.m       = 40e3;
par.r_w     = 0.5;
par.A_f     = 10;
par.C_d     = 0.5;
par.rho_air = 1.225;
par.c_r0    = 0.0060;
par.c_r1    = 2.3e-7;

% gearbox parameters
par.fd_ratio    = 2;
par.gear_ratios = [5 3.8 2.3 1.15];
par.eta_gb      = 0.98;

% motor parameters
n_em   = 3;
w0     = 64;
Tq0    = 1991;

% em speed & torque
w_w          = v ./ par.r_w;
gear_ratio   = par.gear_ratios(gear);
w_em         = w_w .* par.fd_ratio .* gear_ratio;

% em torque
y      = (tanh( (w_em - w0) ) + 1) / 2;
Tq_max = Tq0 .* (1 - y) + ...
    y .* (-2.9265e3  + 2.8775e3 .* exp( 0.0348e3 ./ w_em ));
Tq_em  = Tq_ref .* Tq_max; 

% combined drive ratio
gam  = par.fd_ratio .* gear_ratio;
y = (tanh(Tq_em / 10));
Tq_w = n_em .* Tq_em .* gam .* par.eta_gb .^ y;

% driving resistances
Fa = F0006_airDrag(v, par);
Fr = F0006_rollingResistance(v, alpha, par);
Fg = F0006_gravitationalForce(alpha, par);

% tractive force
Ft = Tq_w ./ par.r_w;

% velocity state
dv = 1./par.m .* (Ft - Fa - Fr - Fg);

% approximate motor power draw
P_em = n_em .* Tq_em .* w_em;

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
n_p      = 60; % cells in parallel 
n_s      = 180; % cells in series
P_b_cell = (P_em - P_fc + P_bf)./ (n_p .* n_s);

% battery cell current
U   = F0001_ocvSOC(SOC);
R   = 0.0358;
a   = R;
b   = -U ./ R;
c   = P_b_cell./R;
I_b_cell = (-b - sqrt(b.^2 - 4 .* a .* c) ) ./ (2.*a);

% state of charge
T_b      = 273.15 + 25;
Q0       = F0001_cellCapacity(T_b);
dSOC     = -1./ (3.6e3 .* Q0) .* I_b_cell;

% output
dx = [dv; dSOC];

% constraints
g(1) = I_b_cell;
