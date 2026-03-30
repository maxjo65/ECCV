% A Generalized SOC-OCV Model for Lithium-Ion
% Batteries and the SOC Estimation for LNMCO Battery
% Zhang et al, Energies
% doi:10.3390/en9110900

% Fit to OCV-data from
% Li-Ion Battery Model Performance for Automotive Drive
% Cycles with Current Pulse and EIS Parameterization
% Kolmeyer et al, 
% 978-1-5090-3953-1/$31.00 ©2017 IEEE

function U = F0001_ocvSOC(SOC)
% inputs x [-] - state of charge

% parameters
a =  2.0966;
b = -0.0055;
c = -0.2433;
d =  2.3054;
m =  3.0965;
n =  0.6010;

% OCV
x = SOC;
U = a + b * (-log(x)).^m + c .* x + d.*exp( n.*(x-1));
end