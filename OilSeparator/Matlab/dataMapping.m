clc; close all;

% Project - Oil Separator: Plotting

%% Test 1 - Tank 1

figure
title("Oil Separator: Data Logging - Tank 1 mapping")
xlabel("Time [seconds]")
hold on

yyaxis left
ylabel("Output [bits]")
plot(Test1Tank1.Time0, ...
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
axis([0 Test1Tank1.Time0(end) 3.7 17 ])

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