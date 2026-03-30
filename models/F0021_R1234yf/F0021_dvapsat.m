function dvap = F0021_dvapsat(T)

% critical Temp & density
Tc   =     367.85; % [K]
% rhoc =     4170.0; % [mol/m3]

T = min(T, Tc);
T = max(T, 0);

% coefficients
x = [ 8.5116; -7.9050; 1.6189; 2.6394; -1.3847 ];

% saturated vapor density
Tr   = T ./ Tc;
th   = 1 ./ (1 - Tr);
A    = [ ones(size(Tr)), log(th).^(-1.5), log(th).^(-2), log(th).^(-3), log(th).^(-4) ];
dvap = exp(A*x);


end