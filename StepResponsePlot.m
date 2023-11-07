clc; close all; clear;

csvread("KlippetData.csv");


grid on
hold on
plot(ans(:,1)/1000,ans(:,2), 'LineWidth', 2) %I sekund
plot(ans(:,1)/1000,ans(:,4) - 0.083, 'LineWidth', 2) 

xlabel('Tid (s)');
ylabel('Verdi (bits?)')