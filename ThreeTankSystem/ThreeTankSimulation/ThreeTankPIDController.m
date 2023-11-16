% clc; clear; close all;

%% Lecture 5 - Laboratory Exercise

% Plotting Three Tank Step Response (input = 1)
figure
title("Three Tank System: YT Scope Data")
xlabel("Time [seconds]")
ylabel("Height [meters]")

hold on
yyaxis left
plot(ThreeTankPIDController.TimeSP, ...
    ThreeTankPIDController.setPoint, '--b');
plot(ThreeTankPIDController.TimeSP, ...
    ThreeTankPIDController.Height, '-g');
yyaxis right
plot(ThreeTankPIDController.TimeSP, ...
    ThreeTankPIDController.OutputPID, '-', Color=[0.8500 0.3250 0.0980]);

legend('Set Point', 'Third tank', 'PID Output', 'Location', 'southeast')
