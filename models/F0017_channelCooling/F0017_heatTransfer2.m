function [Q, T_2] = F0017_heatTransfer2(T_1, T_w, Nu, W, cp, lam, par)
% Holman example 6-2, Heating of water in Laminar tube flow
% parameters
d  = par.d;
L  = par.L;

% heat transfer coefficient
h = lam .* Nu ./ d;

% factors
c1 =  W .* cp; 
c2 =  h.*pi.*d.*L;

% outlet temperature
T_2p = (c2 .* T_w + (c1 - c2./2) .* T_1 )./(c1 + c2./2);

% variable for cooling or heating mode
tmp = (T_1 - T_w)/1e1;            % Cooling when negative
y   = (tanh(tmp) + 1)/2;

% outlet temperature
T_2_cool = min(T_2p, T_w);
T_2_heat = max(T_2p, T_w);
T_2      = (1-y) .* T_2_cool + y .* T_2_heat;

% cooling
% T_2 = min(T_2p, T_w)

% heat transfer
Q = W .* cp .* (T_2 - T_1);