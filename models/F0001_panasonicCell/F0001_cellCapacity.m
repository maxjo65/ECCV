function Q0 = F0001_cellCapacity(T)
% Fit to cycle data from
% Li-Ion Battery Model Performance for Automotive Drive
% Cycles with Current Pulse and EIS Parameterization
% Kolmeyer et al, 
% 978-1-5090-3953-1/$31.00 ©2017 IEEE

% parameters
a0 = 2.5718;
a1 = 0.0307;
a2 = -0.0006;

Q0 = a0 + a1.*T + a2 .*T^2;
end