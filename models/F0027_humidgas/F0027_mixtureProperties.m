function [cp_m, mu_m, lam_m] = mixture_properties(cp, mu, lam, p, T)

% molar fractions
x = p ./ sum(p,1);

% molar weights
M = [2.016e-3; 31.999e-3; 18.015e-3; 28.014e-3];

% mass fractions
M_avg = sum(x .* M);
w     = x .* M ./ M_avg;

% mixture specific heat capacity
cp_m = sum(w .* cp);

% Wilke's rule for mixture viscosity
phi  = (1 + (mu ./ mu').^0.5 .* (M' ./ M).^0.25).^2 ./ ...
    ( (4/sqrt(2)) .* (1 + (M ./ M')).^0.5 ) ;

% Eq. 13
num           = mu;
phi0          = phi;
phi0(1:5:end) = 0; 
den  = 1 + 1./x .* sum( x' .* phi0, 2);
mu_m = sum(num ./ den, 1);


% Sutherland constant
S   = [79; 90.2.*1.5; 373.15*1.5; 77.*1.5];
Sij = sqrt(S .* S');

% parameter
A  = 0.25 .* ( 1 + ( mu ./ mu' .* (M' ./ M).^0.75 .* ...
    (1 + S./T)./(1 + S'./T) ).^0.5 ).^2 .* ...
    (1 + Sij./T)./(1 + S./T);

% Eq. 11
num   = lam;
den   = 1./x .* sum( A .* x', 2);
lam_m = sum( num./den, 1); 

end













