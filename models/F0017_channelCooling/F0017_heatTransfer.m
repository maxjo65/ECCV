function [Q, T_2] = F0017_heatTransfer(T_1, T_w, Nu, W, cp, lam, par)
% Holman example 6-2, Heating of water in Laminar tube flow
% parameters
d    = par.d;
L    = par.L;

% heat transfer coefficient
h = lam .* Nu ./ d;

% factors
c1 =  W .* cp; 
c2 =  h.*pi.*d.*L;

% outlet temperature
T_2p = (c2 .* T_w + (c1 - c2./2) .* T_1 )./(c1 + c2./2);

% check if temperature reaches wall temperature
if T_1 < T_w
    % cooling
    T_2 = min(T_2p, T_w);
else
    % heating
    T_2 = max(T_2p, T_w);
end
   
% heat transfer
Q = W .* cp .* (T_2 - T_1);