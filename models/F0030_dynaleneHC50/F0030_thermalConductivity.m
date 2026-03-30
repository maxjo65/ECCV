function lam = F0030_thermalConductivity(T)

% parameters
x = [0.21197; 0.0009996];

% thermal conductiity
lam = x(1) + x(2) .* T;

end