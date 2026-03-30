function Tq_em = F0009_torque(V, I, w, par)

% Output size
Tq_em = 0;

% Parameters
e     = par.e;
c1    = par.c1;
c2    = par.c2;
c3    = par.c3;

% minimum speed
w   = max(w, 10);

% power loss
P_0 = c1 + c2 * w + c3 * w.^2;

% Input power
P = V .* I;

% Motor power & torque
P_m  = (e * P - P_0);
Tq_m = P_m ./ w; 

% Generator power & torque
P_g  = P./e + P_0;
Tq_g = P_g ./ w;

% output depending on motor/generator mode
if I > 0
    Tq_em = Tq_m;
else
    Tq_em = Tq_g;
end