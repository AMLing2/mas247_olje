% clc; clear; close all;

%% Lecture 5 - Laboratory Exercise

% Plotting Three Tank Step Response (input = 1)
figure
title("Three Tank System: YT Scope Data")
xlabel("Time [seconds]")
ylabel("Height [meters]")

yyaxis left
plot(ThreeTankStepResponse.Time, ThreeTankStepResponse.Input, 'r');

yyaxis right
plot(ThreeTankStepResponse.Time, ThreeTankStepResponse.Height, 'b');

legend('Input value', 'Third tank', 'Location', 'southeast')

%% Calculations
clc;
L = 31.67 - 22.54;
dt = L;
dy = 0.15153 - .014817;
R = dy/dt;
U = 1;

Kp = 1.2/(L*R/U);
    Ti = 2*L;
    Td = 0.5*L;
Ki = Kp/Ti;
Kd = Td*Kp;
fprintf('\n Kp: %f\n Ti: %f\n Td: %f\n\n', Kp, Ti, Td)