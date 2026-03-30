function dliq = F0021_dliqsat(T)
% correlation from Martin (1959)


% critical Temp & density
Tc   =     367.85; % [K]
rhoc =     4170.0; % [mol/m3]

T = min(T, Tc);
T = max(T, 0);

% coefficients
x = [   1.768478200876913;
        0.905584244505430;
       -0.353914488877852;
        0.447866446078125 ];

% saturated liquid dfensity
Tr   = T ./ Tc;
A    = [ (1-Tr).^(1/3), (1-Tr).^(2/3), (1-Tr), (1-Tr).^(4/3) ];
dliq = rhoc .* ( 1 + A * x );


end