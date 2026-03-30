function mu = R1234yf_mu(T,rho)

% Critical point & molar mass
Tc   =     367.85; % [K]
% pc   = 	3382200.0; % [Pa]
rhoc =     4170.0; % [mol/m3]
% M    = 0.1140415928; % [kg/mol]
% R    = 8.314472;

% Viscosity coefficients
a0 = -836950;
a1 = 6336.28;
a2 = -2.3547;
a3 = 0.0395563;
a4 = 39509.1;
a5 = 121.018;

b0 = -19.572881;
b1 = 219.73999;
b2 = -1015.3226;
b3 = 2471.0125;
b4 = -3375.1717;
b5 = 2491.6597;
b6 = -787.26086;
b7 = 14.085455;
b8 = -0.34664158;

b = [b0; b1; b2; b3; b4; b5; b6];

c0 = -0.19425910;
c1 = -2.079577245;
c2 = 0;
c3 = -43.47027288;
c4 = 0;
c5 = 0;
c6 = 0;
c7 = -3.53682791;
c8 = 1;

% dilute-gas limit viscosity
eta0 = (a0 + a1 .* T + a2 .* T.^2 + a3 .* T.^3) ./ (a4 + a5 .* T + T.^2);

% temperature dependent contribution
sigma   = 0.531e-9;
e_kb    = 275;
Mw      = 114.0416e-3;
N_a     = 6.02214076e23;
T_star  =  T ./ e_kb;
Bn_star = sum(  repmat(b', length(T), 1) .* T_star.^(-0.25.*(0:6)) , 2) + b7 .* T_star.^(-2.5) + b8 .* T_star.^-5.5; 
Bn      = Bn_star .* N_a .* sigma.^3;
eta1    = Bn .* eta0;

% residual term
rhor = rho ./ rhoc;
Tr    = T ./ Tc;

deta = rhor.^(2/3) .* Tr.^(1/2) .* ...
                (c0 + c1 .* rhor + c2 .* rhor.^2 +  ... 
                        (c3 .* rhor + c4 .* rhor.^6 + c5 .* rhor .* Tr.^2 + c6 .* rhor.^5 .* Tr) ./ (c7 .* Tr + c8 .* rhor .* Tr) );


% total viscosity
eta = eta0 + eta1 .* rho + deta;

% SI units
mu = eta .* 1e-6;

end