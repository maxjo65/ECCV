function h = F0022_minichannelCondensingHTC(G, p_sat,  x, rho_f, rho_g, cp_f, cp_g, mu_f, mu_g, k_f, k_g, par)
% Critical point & molar mass
pc = par.pc;

% gravity
g = 9.82;

% channel dimensions
b = par.b;
a = par.a;

% hydraulic diameter
D_h =  2 .* a .* b ./ (a + b);

G = max(G,0);

% Liquid reynolds & prandtl numbers
Re_f = (1-x) .* G .* D_h ./ mu_f;
Pr_f = cp_f .* mu_f ./ k_f;

% liquid only heat transfer coefficient
h_f = 0.023 .* Re_f.^0.8 .* Pr_f.^0.4 .* k_f ./ D_h;

% Gas only reynolds & prandtl numbers
Re_g = x .* G .* D_h ./ mu_g;
Pr_g = cp_g .* mu_g ./ k_g;



% gas only heat transfer coefficient
h_g = 0.023 .* Re_g.^0.8 .* Pr_g.^0.4 .* k_g ./ D_h;

% reduced pressure
p_r = p_sat ./ pc;

% Shah correlating parameter
% Z = (1./max(min(x,1),0.0000001) - 1).^0.8 .* p_r.^0.4;

Z = ( (1-x)./(x+0.00001) ).^0.8 .* p_r.^0.4;

% Regime depenedent HTCs
h_I = h_f .* (1 + 3.8./(Z.^0.95 + 0.00001)) .* ...
    (mu_f ./ (14 .* mu_g)).^(0.0058 + 0.557 .* p_r);


% smooth transition to subcooled liquid & superheated vapor
y = (x+0.1) / 0.2;
y = tanh(y*2)/2 + 1/2;
z =  (x-0.8) / 0.1;
z = tanh(z*2)/2 + 1/2;

% HTC
h = h_I .* y .* (1-z) + h_f .* (1-y) + h_g .* z;


% h_nu = 1.32 .* Re_f.^(-1/3) .* ...
%     (  rho_f .* (rho_f - rho_g) .* g .* k_f.^3 ./ mu_f.^2   ).^(1/3);
% 
% % dimensionless vapor velocity
% J_g = x.*G ./ (g.*D_h.*rho_g.*(rho_f - rho_g)).^0.5;
% 
% % Single phase regimes
% SP_REG1 = x == 0;
% SP_REG2 = x == 1;
% TP_REG1 = (~SP_REG1) & (~SP_REG2);
% 
% % % Two-phase regimes
% % TP      =  (x>0) & (x<1); 
% 
% % % vertical flow
% % TP_REG1 = TP & (J_g >= 1./(2.4.*Z + 0.73));
% % TP_REG3 = TP & (J_g <= 0.89 - 0.93 .* exp(-0.987 .* Z.^(-1.17)));
% % TP_REG2 = TP & (~TP_REG1 & ~TP_REG3);
% 
% % % horizontal flow
% % TP_REG1 = TP & (J_g >= 0.98 .* (Z + 0.263).^(-0.62) );
% % TP_REG3 = TP & (J_g <= 0.95 .* (1.254 + 2.27 .* Z.^1.249 ).^(-1) );
% % TP_REG2 = TP & (~TP_REG1 & ~TP_REG3);
% 
% % Output
% h = zeros(size(x));
% h( SP_REG1 ) = h_f( SP_REG1 );
% h( SP_REG2 ) = h_g( SP_REG2 );
% h( TP_REG1 ) = h_I( TP_REG1 );
% % h( TP_REG2 ) = h_I( TP_REG2 ) + h_nu( TP_REG2 );
% % h( TP_REG3 ) = h_nu( TP_REG3 );

end













