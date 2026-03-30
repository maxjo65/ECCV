function [q1, dp1, P1] = F0014_fanAffinityLaw(n1, q2, par)
% Source:
% https://www.engineeringtoolbox.com/fan-affinity-laws-d_196.html

% parameters
dp2 = par.dp2;
P2  = par.P2;
n2  = par.n2;
d1  = par.d1;
d2  = par.d2;

% Affinity laws
q1  = q2  .* (n1./n2)    .* (d1./d2).^3;
dp1 = dp2 .* (n1./n2).^2 .* (d1./d2).^2;
P1  = P2  .* (n1./n2).^3 .* (d1./d2).^5;