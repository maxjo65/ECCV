function p_sat = F0010_vaporSaturationPressure(T)
% Journal of Physical and Chemical Reference Data 31,
% 387 (2002); https://doi.org/10.1063/1.1461829
c1 =  -7.85951783;
c2 =   1.84408259;
c3 = -11.7866497;
c4 =  22.6807411;
c5 = -15.9618719;
c6 =   1.80122502;

% critical temperature & pressure
Tcrit = 647.096;
pcrit = 22.06e6;

% saturation pressure as function of temperature
p_sat = pcrit*exp(Tcrit./T .* ( ...
    c1*(1-T./Tcrit) + ...
    c2*(1-T./Tcrit).^1.5 + ...
    c3*(1-T./Tcrit).^3 + ...
    c4*(1-T./Tcrit).^3.5 + ...
    c5*(1-T./Tcrit).^4 + ...
    c6*(1-T./Tcrit).^7.5 ));

% p_sat = real(p_sat);
end