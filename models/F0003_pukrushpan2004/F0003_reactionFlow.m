function [W_an, W_ca] = F0003_reactionFlow(I)
% constants
F     = 96485; % [C/mol]  - Faradays constant
M_H2  = 0.002; % [kg/mol] - hydrogen molecular weight
M_O2  = 0.032; % [kg/mol] - oxygen   molecular weight
% M_N2  = 0.028; % [kg/mol] - nitrogen molecular weight
M_H2O = 0.018; % [kg/mol] - water    molecular weight

% reaction flows
W_H2_rct  = I * M_H2  /(2*F);
W_O2_rct  = I * M_O2  /(4*F);
W_H2O_rct = I * M_H2O /(2*F);

% output
W_an = [-W_H2_rct;         0;         0; 0];
W_ca = [        0; -W_O2_rct; W_H2O_rct; 0]; 
end