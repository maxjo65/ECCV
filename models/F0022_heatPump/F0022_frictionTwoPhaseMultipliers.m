function [Phi_Ltt, Phi_Gtt] = F0022_frictionTwoPhaseMultipliers(X_tt, Re)


% Liquid
Phi_Ltt = 1 + C./X_tt + 1./X_tt.^2;

% Gas
Phi_Gtt = 1 + C.*X_tt + X_tt.^2;



end