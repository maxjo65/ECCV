function Re = F0017_Reynolds(v, rho, mu, par)
% parameters
d   = par.d;

% Pipe reynolds number
Re = rho .* v .* d ./ mu;