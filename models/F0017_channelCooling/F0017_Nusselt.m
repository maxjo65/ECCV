function Nu = F0017_Nusselt(Re, Pr, par)

% parameters
d = par.d;
L = par.L;

% Hausen Nusselt Correlation:
Nu_lam = 3.66 + ...
    (0.0668.*(d./L) .* Re .* Pr) ./ ...
    (1 + 0.04 .*( max( (d./L) .* Re .* Pr , 1e-10) ).^(2/3) );

% Sieder-Tate Correlation:
Nu_turb = 0.027 .* Re.^0.8 .* Pr.^(1/3);

% transition from laminar to turbulent flow
y = (Re-3500) / 2e3;
y = tanh(y*5)/2 + 1/2;

% Nusselt number
Nu = (1-y) .* Nu_lam + y.*Nu_turb;