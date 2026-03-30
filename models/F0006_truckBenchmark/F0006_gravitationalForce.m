function Fg = F0006_gravitationalForce(alpha, par)
% inputs:
% alpha [rad] - road slope

% parameters:
m       = par.m;
g       = 9.82;

% output
Fg =   m .* g .* sin(alpha);
end