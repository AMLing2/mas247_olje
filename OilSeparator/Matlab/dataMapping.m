clc; close all;

% Project - Oil Separator: Plotting

%% Test 1 - Tank 1
close all;

figure
title("Oil Separator: Data Logging - Tank 1 mapping")
xlabel("Time [seconds]")
hold on

yyaxis left
ylabel("Output [bits]")
plot(Test1Tank1.Time0/1000, ...
    Test1Tank1.LT1percent, '-b');

yyaxis right
ylabel("Measured height [cm]")
yline(0, '--r');
yline(4.4, '--r');
yline(5.7, '--r');
yline(9.1, '--r');
yline(11.1, '--r');
yline(15.1, '--r');
yline(16.9, '--r');
axis([0 Test1Tank1.Time0(end)/1000 3.7 17 ])

legend('Level Transmitter 1', 'Location', 'southeast')

%% Test 2 - Tank 2, water section

figure
title("Oil Separator: Data Logging - Tank 2 mapping")
xlabel("Time [seconds]")
hold on

yyaxis left
ylabel("Output [bits]")
plot(Test2Tank2.Time0, ...
    Test2Tank2.LT2percent, '-b');

yyaxis right
ylabel("Measured height [cm]")
yline(0, '--r')
axis([0 Test2Tank2.Time0(end) 0 17 ])

legend('Level Transmitter 2', 'Location', 'southeast')

%% Sanity Check for h_water & h_oil
clc; close all;
format long
rhoWater = 998;
rhoOil   = 857;
g = 9.80665;
PDTmax = 0.4;
PDTmin = 0.004;
dPDT = PDTmax-PDTmin;
bitMax = 2^15 - 1;
bitMin = 700;
dBit = bitMax;
A = 1/(g*(rhoWater - rhoOil));
B = rhoOil/(rhoWater - rhoOil);
C = 1-29/30.8;
R = 0.9/33.22;
% Variables to change
    PDT1bit = 14290;
    LT2mm   = 87;
% Variables to change
LT2m = LT2mm/1000;
PDT1bar = PDT1bit*(dPDT*R/dBit);
PDT1Pa  = PDT1bar*10^5;
    PDT1calc = rhoWater*g*LT2m;

h_water = ((PDT1Pa*A) - (LT2m*B))*1000.0;

    table(PDT1Pa, PDT1calc);
    Cinv = PDT1Pa/PDT1calc;
    C1 = 19.968619416961648;
    C2 = 20.282442997341011;
    C3 = 19.831767100422518;
    C_fin = (C1+C2+C3)/3;

    h_waterTC1 = ( (PDT1bar * (100000.0) * A)  - (LT2mm * (1.0/1000.0) * B))*1000.0;
    h_water2 = (PDT1Pa*(1/(g*(rhoOil-rhoWater))) - LT2m*(rhoWater/(rhoOil-rhoWater)))*1000
    h_water1 = (PDT1Pa*(1/(g*(rhoWater-rhoOil))) - LT2m*(rhoOil/(rhoWater-rhoOil)))*1000
h_oil = LT2m*1000 - h_water;
h_tot = h_water + h_oil;
format short
table(h_water, h_oil, h_tot)

%% Clean Water Calibration
close all;
figure(Name='Clean Water Calibration')

SensorBit = [726, 2940, 4780, 7150, 9740, 13035, 14970, 17110, 18135];
hMeasured = [0, 26, 37, 52, 69, 89, 101, 115, 122]; 

SensorBit2 = [2940, 4780, 7150, 9740, 13035, 14970, 17110, 18135];
hMeasured2 = [26, 37, 52, 69, 89, 101, 115, 122];
pMeasured2 = rhoWater*g*hMeasured2/1000.0;

rhoWater = 998; % [kg/m^3]
g = 9.80665;    % [m/s^2]
pMeasured = rhoWater*g*hMeasured/1000.0;

plot(SensorBit, pMeasured)
xlabel('[bit]')
ylabel('[Pa]')

dx = SensorBit(end) - SensorBit(2);
dy = pMeasured(end) - pMeasured(2);
slope = dy/dx;

figure(Name='Linear Regression')
y = slope*SensorBit;
plot(SensorBit, y)

C = y(end) - SensorBit(end)*slope;

y2 = slope*(SensorBit+SensorBit(1));

k = 0.06172;
b = 69.67;
y3 = k*SensorBit + b;

