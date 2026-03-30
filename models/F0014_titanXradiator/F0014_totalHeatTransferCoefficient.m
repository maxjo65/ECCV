function U = F0014_totalHeatTransferCoefficient(v_air, v_clt, par)

% parameters
cU    = par.cU;
cUexp = par.cUexp;

% saturation
v_air = max(v_air, 0);
v_clt = max(v_clt, 0);


% Heat transfer coefficient
temp = cU(1) + cU(2) .* v_air.^-cUexp(1) + cU(3)*v_clt .^-cUexp(2);
U    = 1./temp;


