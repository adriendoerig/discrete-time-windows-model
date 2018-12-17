%parameters role
clear all; close all; clc;

% directory management
progPath = fileparts(which(mfilename)); % The program directory
cd(progPath) % go there just in case we are far away
addpath(genpath(progPath)); % add the folder and subfolders to path

% if there's no results directory, create one
if exist([progPath, '\results\'], 'dir') == 0
    mkdir('results');
end

if exist([progPath, '\results\parameter_role'], 'dir') == 0
    cd('./results')
    mkdir('parameter_role');
    cd(progPath)   
end

% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.3;       % [s]
tauDecay = 0.45;           % [s]
wongWang_gain = 0.73;     % gain from boxes stage to decision stage
wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;      % wongWang "reactivity" -> high mu = "jumpy" network

dataType = 'All';
subjectNumber = 7;
readoutTime = 0.475;

%p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
%plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/parameter_grid_search/All']);

%% vary tauIntegrate
% for tauIntegrate = [0.05 0.3 0.8]
%     p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
%     %call function
%     plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/parameter_role/tauIntegrate_', num2str(tauIntegrate)]);
% end
% tauIntegrate = 0.3; 

%% vary tauDecay
for tauDecay = [0.1 0.45 0.9]
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/parameter_role/tauDecay_', num2str(tauDecay)]);
end
%tauDecay = 0.205257993312500;
tauDecay = 0.45;  

%% vary wongWang_gain
for wongWang_gain = [0.1 0.73 1]
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/parameter_role/wongWang_gain_', num2str(wongWang_gain)]);
end
%wongWang_gain = 0.204561344062500; 
wongWang_gain = 0.73;

%% vary wongWang_sigma
for wongWang_sigma = [0.05 0.2 0.8]
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/parameter_role/wongWang_sigma_', num2str(wongWang_sigma)]);
end
%wongWang_sigma = 0.204811396750000;
wongWang_sigma = 0.2;

%% vary wongWang_mu0
for wongWang_mu0 = [0.05 0.2 0.8]
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime,['results/parameter_role/wongWang_mu0_', num2str(wongWang_mu0)]);
end
%wongWang_mu0 = 0.204749724562500;
wongWang_mu0 = 0.2; 