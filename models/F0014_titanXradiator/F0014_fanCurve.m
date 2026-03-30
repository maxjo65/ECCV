function dp = F0014_fanCurve(q, dp0_n, par)

% parameters
dpr = par.dpr;
dp0 = par.dp0;
q0  = par.q0;

% pressure drop/increase
temp = (q ./ q0).^2;
dp   = max(dpr .* temp, dp0_n - dp0 .* temp);
