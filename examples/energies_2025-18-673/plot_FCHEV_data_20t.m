%%
clc
clear

T_amb = 30 + (1:15);

% load FCHEV data
load FCHEV_data_Base_20t.mat;
load FCHEV_data_Side_20t.mat;

% color codes
ORANGE = [246/255 128/255 0/255];
BLUE   = [52 180 214]/255;
YELLOW = [21 180 125]/255;
GRAY   = [179 179 179]/255;

% figure size
fig_width  = 500;
fig_height = 300;


%% Powers
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile


plot(data_Base{1}.distance ./ 1e3, data_Base{1}.batteryPower ./ 1e3, 'Linewidth', 1, 'Color', ORANGE)
hold on
plot(data_Base{1}.distance ./ 1e3, data_Base{1}.fuelCellPower ./ 1e3, 'Linewidth', 1.5, 'Color', BLUE)
plot(data_Base{1}.distance ./ 1e3, data_Base{1}.burnoffCurrent .* data_Base{1}.busVoltage / 1e3, 'Linewidth', 1.5, 'Color', 'black')

xlabel('Distance [km]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Power [kW]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

fig = gcf;
fig.Position = [0 0 fig_width*2 fig_height];



axis([0 100 -200 200]);

yyaxis right
ax = gca;
ax.YColor = 'black';
ar = area(data_Base{1}.distance ./ 1e3, data_Base{1}.altitude);
ar.EdgeColor = 'none';
ar.FaceColor = GRAY;
ar.FaceAlpha = 0.2;
h = gca;
h.YAxis(2).Visible = 'off';


L = legend('Battery', 'Fuel Cell', 'Burnoff', 'Interpreter', 'Latex', 'FontSize', 12);
L.Location = 'northwest';
box off

exportgraphics(gcf, 'FCHEV_powers_20t.pdf', 'ContentType', 'vector')


%% FC temperature
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile


plot(data_Base{1}.distance ./ 1e3, data_Base{1}.fuelCellTemperature, 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(data_Base{14}.distance ./ 1e3, data_Base{14}.fuelCellTemperature, 'Linewidth', 1.5, 'Color', ORANGE)

xlabel('Distance [km]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('FC Temperature [$^\circ$ C]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

fig = gcf;
fig.Position = [0 0 fig_width*2 fig_height];


yyaxis right
ax = gca;
ax.YColor = 'black';
ar = area(data_Base{1}.distance ./ 1e3, data_Base{1}.altitude);
ar.EdgeColor = 'none';
ar.FaceColor = GRAY;
ar.FaceAlpha = 0.2;
h = gca;
h.YAxis(2).Visible = 'off';


exportgraphics(gcf, 'FCHEV_FCtempvstime_20t.pdf', 'ContentType', 'vector')



%% State of charge
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile


plot(data_Base{1}.distance ./ 1e3, data_Base{1}.stateOfCharge, 'Linewidth', 1.5, 'Color', BLUE)

xlabel('Distance [km]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('SOC [-]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off


fig = gcf;
fig.Position = [0 0 fig_width*2 fig_height];


axis([0 100 0.475 0.575]);

yyaxis right
ax = gca;
ax.YColor = 'black';
ar = area(data_Base{1}.distance ./ 1e3, data_Base{1}.altitude);
ar.EdgeColor = 'none';
ar.FaceColor = GRAY;
ar.FaceAlpha = 0.2;
h = gca;
h.YAxis(2).Visible = 'off';




yyaxis right
ax = gca;
ax.YColor = 'black';
ar = area(data_Base{1}.distance ./ 1e3, data_Base{1}.altitude);
ar.EdgeColor = 'none';
ar.FaceColor = GRAY;
ar.FaceAlpha = 0.2;
h = gca;
h.YAxis(2).Visible = 'off';


L = legend('SOC',  'Interpreter', 'Latex', 'FontSize', 12);
L.Location = 'northwest';
box off


exportgraphics(gcf, 'FCHEV_SOC_20t.pdf', 'ContentType', 'vector')


%% Air temperature before condenser
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    Base_temp_increase(i) = trapz(data_Base{i}.Time, data_Base{i}.airTemperatureAfterCondenser - data_Base{i}.airTemperatureBeforeCondenser) ./ data_Base{i}.Time(end);
    Side_temp_increase(i) = trapz(data_Side{i}.Time, data_Side{i}.airTemperatureAfterCondenser - data_Side{i}.airTemperatureBeforeCondenser) ./ data_Side{i}.Time(end);
end

plot(T_amb, Base_temp_increase, 's-', 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(T_amb, Side_temp_increase, 's-', 'Linewidth', 1.5, 'Color', ORANGE)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Condenser Heating [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

L = legend('Base', 'Side Radiator', 'Latex', 'FontSize', 12);
L.Location = 'northwest';
box off

axis([30 46 0.4 2.5]);

fig = gcf;
fig.Position = [0 0 fig_width fig_height];

exportgraphics(gcf, 'FCHEV_condenserTemperature_20t.pdf', 'ContentType', 'vector')


%% Average fuel cell temperature 
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    Base_temp(i) = trapz(data_Base{i}.Time, data_Base{i}.fuelCellTemperature) ./ data_Base{i}.Time(end);
    Side_temp(i) = trapz(data_Side{i}.Time, data_Side{i}.fuelCellTemperature) ./ data_Side{i}.Time(end);
end

plot(T_amb, Base_temp, 's-', 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(T_amb, Side_temp, 's-', 'Linewidth', 1.5, 'Color', ORANGE)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('FC. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

L = legend('Base', 'Side Radiator', 'Latex', 'FontSize', 12);
L.Location = 'northwest';
box off

fig = gcf;
fig.Position = [0 0 fig_width fig_height];

axis([30 46 75 95]);


exportgraphics(gcf, 'FCHEV_fuelCellTemperature_20t.pdf', 'ContentType', 'vector')


%% Fuel consumption
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    Base_cons(i) = 1e5 .* trapz(data_Base{i}.Time, data_Base{i}.hydrogenFlow) ./ data_Base{i}.distance(end);
    Side_cons(i) = 1e5 .* trapz(data_Side{i}.Time, data_Side{i}.hydrogenFlow) ./ data_Side{i}.distance(end);
end

plot(T_amb, Base_cons, 's-', 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(T_amb, Side_cons, 's-', 'Linewidth', 1.5, 'Color', ORANGE)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Fuel Efficiency [kg/100km]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off


fig = gcf;
fig.Position = [0 0 fig_width fig_height];



%% COOP
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    Base_COOP(i) = trapz(data_Base{i}.Time, (data_Base{i}.evaporatorCooling + data_Base{i}.chillerCooling) ./ data_Base{i}.compressorPower ) ./ data_Base{i}.Time(end);
    Side_COOP(i) = trapz(data_Side{i}.Time, (data_Side{i}.evaporatorCooling + data_Side{i}.chillerCooling) ./ data_Side{i}.compressorPower ) ./ data_Side{i}.Time(end);
end


plot(T_amb, Base_COOP, 's-', 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(T_amb, Side_COOP, 's-', 'Linewidth', 1.5, 'Color', ORANGE)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('COOP [-]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

fig = gcf;
fig.Position = [0 0 fig_width fig_height];

exportgraphics(gcf, 'FCHEV_COOP_20t.pdf', 'ContentType', 'vector')


%% Pressure ratio
figure;
t = tiledlayout(1,1,'TileSpacing','tight','Padding', 'tight');
nexttile

for i = 1:15
    Base_pr(i) = trapz(data_Base{i}.Time, data_Base{i}.condenserPressure ./ data_Base{i}.evaporatorPressure ) ./ data_Base{i}.Time(end);
    Side_pr(i) = trapz(data_Side{i}.Time, data_Side{i}.condenserPressure ./ data_Side{i}.evaporatorPressure ) ./ data_Side{i}.Time(end);
end


plot(T_amb, Base_pr, 's-', 'Linewidth', 1.5, 'Color', BLUE)
hold on
plot(T_amb, Side_pr, 's-', 'Linewidth', 1.5, 'Color', ORANGE)

xlabel('Amb. Temperature [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'Latex');
ylabel('Pressure ratio [-]', 'FontSize', 16, 'Interpreter', 'Latex');
grid on
hold on
box off

fig = gcf;
fig.Position = [0 0 fig_width fig_height];

exportgraphics(gcf, 'FCHEV_pressureRatio_20t.pdf', 'ContentType', 'vector')