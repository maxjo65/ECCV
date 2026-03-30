function Tq_em = F0009_torqueLimit(Tq_req, V, w_em, par)

% Parameters
I_max = par.I_max;
e     = par.e;
c1    = par.c1;
c2    = par.c2;
c3    = par.c3;

% Losses
P_0 = c1 + c2 * w_em + c3 * w_em.^2 ;

% Traction
P_1_trac = I_max .* V;         
P_2_trac = (P_1_trac - P_0)/e;
Tq_trac  = P_2_trac ./ w_em;  % maximum traction torque

% Recuperation
P_1_recup = I_max .* V;
P_2_recup = e.*P_1_recup + P_0;
Tq_recup  = -P_2_recup ./ w_em ;  % minimum recuperation torque

% limit
Tq_em = Tq_req;
Tq_em( Tq_em > Tq_trac)  = Tq_trac;
Tq_em( Tq_em < Tq_recup) = Tq_recup;

end


