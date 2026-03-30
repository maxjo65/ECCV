function dp = F0014_condenserPressureDrop(T, p, W, par)

% parameters
StS  = par.StS;
HtH  = par.HtH;
R    = par.R_air;
c_dp = par.c_dp; 

% Area
A = StS .* HtH;

% Velocity
v = W .* R .* T ./ (p.*A);

% pressure drop
dp = c_dp(1) .* v.^2 + c_dp(2) .* v;


