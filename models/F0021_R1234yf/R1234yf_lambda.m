function lambda = R1234yf_lambda(T, rho, cp, cv, mu, dp_drho, dp_drho_R)


% Critical point & molar mass
Tc   =     367.85; % [K]
pc   = 	3382200.0; % [Pa]
rhoc =     4170.0; % [mol/m3]
M    = 0.1140415928; % [kg/mol]
% R    = 8.314472;

% change units
rhoc = rhoc .* M;
rho  = rho  .* M;

% coefficients
A = [-0.0102778; 0.0291098; 0.000860643];

B      = zeros(5,2);
B(1,1) = -0.0368219;
B(1,2) =  0.0397166;
B(2,1) =  0.0883226;
B(2,2) = -0.0772390;
B(3,1) = -0.0705909;
B(3,2) =  0.0664707;
B(4,1) =  0.0259026;
B(4,2) = -0.0249071;
B(5,1) = -0.00322950;
B(5,2) =  0.00336228;


% Dilute-gas thermal conductivity
lambda_0 = sum( repmat(A', length(T), 1) .* (T./Tc).^(0:2), 2 );

% residual thermal conductivity
lambda_r = sum( (  repmat(B(:,1)', length(T), 1) + ...
    repmat(B(:,2)', length(T), 1) .* repmat((T./Tc), 1, 5) ) .* ...
    (rho./rhoc).^(1:5), 2);

% critical enhancement
R0        = 1.03;
kb        = 1.380649e-23;
eta       = mu;
T_R       = 1.5 .* Tc;
gam       = 1.239;
nu        = 0.63;
GAM       = 0.0496;
xi0       = 1.94e-10;
qd        = 0.5835e9;
dp_drho   = dp_drho   ./ M;
dp_drho_R = dp_drho_R ./ M;
drho_dp   = 1 ./ dp_drho;
drho_dp_R = 1 ./ dp_drho_R;


xi = xi0 .* ( pc .* rho ./ (GAM .* rhoc.^2) ).^(nu./gam) .* ...
            (  max(drho_dp - (T_R./T) .* drho_dp_R,eps)  ).^(nu./gam);


omega0    = 2./pi .* (1 - exp(-1./ ( 1./(qd.*xi) + (1/3) .* (qd.*xi.*rhoc./rho).^2 ) ) );
omega     = 2./pi .* (  (cp-cv)./cp .* atan(qd.*xi) + cv./cp .* qd.*xi );
dlambda_c = rho .* cp .* R0 .* kb .* T ./ (6 .* pi .* eta .* xi) .* (omega-omega0);

lambda = lambda_0 + lambda_r + dlambda_c;

end

