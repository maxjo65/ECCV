function e = F0014_epsCrossFlowUnmixed(NTU, C)
N = NTU;
% N = max(N, 0);
n = N.^(-0.22);

% tanhyp switch for C approaching zero
y = (tanh(C*1e2 - pi) + 1 )./2;

% Holman, Table 10.3, Cross flow, both fluids unmixed:
e1  = 1 - exp( ( exp( -N.*C.*n ) - 1 )./(C.*n) );

% C = 0
e0 = 1 - exp(-N);

% output
e = y.*e1 + (1-y).*e0;

        

