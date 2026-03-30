function h = F0004_temperatureToEnthalpy(T, par)
% output size
h = zeros(3,1);

% mass heat capacity
cp_r  = par.cp_r;
cp_v  = par.cp_H2O;
cp_N2 = par.cp_N2;
cp    = [cp_r; cp_v; cp_N2];

% specific enthalpy
h = cp .* T;
end