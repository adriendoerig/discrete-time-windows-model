%Fit the averages
clear all; close all; clc;

% directory management
progPath = fileparts(which(mfilename)); % The program directory
cd(progPath) % go there just in case we are far away
addpath(genpath(progPath)); % add the folder and subfolders to path

% if there's no results directory, create one
if exist([progPath, '\results\'], 'dir') == 0
    mkdir('results');
end

if exist([progPath, '\results\fit_averages'], 'dir') == 0
    cd('./results')
    mkdir('fit_averages');
    cd(progPath)
end

% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.25;       % [s]
tauDecay = 0.45;           % [s]
wongWang_gain = 0.73;      % gain from boxes stage to decision stage
wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;       % wongWang "reactivity" -> high mu = "jumpy" network
%p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

subjectNumber = 7;
readoutTime = 0.45;


%% E4
dataType = 'E4';
for wongWang_gain = 0.6:0.01:0.8
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/fit_averages/E4_gain_', num2str(p)]);
end


%% E8
dataType = 'E8';
for wongWang_gain = 0.6:0.01:0.8
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/fit_averages/E8_gain_', num2str(p)]);
end

%% E18
dataType = 'E18';
for wongWang_gain = 0.6:0.01:0.8
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/fit_averages/E18_gain_', num2str(p)]);
end