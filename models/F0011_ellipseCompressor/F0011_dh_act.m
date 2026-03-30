function dh_act = F0011_dh_act(W_c_corr, K_loss, B, A)
% inputs
u1 = W_c_corr;
u2 = K_loss;
u3 = B;
u4 = A;

% actual enthalpy change
dh_act = u2 .* ( u3 + u4 .* u1 );

end