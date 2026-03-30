clc
clear

% this script fits a linearizable function to the speed vs.
% maximum torque data

% load data
load em_maxTorque_map.mat;
plot(map.w, map.Tq)
hold on

% exponential function
w0 = 64;
Tq = map.Tq(map.w > w0);
w  = map.w(map.w > w0);
f = @(a) a(1) + a(2) .* exp(- a(3) ./ w) - Tq;
a0 = [1; 1; 1];
a = lsqnonlin(f, a0);
% plot(w, f(a) + Tq);

% exponential function + constant
f = @(a,w) a(1) + a(2) .* exp(- a(3) ./ w);
w   = linspace(0, max(map.w), 1e3)';
Tq0 = 1991;
y   = (tanh( (w - w0) ) + 1) / 2;

% final expression
Tq_max = Tq0 .* (1 - y) + ...
    y .* (-2.9265e3  + 2.8775e3 .* exp( 0.0348e3 ./ w ));

% plot model on data
plot(w, Tq_max)
grid on