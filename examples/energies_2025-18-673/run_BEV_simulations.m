clc
clear

% vehicle mass
mass = 20e3;

% simulate BEV PTC case
for i = 1:15
    disp(i);
    T_amb = 273.15 - i;
    sim('BEV_PTC',   20e3);
end
data_PTC = extractSDI(15);
% save('examples/ECOTS_paper1/BEV_data_PTC.mat', 'data_PTC');
save('examples/ECOTS_paper1/BEV_data_PTC_20t.mat', 'data_PTC');

%% plot check
% load BEV_data_PTC.mat;
load BEV_data_PTC_20t.mat;


figure;
for i = 1:15
    subplot(2,4,1)
    plot(data_PTC{i}.Time, data_PTC{i}.cabinHeaterPower / 1e3);
    hold on
    ylabel('Cab. heater [kW]');
        
    subplot(2,4,2);
    plot(data_PTC{i}.Time, data_PTC{i}.batteryTemperature);
    hold on
    ylabel('Bat. temp. [C]');

    subplot(2,4,3);
    plot(data_PTC{i}.Time, data_PTC{i}.cabinTemperature);
    hold on
    ylabel('Cab. temp. [C]');

    subplot(2,4,4);
    plot(data_PTC{i}.Time, data_PTC{i}.velocity);
    hold on

    subplot(2,4,5)
    plot(data_PTC{i}.Time, data_PTC{i}.batteryHeaterPower / 1e3);
    hold on
    ylabel('Bat. heater [kW]');

    subplot(2,4,6)
    plot(data_PTC{i}.Time, data_PTC{i}.batteryCoolantTemperature);
    hold on
    ylabel('Bat. coolant temp. [C]');

    subplot(2,4,7)
    plot(data_PTC{i}.Time, data_PTC{i}.batteryCurrent);
    hold on
    ylabel('Bat. current [A]');

    subplot(2,4,8)
    plot(data_PTC{i}.Time, data_PTC{i}.busVoltage);
    hold on
    ylabel('Bus voltage [V]');
end


%% Simulate ASHP
clc
clear

% vehicle mass
mass = 20e3;

% simulate BEV ASHP case
for i = 1:15
    disp(i);
    T_amb = 273.15 - i;
    sim('BEV_ASHP',   20e3);
end

data_ASHP = extractSDI(15);
% save('examples/ECOTS_paper1/BEV_data_ASHP.mat', 'data_ASHP');
save('examples/ECOTS_paper1/BEV_data_ASHP_20t.mat', 'data_ASHP');

%% plot check
% load BEV_data_ASHP.mat;
load BEV_data_ASHP_20t.mat;

figure;
for i = 1:15
    subplot(3,4,1)
    plot(data_ASHP{i}.Time, data_ASHP{i}.cabinHeaterPower / 1e3);
    hold on
    ylabel('Cab. heater [kW]');
        
    subplot(3,4,2);
    plot(data_ASHP{i}.Time, data_ASHP{i}.batteryTemperature);
    hold on
    ylabel('Bat. temp. [C]');

    subplot(3,4,3);
    plot(data_ASHP{i}.Time, data_ASHP{i}.cabinTemperature);
    hold on
    ylabel('Cab. temp. [C]');

    subplot(3,4,4);
    plot(data_ASHP{i}.Time, data_ASHP{i}.compressorPower / 1e3);
    hold on
    ylabel('Cmp. power [kw]');

    subplot(3,4,5)
    plot(data_ASHP{i}.Time, data_ASHP{i}.batteryCoolantTemperature);
    hold on
    ylabel('Bat. coolant temp. [C]');

    subplot(3,4,6)
    plot(data_ASHP{i}.Time, data_ASHP{i}.condenserSubcool);
    hold on
    ylabel('Subcooling [C]');

    subplot(3,4,7)
    plot(data_ASHP{i}.Time, data_ASHP{i}.externalEvaporatorSuperheat);
    hold on
    ylabel('Superheating [C]');

    subplot(3,4,8)
    plot(data_ASHP{i}.Time, data_ASHP{i}.evaporatorPressure ./ 1e5);
    hold on
    ylabel('Evap. pressure [bar]');

    subplot(3,4,9)
    plot(data_ASHP{i}.Time, data_ASHP{i}.externalEvaporatorHeating / 1e3);
    hold on
    ylabel('Evap. heating [kW]');

    subplot(3,4,10)
    plot(data_ASHP{i}.Time, data_ASHP{i}.cabinCondenserHeating / 1e3);
    hold on
    ylabel('Cab. Cond. heating [kW]');

    subplot(3,4,11)
    plot(data_ASHP{i}.Time, data_ASHP{i}.batteryCondenserHeating / 1e3);
    hold on
    ylabel('Bat. Cond. heating [kW]');

    subplot(3,4,12)
    plot(data_ASHP{i}.Time, data_ASHP{i}.condenserHeating / 1e3);
    hold on
    ylabel('Cond. heating [kW]');
