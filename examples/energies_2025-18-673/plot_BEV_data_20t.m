
clc
clear

T_amb = 0 - (1:15);

% load FCHEV data
load BEV_data_PTC_20t.mat;
load BEV_data_ASHP_20t.mat;
load BEV_data_WHR_20t.mat;

% color codes
ORANGE = [246/255 128/255 0/255];
BLUE   = [52 180 214]/255;
YELLOW = [21 180 125]/255;
GRAY   = [179 179 179]/255;

% figure size
fig_width  = 500;
fig_height = 300;


%% speed
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

plot(data_PTC{1}.distance / 1e3, data_PTC{1}.velocity, 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(data_PTC{1}.distance / 1e3, data_PTC{1}.velocityReference, '--', 'Linewidth', 1.5, 'Color', 'black')

xlabel('Distance [km]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Speed [km/h]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
box off


axis([0 100 77 83]);

fig = gcf;
fig.Position = [0 0 fig_width*2 fig_height];

yyaxis right
ax = gca;
ax.YColor = 'black';
ar = area(data_PTC{1}.distance / 1e3, data_PTC{1}.altitude);
ar.EdgeColor = 'none';
ar.FaceColor = GRAY;
ar.FaceAlpha = 0.2;
h = gca;
h.YAxis(2).Visible = 'off';

L = legend('Speed', 'Reference', 'Interpreter', 'Latex', 'FontSize', 12);
L.Location = 'northwest';

exportgraphics(gcf, 'BEV_speed_20t.pdf', 'ContentType', 'vector')

%% motor power
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

plot(data_PTC{1}.distance / 1e3, 4 .* data_PTC{1}.motorTorque .* data_PTC{1}.motorSpeed / 1e3, 'Linewidth', 1.5, 'Color', BLUE)


xlabel('Distance [km]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Motor Power [kW]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
box off


yyaxis right
ax = gca;
ax.YColor = 'black';
ar = area(data_PTC{1}.distance / 1e3, data_PTC{1}.altitude);
ar.EdgeColor = 'none';
ar.FaceColor = GRAY;
ar.FaceAlpha = 0.2;
h = gca;
h.YAxis(2).Visible = 'off';


fig = gcf;
fig.Position = [0 0 2*fig_width fig_height];

exportgraphics(gcf, 'BEV_motorPower_20t.pdf', 'ContentType', 'vector')


%% Battery SOC
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 2:15
    plot(data_PTC{i}.distance / 1e3, data_PTC{i}.stateOfCharge, 'Linewidth', 1.5, 'Color', GRAY)
    hold on
end

plot(data_PTC{1}.distance / 1e3, data_PTC{1}.stateOfCharge, 'Linewidth', 1.5, 'Color', BLUE)

xlabel('Distance [km]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('SOC [-]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
box off


yyaxis right
ax = gca;
ax.YColor = 'black';
ar = area(data_PTC{1}.distance / 1e3, data_PTC{1}.altitude);
ar.EdgeColor = 'none';
ar.FaceColor = GRAY;
ar.FaceAlpha = 0.2;
h = gca;
h.YAxis(2).Visible = 'off';


fig = gcf;
fig.Position = [0 0 fig_width*2 fig_height];

exportgraphics(gcf, 'BEV_SOC_20t.pdf', 'ContentType', 'vector')



%% Temperatures
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

plot(data_PTC{1}.distance / 1e3, data_PTC{1}.batteryTemperature, 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(data_PTC{1}.distance / 1e3, data_PTC{1}.batteryTemperatureReference, '--', 'Linewidth', 1.5, 'Color', 'black')

plot(data_PTC{1}.distance / 1e3, data_PTC{1}.cabinTemperature, 'Linewidth', 1.5, 'Color', ORANGE)
plot(data_PTC{1}.distance / 1e3, data_PTC{1}.cabinTemperatureReference, '--', 'Linewidth', 1.5, 'Color', 'black')

xlabel('Distance [km]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Bat. Current [A]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
box off


axis([0 100 18 26]);

yyaxis right
ax = gca;
ax.YColor = 'black';
ar = area(data_PTC{1}.distance / 1e3, data_PTC{1}.altitude);
ar.EdgeColor = 'none';
ar.FaceColor = GRAY;
ar.FaceAlpha = 0.2;
h = gca;
h.YAxis(2).Visible = 'off';

fig = gcf;
fig.Position = [0 0 fig_width*2 fig_height];

L = legend('Bat. Temp.', 'References', 'Cabin Temp.', 'Interpreter', 'Latex', 'FontSize', 12);
L.Location = 'northeast';


exportgraphics(gcf, 'BEV_temperature_20t.pdf', 'ContentType', 'vector')



%% energy efficiency
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    PTC_kwh_per_km(i)  = 100 * (1/3600) .* trapz(data_PTC{i}.Time, data_PTC{i}.batteryCurrent .* data_PTC{i}.batteryVoltage)    ./ data_PTC{i}.distance(end);
    ASHP_kwh_per_km(i) = 100 * (1/3600) .* trapz(data_ASHP{i}.Time, data_ASHP{i}.batteryCurrent .* data_ASHP{i}.batteryVoltage) ./ data_ASHP{i}.distance(end);
    WHR_kwh_per_km(i)  = 100 * (1/3600) .* trapz(data_WHR{i}.Time, data_WHR{i}.batteryCurrent .* data_WHR{i}.batteryVoltage)    ./ data_WHR{i}.distance(end);
end

plot(T_amb, PTC_kwh_per_km, 's-', 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(T_amb, ASHP_kwh_per_km, 's-', 'Linewidth', 1.5, 'Color', ORANGE)
plot(T_amb, WHR_kwh_per_km, 's-', 'Linewidth', 1.5, 'Color', GRAY)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Efficiency [kWh / 100km]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

L = legend('PTC', 'AS-HP', 'WHR', 'Latex', 'FontSize', 12);
L.Location = 'northwest';
box off
set(gca, 'XDir','reverse')

fig = gcf;
fig.Position = [0 0 fig_width fig_height];

axis([-16 0 102 116]);

exportgraphics(gcf, 'BEV_efficiency_20t.pdf', 'ContentType', 'vector')


%% compressor work

% first tile
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    PTC_cmp_kwh(i)  = 0;
    ASHP_cmp_kwh(i) = 100 * (1/3600) .* trapz(data_ASHP{i}.Time, data_ASHP{i}.compressorPower) ./ data_ASHP{i}.distance(end);
    WHR_cmp_kwh(i)  = 100 * (1/3600) .* trapz(data_WHR{i}.Time, data_WHR{i}.compressorPower)    ./ data_WHR{i}.distance(end);
end

plot(T_amb, PTC_cmp_kwh, 's-', 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(T_amb, ASHP_cmp_kwh, 's-', 'Linewidth', 1.5, 'Color', ORANGE)
plot(T_amb, WHR_cmp_kwh, 's-', 'Linewidth', 1.5, 'Color', GRAY)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Compressor [kWh / 100km]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

L = legend('PTC', 'AS-HP', 'WHR', 'Latex', 'FontSize', 12);
L.Location = 'northwest';
box off
set(gca, 'XDir','reverse')

axis([-16 0 -1 7]);

fig = gcf;
fig.Position = [0 0 fig_width fig_height];

exportgraphics(gcf, 'BEV_compressorWork_20t.pdf', 'ContentType', 'vector')


%% Cabin heater

% first tile
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    PTC_cab_kwh(i)  = 100 * (1/3600) .* trapz(data_PTC{i}.Time, data_PTC{i}.cabinHeaterPower) ./ data_PTC{i}.distance(end);
    ASHP_cab_kwh(i) = 100 * (1/3600) .* trapz(data_ASHP{i}.Time, data_ASHP{i}.cabinHeaterPower) ./ data_ASHP{i}.distance(end);
    WHR_cab_kwh(i)  = 100 * (1/3600) .* trapz(data_WHR{i}.Time, data_WHR{i}.cabinHeaterPower)    ./ data_WHR{i}.distance(end);
end

plot(T_amb, PTC_cab_kwh, 's-', 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(T_amb, ASHP_cab_kwh, 's-', 'Linewidth', 1.5, 'Color', ORANGE)
plot(T_amb, WHR_cab_kwh, 's-', 'Linewidth', 1.5, 'Color', GRAY)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Cab. Heater [kWh / 100km]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

box off
L = legend('PTC', 'AS-HP', 'WHR', 'Latex', 'FontSize', 12);
L.Location = 'northwest';
box off
set(gca, 'XDir','reverse')

axis([-16 0 -1 9]);

fig = gcf;
fig.Position = [0 0 fig_width fig_height];

exportgraphics(gcf, 'BEV_cabHeater_20t.pdf', 'ContentType', 'vector')


%% COOP

% first tile
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    ASHP_COOP(i) = trapz(data_ASHP{i}.Time, data_ASHP{i}.condenserHeating ./ data_ASHP{i}.compressorPower) ./ data_ASHP{i}.Time(end);
    WHR_COOP(i)  = trapz(data_WHR{i}.Time, data_WHR{i}.condenserHeating ./ data_WHR{i}.compressorPower) ./ data_WHR{i}.Time(end);
end

plot(T_amb, ASHP_COOP, 's-', 'Linewidth', 1.5, 'Color', ORANGE)
hold on
plot(T_amb, WHR_COOP, 's-', 'Linewidth', 1.5, 'Color', GRAY)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('COOP [-]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

box off
set(gca, 'XDir','reverse')

L = legend('AS-HP', 'WHR', 'Latex', 'FontSize', 12);
L.Location = 'northeast';
box off
set(gca, 'XDir','reverse')

axis([-16 0 1 6]);

fig = gcf;
fig.Position = [0 0 fig_width fig_height];

exportgraphics(gcf, 'BEV_compressorCOOP_20t.pdf', 'ContentType', 'vector')

%% Pressure ratio

% first tile
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    ASHP_pr(i) = trapz(data_ASHP{i}.Time, data_ASHP{i}.condenserPressure ./ data_ASHP{i}.evaporatorPressure) ./ data_ASHP{i}.Time(end);
    WHR_pr(i)  = trapz(data_WHR{i}.Time, data_WHR{i}.condenserPressure ./ data_WHR{i}.evaporatorPressure) ./ data_ASHP{i}.Time(end);
end

plot(T_amb, ASHP_pr, 's-', 'Linewidth', 1.5, 'Color', ORANGE)
hold on
plot(T_amb, WHR_pr, 's-', 'Linewidth', 1.5, 'Color', GRAY)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Pressure Ratio [-]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

box off
L = legend('AS-HP', 'WHR', 'Latex', 'FontSize', 12);
L.Location = 'northwest';
set(gca, 'XDir','reverse')

axis([-16 0 2 10]);


fig = gcf;
fig.Position = [0 0 fig_width fig_height];

exportgraphics(gcf, 'BEV_pressureRatio_20t.pdf', 'ContentType', 'vector')
