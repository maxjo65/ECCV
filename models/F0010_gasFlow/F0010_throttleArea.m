function A_t = F0010_throttleArea(alpha, par)
% model parameters
a0 = par.a0;
a1 = par.a1;
a2 = par.a2;

% effective area
A_t = a0 + a1.*alpha + a2 .* alpha.^2;
end