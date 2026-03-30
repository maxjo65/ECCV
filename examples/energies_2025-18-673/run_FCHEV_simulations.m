clc
clear

% mass = 40e3;
% fc_current  = 320;

mass = 20e3;
fc_current  = 170;

% simulate FCHEV Base case
for i = 1:15
    disp(i);
    T_amb = 273.15 + 30 + i;
    sim('FCHEV_Base',   20e3);
end
data_Base= extractSDI(15);
% save('examples/ECOTS_paper1/FCHEV_data_Base.mat', 'data_Base');
save('examples/ECOTS_paper1/FCHEV_data_Base_20t.mat', 'data_Base');


%% plot check
% load FCHEV_data_Base.mat;
load FCHEV_data_Base_20t.mat;

figure;
for i = 1:10
    subplot(2,4,1)
    plot(data_Base{i}.Time, data_Base{i}.fuelCellTemperature);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,2)
    plot(data_Base{i}.Time, data_Base{i}.cabinTemperature);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,3)
    plot(data_Base{i}.Time, data_Base{i}.batteryTemperature);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,4)
    plot(data_Base{i}.Time, data_Base{i}.condenserSubcool);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,5)
    plot(data_Base{i}.Time, data_Base{i}.evaporatorSuperheat);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,6)
    plot(data_Base{i}.Time, data_Base{i}.compressorPower);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,7)
    plot(data_Base{i}.Time, data_Base{i}.fanPower);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,8)
    plot(data_Base{i}.Time, data_Base{i}.chillerCooling + data_Base{i}.evaporatorCooling);
    hold on
    ylabel('FC. Temp [C]');

end

%% 

clc
clear


% mass = 40e3;
% fc_current  = 320;


mass = 20e3;
fc_current  = 170;

% simulate FCHEV Side radiator case
for i = 1:15
    disp(i);
    T_amb = 273.15 + 30 + i;
    sim('FCHEV_sideRadiator',   20e3);
end
data_Side= extractSDI(15);
% save('examples/ECOTS_paper1/FCHEV_data_Side.mat', 'data_Side');
save('examples/ECOTS_paper1/FCHEV_data_Side_20t.mat', 'data_Side');


%% plot check
% load FCHEV_data_Side.mat;
load FCHEV_data_Side_20t.mat;


figure;
for i = 1:15
    subplot(2,4,1)
    plot(data_Side{i}.Time, data_Side{i}.fuelCellTemperature);
    hold on
    ylabel('FC. Temp [C]');

        subplot(2,4,2)
    plot(data_Side{i}.Time, data_Side{i}.cabinTemperature);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,3)
    plot(data_Side{i}.Time, data_Side{i}.batteryTemperature);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,4)
    plot(data_Side{i}.Time, data_Side{i}.condenserSubcool);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,5)
    plot(data_Side{i}.Time, data_Side{i}.evaporatorSuperheat);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,6)
    plot(data_Side{i}.Time, data_Side{i}.compressorPower);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,7)
    plot(data_Side{i}.Time, data_Side{i}.fanPower);
    hold on
    ylabel('FC. Temp [C]');

    subplot(2,4,8)
    plot(data_Side{i}.Time, data_Side{i}.chillerCooling + data_Side{i}.evaporatorCooling);
    hold on
    ylabel('FC. Temp [C]');
end


%% Results





