figure(Name='Final both')
hold on
plot(SensorBit, pMeasured)
plot(SensorBit, y3)
xlabel('[bit]')
ylabel('[Pa]')
legend('Measurements', 'Linear regression', 'Location','southeast')
title('PDT1: Linear Regression with Clean Water')

%% Ziegler Nichols tuning: Thursday

LT2min = 43.4;
LT2max = 156.84;

figure(Name='Ziegler Nichols Tuning: LV1 in, LT2 out')
title("Ziegler Nichols Tuning: LV1 in, LT2 out")
xlabel("Time [seconds]")
hold on

ylabel("[%]")

plot(ZieglerNicholsThursday.Time0/1000, ...
     ZieglerNicholsThursday.Level_Valve_1_Percentage)

plot(ZieglerNicholsThursday.Time0/1000, ...
     100*(ZieglerNicholsThursday.LT2mm-LT2min)/(LT2max-LT2min), 'r-')

xlim([33 212])
ylim([-5 105])
legend('Step Response', 'LT2', 'Location', 'southeast')


% ------------------ Ziegler Nichols calculations ------------------
    % Read from graph
U = 100;
L = 66.62 - 53.25;
dy = 58.52 - 23.46;
dx = 133.87 - 98.98;
R = dy/dx;

Kp = 1.2 / (L*R/U); % From formulas
Tn = 2*L;           % From formulas = Tn
Tv = L/2;           % From formulas

Ki = Kp/Tn;
Kd = Tv/Kp;

% Display results:
table(Kp, Tn, Tv, Ki, Kd)   % Tn = Ti, Tv = Td

% ------------------ Ziegler Nichols calculations ------------------

%% Old math model

close all; clc;

figure(Name='Mathematical Model')
title('Mathematical Model: Differential Equations')

modell = readtable("TankData.csv");
empirisk = readtable("OpenFlow.csv");

modellPlot = table2array(modell);
empiriskPlot = table2array(empirisk);

hold on
plot(modellPlot(:,1)/1000,modellPlot(:,2), LineWidth=2);
plot((empiriskPlot(:,1)-34290)/1000,empiriskPlot(:,2), LineWidth=1.5);

plot(modellPlot(:,1)/1000,modellPlot(:,3), LineWidth=2);
plot((empiriskPlot(:,1)-34290)/1000,empiriskPlot(:,4), LineWidth=1.5);

legend('Model Tank 1', 'Measurements Tank 1', ...
       'Model Tank 2', 'Measurements Tank 2', 'Location','best')
xlabel('Time [seconds]')
ylabel('Height [mm]')
xlim([-1 115])

%% Mathematical Model - Differential Equations

close all; clc;

tank1Areal = 1;
tank2Areal = 1;
tank1h = 0.1; 
tank2h = 0.1; 
tank1k = 8000;
tank2k = tank1k/6.89; 
tank1input = 340000.0; 
deltaT = 0.01;
time = 0;
t = time : deltaT : 120;

L1 = 600;
L2 = 740;
R = 285/2;

tank1Vec = 0 : deltaT : 120;
tank2Vec = 0 : deltaT : 120;
for i = 1 : 12000
    % Area calculations - discrete volume integral
    tank1Areal = 1 + 2 * L1 * sqrt( ( 1 - ((tank1h - R)/R)^2 ) * (R^2) ); 
    tank2Areal = 1 + 2 * L2 * sqrt( ( 1 - ((tank2h - R)/R)^2 ) * (R^2) ); 
    
    tank1h = tank1h + deltaT*(tank1input - tank1k*tank1h)/tank1Areal;
    tank2h = tank2h + deltaT*(tank1k*tank1h - tank2k*tank2h)/tank2Areal;
    
    tank1Vec(i) = tank1h;
    tank2Vec(i) = tank2h;
end

% Name = time, varname4 = LT1mm height
figure(Name='MathModelV2')
hold on
plot(t, tank1Vec, LineWidth=2);
plot((empiriskPlot(:,1)-34290)/1000,empiriskPlot(:,2), LineWidth=1.5);

plot(t, tank2Vec, LineWidth=2);
plot((empiriskPlot(:,1)-34290)/1000,empiriskPlot(:,4), LineWidth=1.5);

legend('Model Tank 1', 'Measurements Tank 1', ...
       'Model Tank 2', 'Measurements Tank 2', 'Location','best')
xlabel('Time [seconds]')
ylabel('Height [mm]')
xlim([-1 115])