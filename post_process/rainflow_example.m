clc
clear

% extract data from run
data = extractSDI(1);
data = data{1};

% data signals
x = data.Time;
y = data.batteryVoltage;

% find turning points of the data
[p,t] = sig2ext(y, x);

% cycle count with rainflow algorithm
rf   = rainflow(p,t);
amps = rf(1,:); % amplitudes

% plot turning points
figure;
plot(x, y);
hold on
plot(t, p,'r.');

% plot histogram of amplitudes
figure;
rfdemo2(p);
grid on