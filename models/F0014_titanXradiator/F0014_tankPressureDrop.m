function dp = F0014_tankPressureDrop(v, par)
% parameters
zeta = par.zeta;

% pressure drop
dp = 1/2 .* v .* abs(v) .* zeta;