end

%% Simulate WHR
clc
clear

% vehicle mass
mass = 20e3;

% simulate BEV WHR case
for i = 1:15
    disp(i);
    T_amb = 273.15 - i;
    sim('BEV_WHR',   20e3);
end
data_WHR = extractSDI(15);
% save('examples/ECOTS_paper1/BEV_data_WHR.mat', 'data_WHR');
save('examples/ECOTS_paper1/BEV_data_WHR_20t.mat', 'data_WHR');

%% plot check
% load BEV_data_WHR.mat;
load BEV_data_WHR_20t.mat;

figure;
for i = 1:15
    subplot(3,4,1)
    plot(data_WHR{i}.Time, data_WHR{i}.cabinHeaterPower / 1e3);
    hold on
    ylabel('Cab. heater [kW]');
        
    subplot(3,4,2);
    plot(data_WHR{i}.Time, data_WHR{i}.batteryTemperature);
    hold on
    ylabel('Bat. temp. [C]');

    subplot(3,4,3);
    plot(data_WHR{i}.Time, data_WHR{i}.cabinTemperature);
    hold on
    ylabel('Cab. temp. [C]');

    subplot(3,4,4);
    plot(data_WHR{i}.Time, data_WHR{i}.compressorPower / 1e3);
    hold on
    ylabel('Cmp. power [kw]');

    subplot(3,4,5)
    plot(data_WHR{i}.Time, data_WHR{i}.batteryCoolantTemperature);
    hold on
    ylabel('Bat. coolant temp. [C]');

    subplot(3,4,6)
    plot(data_WHR{i}.Time, data_WHR{i}.condenserSubcool);
    hold on
    ylabel('Subcooling [C]');

    subplot(3,4,7)
    plot(data_WHR{i}.Time, data_WHR{i}.motorChillerSuperheat);
    hold on
    ylabel('Superheating [C]');

    subplot(3,4,8)
    plot(data_WHR{i}.Time, data_WHR{i}.evaporatorPressure ./ 1e5);
    hold on
    ylabel('Evap. pressure [bar]');

    subplot(3,4,9)
    plot(data_WHR{i}.Time, data_WHR{i}.motorChillerHeating / 1e3);
    hold on
    ylabel('Evap. heating [kW]');

    subplot(3,4,10)
    plot(data_WHR{i}.Time, data_WHR{i}.cabinCondenserHeating / 1e3);
    hold on
    ylabel('Cab. Cond. heating [kW]');

    subplot(3,4,11)
    plot(data_WHR{i}.Time, data_WHR{i}.batteryCondenserHeating / 1e3);
    hold on
    ylabel('Bat. Cond. heating [kW]');

    subplot(3,4,12)
    plot(data_WHR{i}.Time, data_WHR{i}.condenserHeating / 1e3);
    hold on
    ylabel('Cond. heating [kW]');
end






