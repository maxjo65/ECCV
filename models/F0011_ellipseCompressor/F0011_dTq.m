function dw_c = F0011_dTq(Tq_em, Tq_c, w_c, par)
% parameters
J_c = par.J_c;
c   = par.c_fric;

% shaft friction
Mf = c .* w_c;

% turbo shaft dynamics
% Model 8.3
dw_c = 1/J_c .* ( Tq_em - Tq_c - Mf);

end