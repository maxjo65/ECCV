function sigma = R1234yf_sigma(T)

% Critical point & molar mass
Tc   =     367.85; % [K]
% pc   = 	3382200.0; % [Pa]
% rhoc =     4170.0; % [mol/m3]
% M    = 0.1140415928; % [kg/mol]
% R    = 8.314472;

% max & min temperature
T = max(T,  0);
T = min(T, Tc);

% coefficients
c = [ 42.36234 0.60895 -0.42621 367.85]';

% surface tension
Tr      = T ./ Tc; 
sigma = c(1) .* (1 - Tr).^1.26 .* ( 1 + c(2).*(1-Tr).^0.5 + c(3).*(1-Tr) );

% shift to SI unit
sigma = sigma * 1e-3;

end