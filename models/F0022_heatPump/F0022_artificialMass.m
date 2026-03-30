function m = F0022_artificialMass(p, par)

% parameters
B       = par.BV .* par.V;
rho_ref = par.rho_ref;
V       = par.V;

% artificial mass
m = V .* rho_ref .* (p./B + 1);


end