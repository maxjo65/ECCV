function Tsat = F0021_Tsat(p)

% critical properties
Tc   =     367.85; % [K]
pc   = 	3382200.0; % [Pa]
rhoc =     4170.0; % [mol/m3]

p = max(p,0);
p = min(p, pc);

% coefficients
x = [ 0.011785783765939;
  -0.000711388291699;
  -0.000000004534501;
   0.000005602194397;
   0.000000550569193 ];

% calculate saturated temperature
pr   = p ./ pc;
A    = [ones(size(p)), log(pr), log(pr).^2, log(pr).^3, log(pr).^4];
Tsat = exp( ( A * x ).^(-0.4) );

end