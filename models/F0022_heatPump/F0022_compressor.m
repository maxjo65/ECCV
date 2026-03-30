function [m_dot, P_cmp, h_2]  = F0022_compressor(p_1, rho_1, h_1, p_2, N, k, par)
% model from Li 2013

% parameters
V_disp = par.V_disp; 
N_ref  = par.N_ref / 60;
M      = par.M;

% M = 0.1140415928; % [kg/mol]  compressor displacement
% V_disp = 0.00017; % [m3]   compressor displacement
% N_ref = 2000 / 60; % [rps]  reference speed

% suction properties
p_s   = p_1;
rho_s = rho_1 * 0.9;
h_s   = h_1;

% discharge properties
p_d = p_2;

% compressor parameters
b1    = 0.799;
b2    = -0.036;
a1    = 1.140;
a2    = 0.295;
a3    = 447.050;
Wloss = 350.000 * 2;
d1    = 1.223;
d2    = -0.206;
d3    = -0.017;
e1    = 0.507;
e2    = 0.606;
e3    = -0.113;

% reference volumetric efficieny
nv_ref = b1 + b2 .* (  (p_d./p_s ).^(1./k) );

% reference volume flow
dV_ref = nv_ref .* N_ref .* V_disp;

% reference compressor power
P_ref = p_s .* dV_ref .* a1 .* ( (p_d./p_s).^(a2 + (k-1)./k) + a3./p_d ) + Wloss; 

% volumetric efficiency ratio
nv = d1 + d2 .* (N./N_ref) + d3 .* (N./N_ref).^2;

% isentropic efficiency ratio
ni = e1 + e2 .* (N./N_ref) + e3 .* (N./N_ref).^2; 

% Compressor suction volume flow
dV_suc = dV_ref .* (N./N_ref) .* nv;
m_dot  = dV_suc  .* rho_s .* M;

% Compressor power
P_cmp = P_ref .* dV_suc ./ dV_ref .* ni;

% discharge enthalpy
h_d = M.* P_cmp ./ (m_dot + 1e-5) + h_s;
h_2 = h_d;

end





