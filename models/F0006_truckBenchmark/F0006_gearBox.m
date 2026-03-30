function [Tq_out, w_in] = F0006_gearBox(Tq_in, w_out, gear_ratio, par)
% parameters
fd_ratio = par.fd_ratio;
eta_gb   = par.eta_gb;

% combined drive ratio
gam = fd_ratio .* gear_ratio;

% torque on wheel
Tq_out = Tq_in .* gam .* eta_gb.^(sign(Tq_in));

% electric motor angular speed
w_in = w_out .* fd_ratio .* gear_ratio;

end