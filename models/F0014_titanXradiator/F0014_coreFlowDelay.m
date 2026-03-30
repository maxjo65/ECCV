function t = F0014_coreFlowDelay(W, rho, par)

% parameters
HtH = par.HtH;
StS = par.StS;
CdT = par.CdT;

% approximate core inner flow area
A = 0.15 .* CdT .* StS;

% flow velocity
v = max(W ./ ( rho .* A), 0.01);

% time delay
t = min(HtH ./ v, 20);
