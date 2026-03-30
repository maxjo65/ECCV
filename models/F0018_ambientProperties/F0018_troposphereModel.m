function [p,T] = F0018_troposphereModel(h, par)

% parameters
T_0 = par.T_0;
p_0 = par.p_0;

% The nasa troposphere model for pressure.
T = T_0 - 0.00649 .* h;
p = p_0 .* (T./288.078).^5.256;


