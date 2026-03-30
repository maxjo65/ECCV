clc
clear

% this script linearizes the vehicle model and generates
% associated MPC objects for use in simulink

% sizes
nx = 2;
nu = 3;

% variables
x  = sym('x', [nx 1], 'real' );
u  = sym('u', [nu 1], 'real' );
v  = sym('v', [1 1],  'real' );

% symbolic representation of dx (in gear = 3)
[dx, g] = vehicleModel(x, u, v, 3);

% linear system matrices
A  = jacobian(dx, x);
Bu = jacobian(dx, u);
Bv = jacobian(dx, v);

% constraint gradients
dgdx = jacobian(g, x);
dgdu = jacobian(g, u);
dgdv = jacobian(g, v);

% generate functions
matlabFunction(A,    'Vars', {x, u, v}, 'File', 'gen_A.m');
matlabFunction(Bu,   'Vars', {x, u, v}, 'File', 'gen_Bu.m');
matlabFunction(Bv,   'Vars', {x, u, v}, 'File', 'gen_Bv.m');
matlabFunction(dgdx, 'Vars', {x, u, v}, 'File', 'gen_dgdx.m');
matlabFunction(dgdu, 'Vars', {x, u, v}, 'File', 'gen_dgdu.m');
matlabFunction(dgdv, 'Vars', {x, u, v}, 'File', 'gen_dgdv.m');

% equilibrium point guess
x0  = [75/3.6; 0.5];
u0  = [0.35; 250; 0];
v0  = 0;

% find equilibrium point
f = @(z) vehicleModel(x0, [z; u0(2); u0(3)], v0, 3);
z = lsqnonlin(f, 0);
u0(1) = z;

% test
disp(vehicleModel(x0, u0, v0, 3));

% system matrices
A  = gen_A(x0, u0, v0);
Bu = gen_Bu(x0, u0, v0);
Bv = gen_Bv(x0, u0, v0);
B  = [Bv, Bu];
C = eye(2);
D = zeros(2,4);

% system
plant = ss(A,B,C,D);

% specify signals
plant = setmpcsignals(plant, 'MD', 1);

% create mpc object
P      = 20;
M      = P;
Ts     = 1;
mpcobj = mpc(plant, Ts, P, M);

% road slope sample distance
ds = 10;

% torque reference limits
mpcobj.ManipulatedVariables(1).Min     =  -1;
mpcobj.ManipulatedVariables(1).Max     =   1;
mpcobj.ManipulatedVariables(1).RateMin =  -1;
mpcobj.ManipulatedVariables(1).RateMax =   1;

% fuel cell current limits
mpcobj.ManipulatedVariables(2).Min     =    0;
mpcobj.ManipulatedVariables(2).Max     =  400;
mpcobj.ManipulatedVariables(2).RateMin =  -10;
mpcobj.ManipulatedVariables(2).RateMax =   10;

% burn-off resistor power limits
mpcobj.ManipulatedVariables(3).Min     =    0;
mpcobj.ManipulatedVariables(3).Max     =  100;
mpcobj.ManipulatedVariables(3).RateMin = -inf;
mpcobj.ManipulatedVariables(3).RateMax =  inf;

% velocity limits
mpcobj.OutputVariables(1).Min = 40/3.6;
mpcobj.OutputVariables(1).Max = 80/3.6;

% state of charge limits
mpcobj.OutputVariables(2).Min = 0.2;
mpcobj.OutputVariables(2).Max = 0.8;

% linear constraints
dgdx = gen_dgdx(x0, u0, v0);
dgdu = gen_dgdu(x0, u0, v0);
dgdv = gen_dgdv(x0, u0, v0);
E = [dgdu; -dgdu];
F = [dgdx; -dgdx];
S = [dgdv; -dgdv];
G = [3 + dgdx * x0 + dgdu * u0 + dgdv * v0;
     3 - (dgdx * x0 + dgdu * u0 + dgdv * v0)];
setconstraint(mpcobj, E, F, G, [], S);

% set weights
mpcobj.Weights.ManipulatedVariables     = [0, 0.01, 1];
mpcobj.Weights.ManipulatedVariablesRate = [0.1, 0, 0];
mpcobj.Weights.OutputVariables          = [1, 0];




