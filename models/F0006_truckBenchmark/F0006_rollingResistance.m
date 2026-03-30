function Fr = F0006_rollingResistance(v, alpha, par)
% inputs:
% v     [m/s] - vehicle speed
% alpha [rad] - road slope

% parameters:
c_r0 = par.c_r0;
c_r1 = par.c_r1;
m    = par.m;
g    = 9.82;

% m/s -> km/h
v_k = v * 3.6;

% rolling resistance coefficient
c_r = c_r0 + c_r1 .* v_k.^2;

% output
Fr =  c_r .* m .* g .* cos(alpha);
end