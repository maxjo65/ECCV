function H = F0017_temperatureToEnthalpy(T, cp, H0, T0, par)
   
    % enthalpy
    H = H0 + cp.*(T - T0);

end