% clc; clear; close all;

%% Lecture 4 - Laboratory Exercise

% Three Tank System

    %   Either import with MATLAB Wizard, or the script commented out
    %   below. (didn't get script to work..) Saved the workspace, so just
    %   load that .mat file.

% filename = 'ThreetankData.csv';
% opts.DataLines = [25 Inf];
% opts.VariableNames = [{'Time'} {'Height'} {'TimeInput'} {'Input'}];
% opts = detectImportOptions(filename);
% ThreetankData = readtable(filename, opts);

figure
title("Three Tank System: YT Scope Data")
xlabel("Time [seconds]")
ylabel("Height [meters]")

yyaxis right
plot(ThreetankData.Time, ThreetankData.Input, 'r');

yyaxis left
plot(ThreetankData.Time, ThreetankData.Height, 'b');

legend('Input value', 'Third tank')