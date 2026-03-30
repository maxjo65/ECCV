function eta = F0022_louverSurfaceEffectiveness(h, par)

% HEX Geometry parameters
H    = par.H;    % Fin height [m]
d_f  = par.d_f;  % Fin thickness [m]
F_d  = par.F_d;  % Flow depth [m]

% Areas
A_f = par.A_f;
A_o = par.A_o;


% aluminium properties
k = par.k_w;


% Fin efficiency
m     = sqrt( 2.*h ./ (k .* d_f) .* (1 + d_f./F_d) );
l     = H/2 - d_f;
eta_f = tanh(m*l) ./ m.*l;

% Surface effectiveness
eta   = 1 - A_f ./ A_o .* (1 - eta_f);

end
