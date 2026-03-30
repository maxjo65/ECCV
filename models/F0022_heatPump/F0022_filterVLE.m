function B = F0022_filterVLE(B, B_liq, B_vap, x)

% assign saturated property
B( x > 0 & x < 1) = x .* B_vap + (1-x) .* B_liq;


end