function [W_p, W_s, phi, w] = F0010_ejectorModel(P_p, P_s, P_b, T_p, p_sat, RH_s, par)

% determine output sizes
W_p = 0;
W_s = 0;
phi = 0;
w   = 0;

% parameters
C_d    = par.C_d;        % [-]   - Discharge coefficient
D_t    = par.D_t;        % [m]   - Nozzle throat diameter
A_t    = pi*(D_t/2)^2;   % [m2]  - Nozzle throat area
c_0    = par.c_0;
c_1    = par.c_1;
Pi_lin = par.Pi_lin;

% gas properties
M_H2  = 2.016e-3;        % [kg/mol] - hydrogen gas molecular weight
M_H2O = 36.030e-3;       % [kg/mol] - water molecular weight
R_g   = 8.314 / M_H2;    % [J/kg*K] - hydrogen gas constant 
cp    = 14.31e3;         % [J/kg*K] - hydrogen gas specific heat @ 300 K
g     = cp/(cp - R_g);     % [-]      - ratio of specific heats

% pressure ratio
pr = P_b ./ P_p;

% primary flow
pr_crit = (2/(1+g)).^( g/(g-1) );
Pi      = max(pr, pr_crit);
Pi      = min(Pi,1);
Phi     = sqrt( 2*g./(g-1) .* ( Pi.^(2/g) - Pi.^((g+1)/g)) );
Phi_lin = sqrt( 2*g./(g-1) .* ( Pi_lin.^(2/g) - Pi_lin.^((g+1)/g)) );
Phi(Pi > Pi_lin) = Phi_lin .* (1-Pi)./(1-Pi_lin);
W_p     = P_p ./ sqrt(R_g.*T_p) .* A_t .* C_d .* Phi;


% recirculation ratio
t   = ((tanh( (pr - pr_crit)*20 ) ) + 1)/2;
phi = (c_0 + c_1.*pr) .* (1-t); 

% secondary flow
x_H2O   = p_sat .* RH_s ./ P_s;
y_H2O   = M_H2O .* x_H2O ./ (M_H2O .* x_H2O + M_H2.*(1 - x_H2O));
W_s     = phi .* W_p ./ (1 - y_H2O);

% entrainment
w = W_s ./ W_p;















