function h = F0022_louverFinHTC(u, par)

% HEX Geometry
% L_a = 23;       % Louver angle [degrees]
% F_p = 1.4e-3;   % Fin pitch [m]
% L_p = 1.7e-3;   % Louver pitch [m]
% L_l = 6.4e-3;   % Louver length [m]
% H   = 8.15e-3;  % Fin height [m]
% T_p = 10.15e-3; % Tube pitch [m]
% T_d = 16e-3;    % Tube depth [m]
% d_f = 0.1e-3;   % Fin thickness [m]
% F_d = 16e-3;    % flow depth

% contraction ratio
sigma = par.sigma;

% Air properties
cp  = par.cp_air;
v   = par.v_air;
rho = par.rho_air;

% HEX Geometry parameters
L_a  = par.L_a;  % Louver angle [deg]
F_p  = par.F_p;  % Fin pitch [m]
L_p  = par.L_p;  % Louver pitch [m]
L_l  = par.L_l;  % Louver length [m]
H    = par.H;    % Fin height [m]
T_p  = par.T_p;  % Tube pitch [m]
% T_d  = par.T_d;  % Tube depth [m]
d_f  = par.d_f;  % Fin thickness [m]
F_d  = par.F_d;  % Flow depth [m]

% Prandtl number
P_r = 0.7;

% minimum air velocity
u = max(0.001, u);

% maximum air velocity
V_c = u .* sigma;

% Air side Reynolds number based on Louver pitch
Re = V_c .* L_p ./ v;

% Colburn j-factor correlation
j = Re.^(-0.487) .* (L_a./90).^(0.257) * ...
    (F_p./L_p).^(-0.13) .* (H ./ L_p).^(-0.29) .* ...
    (F_d ./ L_p).^(-0.235) .* (L_l./L_p).^(0.68) .* ...
    (T_p./L_p).^(-0.279) .* (d_f./L_p).^(-0.05);


% HTC
h = j .* rho .* V_c .* cp ./ P_r.^(2/3);

end











