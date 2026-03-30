function [V, Q_gen] = F0003_outputVoltage2(I, p_tot, p_H2, p_O2, p_sat, lambda_m, T, par)
% ref: Control-Oriented Modeling and Analysis for Automotive Fuel Cell Systems
% authors: Jay T. Pukrushpan, Huei Peng, Anna G. Stefanopoulou
% J. Dyn. Sys., Meas., Control. Mar 2004
% https://doi.org/10.1115/1.1648308

% specify output sizes
Q_gen = 0;
V     = 0;

% parameters
A = par.A_fc; % [cm2]       - cell area
j = I ./ A;

% % partial pressures
% p_H2     = p_an(1); % [Pa] - hydrogen partial pressure
% p_O2     = p_ca(2); % [Pa] - oxygen --
% p_H2O_ca = p_ca(3); % [Pa] - water --
% p_N2_ca  = p_ca(4); % [Pa] - nitrogen --

% parameters
c1 = 10;

% constants
R     = 8.314;     % [J/(K mol)] - Gas constant
F     = 96485;     % [C/mol]     - Faradays constant
n     = 2;         % [-]         - moles of electrons transfered per mole hydrogen reacted
E0    = 1.229;     % [V]         - standard potential
P_atm = 1.01325e5; % [Pa]        - atm. pressure
p0    = 1e5;       % [Pa]        - std. pressure
dh    = 285.8e3;   % [J/mol]     - heat of formation (liquid)
% dh    = 241.8e3;   % [J/mol]     - heat of formation (vapor)

% total pressures
% P_an = p_H2 + p_H2O_an + p_N2_an;
P_ca = p_tot;

% reversible voltage
% E = E0 - 8.5e-4 .* (T-298.15) + R*T/(n*F) * log(p_H2./p0 .* sqrt( max(p_O2./p0,0) ));
E = E0 - 8.5e-4 .* (T-298.15) + R*T/(n*F) * log(p_H2./p0 .* sqrt( p_O2./p0 ));


% activation overvoltage
v0 = 0.279 - 8.5e-4 .* (T - 298.15) + 4.3085e-5 .* T .* (log((P_ca/P_atm - p_sat./P_atm)/1.01325) + 1/2 * log(0.1173*(P_ca/P_atm - p_sat./P_atm)/1.01325));
va = (-1.618e-5 * T + 1.618e-2) .* ( p_O2./P_atm./0.1173 + p_sat./P_atm ).^2 + (1.8e-4 * T - 0.166).*(p_O2./ P_atm/0.1173 + p_sat./P_atm) + (-5.8e-4 * T + 0.5736);
V_act = v0 + va.*(1 - exp(-c1.*j));

% ohmic overvoltage
b11     = 0.005139;
b12     = 0.00326;
b2      = 350;
t_m     = 0.01275;
sigma_m = (b11 .* max(lambda_m,1) - b12) .* exp( b2 .*( 1./303 - 1./T ) );
R_ohm   = t_m ./ sigma_m;
V_ohm   = j .* R_ohm;

% concentration overvoltage
temp         = (p_O2./P_atm./0.1173 + p_sat./P_atm);
c2           = (8.66e-5 .* T - 0.068) .* temp + ( -1.60e-4 * T + 0.54);
% c2(temp < 2) = (7.16e-4 .* T - 0.622) .* temp + ( -1.45e-3 * T + 1.68);
c3           = 2;
j_max        = 2.2;
V_con        = j .* (c2 .* j/j_max).^c3;

% Output voltage
% V = E  - V_act - V_ohm - V_con;
V = E  - V_act - V_ohm - V_con;

% Heat generation
P_elec = j.*A .* V;              % [W] - electric power
P_tot  = j .*A ./ (2*F) .* dh;   % [W] - total power
Q_gen  = P_tot - P_elec;         % [W] - heat generation






