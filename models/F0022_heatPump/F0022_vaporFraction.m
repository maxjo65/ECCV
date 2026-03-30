function x = F0022_vaporFraction(B, B_liq, B_vap)

% B is an arbitrary thermodynamic property, ie
% specific volume, enthalpy, etc.

x = (B - B_liq) ./ (B_vap - B_liq);

end