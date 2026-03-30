function p = F0022_artificialPressure(m, par)

% parameters
V = par.V;
B = par.BV .* par.V;
rho_ref = par.rho_ref;


% artificial pressure
p = B .* (m./(V .* rho_ref) - 1); 

end