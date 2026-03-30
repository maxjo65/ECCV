function H = F0010_enthalpyFlow(W, T_1, T_2, par)
% parameters
cp_j = par.cp_j; % [J/kgK]  - Specific heats

% Upstream & downstream total pressure
% Switch variable
y = (tanh(W*1e4-pi) + 1)/2;

% Upstream temperature
T_us =  y.*T_1 + (1-y).*T_2;

% Enthalpy flow
H = W .* T_us .* cp_j;
end