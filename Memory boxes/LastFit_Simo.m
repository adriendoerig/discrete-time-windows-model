%Fit All, E4, E8, E18, ruter all with same parameters
clear all; close all; clc;

% directory management
progPath = fileparts(which(mfilename)); % The program directory
cd(progPath) % go there just in case we are far away
addpath(genpath(progPath)); % add the folder and subfolders to path

% if there's no results directory, create one
if exist([progPath, '\results\'], 'dir') == 0
    mkdir('results');
end

if exist([progPath, '\results\figures_report'], 'dir') == 0
    cd('./results')
    mkdir('figures_report');
    cd(progPath)
end

tauIntegrate = 0.3;       % [s]
tauDecay = 0.45;           % [s]
wongWang_gain = 0.73;     % gain from boxes stage to decision stage
wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;       % wongWang "reactivity" -> high mu = "jumpy" network

p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

subjectNumber = 7;
readoutTime = 0.475;

%%
dataType = 'E4';
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/figures_report/E4_', num2str(p)]);

dataType = 'E8';
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/figures_report/E8_', num2str(p)]);

dataType = 'E18';
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/figures_report/E18_', num2str(p)]);

dataType = 'All';
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/figures_report/All_', num2str(p)]);

dataType = 'ruter';
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/figures_report/Ruter_', num2str(p)]);

dataType = 'ruter';
readoutTime2 = .1056;
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime2, ['results/figures_report/Ruter_0.1056_', num2str(p)]);