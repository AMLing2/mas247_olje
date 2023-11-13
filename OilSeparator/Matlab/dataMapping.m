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

%% Open Loop Step Response
close all; clc;

% ------------------- PDT1 ----------------
figure
title("Oil Separator: Open Loop Step Response - PDT1")
xlabel("Time [seconds]")
hold on

yyaxis left
ylabel("Input")
plot(OpenLoopStepResponseV3.Time0/1000, ...
     OpenLoopStepResponseV3.Motor_ON_OFF, 'b--')
ylim([-0.12 1.05])

yyaxis right
ylabel("Measured Pressure [bar]")
plot(OpenLoopStepResponseV3.Time0/1000, ...
     OpenLoopStepResponseV3.PDT1bar, 'r-')
legend('Step Response', 'PDT1', 'Location', 'southeast')
ylim([0 0.31])
xlim([0 130.229])

% ------------------- LT2 ----------------
figure
title("Oil Separator: Open Loop Step Response - LT2")
xlabel("Time [seconds]")
hold on

ylabel("[%]")
plot(OpenLoopStepResponseV3.Time0/1000, ...
     100*OpenLoopStepResponseV3.Motor_ON_OFF, 'b--')

plot(OpenLoopStepResponseV3.Time0/1000, ...
     100*(OpenLoopStepResponseV3.LT2mm-42)/(155.42-42), 'r-')
%ylim([35 165])

legend('Step Response', 'LT2', 'Location', 'southeast')

% ------------------ Ziegler Nichols calculations ------------------
U = 100;
%dt = 0.01;          % [sec] step size
%stepTime = 9740;    % [ms]
%data = OpenLoopStepResponseV3.LT2mm;
%time = OpenLoopStepResponseV3.Time0/1000;   % [seconds]

%derivativeArray = [ 0; diff(data)/dt];
%[R, index] = max(derivativeArray);  % ----- RISE TIME R -----

%b = data(index) - R*time(index);  % y = R*x + b
%y = R * time + b;   % Value of derivative @ max
%ii = find(y > 42, 1);    % Find intersection of horisontal axis and y line
%L = time(ii) - stepTime;    % ----- DEAD TIME L -----

% Did readings instead from display, since the derivative skyrocketed with
% the noise.

%L = 40.86 - 9.74;
%L = 18.87 - 9.74;
L = 43.26 - 9.74;
%R = (110.48 - 74.97686)/(81.49 - 60.18);
%R = (105.1 - 40.09)/(0.26658 - 0.0797);
R = (56.2723 - 24.8485)/(78.57 - 57.8);

Kp = 1.2 / (L*R/U); % From formulas
Ti = 2*L;           % From formulas = Tn
Td = L/2;           % From formulas

% Display results:
table(Kp, Ti, Td)

% ------------------ Ziegler Nichols calculations ------------------

%% Mapping PDT2 to percent
close all;

%figure
%plot(