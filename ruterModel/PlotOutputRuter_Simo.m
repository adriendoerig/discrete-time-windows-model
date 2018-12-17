%plot Output Ruter model
clear all; close all; clc;
% parameters necessary for plotOutputRuter function
tauIntegrate = 0.5;       % [s]         
wongWang_gain = 0.49;     % gain from boxes stage to decision stage
wongWang_mu0 = 0.55;            % wongWang "reactivity" -> high mu = "jumpy" network

p1 = [tauIntegrate, wongWang_gain, wongWang_mu0];

dataType = 'ruter';
subjectNumber = 7;
tStart = 0.1056;
tStart2 = 0.475;

%call function
plotOutputRuter(p1, dataType, subjectNumber, tStart)
%plotOutputRuter(p1, dataType, subjectNumber, tStart2, ['results/parameter_grid_search/ruter_', num2str(p1)]);

%p2 = [0.47, 0.52, 0.55];
%successSumRuter2 = plotOutputRuter(p2, dataType, subjectNumber, tStart, ['results/parameter_grid_search/ruter_', num2str(p2)]);