function p_sat = F0021_psat(T)
% Van Laar, J. L Res Tray Chim 39 (1920) 21
% fit to data from 
% Richter, Mclinden, Lemmon Journal of. Chem. E (2011)

% critical Temp & density
Tc   =     367.85; % [K]

T = max(T,0);
T = min(T, Tc);


% R1234yf coefficients
n = [ -4.893666065312787; 
       0.111013414194105; 
       0.000025221844863;
       -0.015565681357114] * 1e3;

% saturation pressure
p_sat = exp( n(1) .* (1./T) + n(2) + n(3) .* T + n(4) .* log(T) ); 
end