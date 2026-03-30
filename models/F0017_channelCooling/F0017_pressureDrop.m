function dp = F0017_pressureDrop(v, Re, rho,  par)
% parameters
d   = par.d;
L   = par.L;
e   = par.e;

% Darcy-weisbach friction factor
% laminar
f_lam = 64 ./ (Re + 0.01);

% turbulent and roughness
kd     = e./d;
f_turb = 1./(-1.8 .* log10(6.9 ./ (Re+0.001) + (kd./3.7).^(10/9) )).^2;

% smooth transition between laminar & turbulent
y = (Re-2100) / 500;
y = tanh(y*5)/2 + 1/2;

% combined
f = y .* f_turb + (1-y).* f_lam;

% pressure drop
dp =  L .* f .* rho./2 .* v.^2 ./ d;