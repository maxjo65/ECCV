function W = F0003_diffusiveFlow(lambda_an, lambda_m, lambda_ca, T, par)

% parameters
A   = par.A_fc; % [cm2] - cell area
t_m = par.t_m;  % [cm]  - membrane thickness

% constants
F     = 96485;  % [C/mol]   - Faradays constant
R     = 8.314;  % [J/(molK] - gas constant 
M_H2O = 0.018;  % [kg/mol]  - water molecular mass

rho_mb_dry = 0.002; % [kg/cm^3] - membrane dry density;
M_mb_dry   = 1.1;   % [kg/mol]  - membrane dry equivalent weight 

% membrane diffusivity
D                  = 1e-6;
D(lambda_m >= 2)   = 1e-6 * (1 + 2*(lambda_m-2));
D(lambda_m >= 3)   = 1e-6 * (3 - 1.67*(lambda_m-3));
D(lambda_m >= 4.5) = 1.25e-6;
D_w                = 12 * D.*exp(2416*(1/303 - 1/T));

% Water concentrations on each side
c_an = rho_mb_dry ./ M_mb_dry .* lambda_an; % [mol/cm3] - water concentration at anode
c_ca = rho_mb_dry ./ M_mb_dry .* lambda_ca; % [mol/cm3] - water concentration at cathode

% Diffusive flow
W = M_H2O .* A .* D_w .* (c_an - c_ca)/t_m;

end