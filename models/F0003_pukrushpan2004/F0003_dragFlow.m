function W = F0003_dragFlow(I, lambda)

% parameters
F          = 96485;  % [C/mol]   - Faradays constant
M_H2O      = 0.018;  % [kg/mol]  - water molecular mass

% electro-osmotic drag coefficient
n_d = 0.0029 .* lambda.^2 + 0.05 .* lambda;

% Drag flow
W =  M_H2O .* n_d .* I / F;
end