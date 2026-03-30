function G = F0022_massFlux(W, par)

% parameters
D_h = par.D_h;

% mass flux
G = 4 .* W ./ (D_h.^2 .* pi);
end