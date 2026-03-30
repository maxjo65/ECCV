function T = F0017_enthalpyToTemperature(H, cp, H0, T0, par)
    
    % temperature
    T = T0 + 1./cp .* (H - H0);

end