%Grid search to Fit Ruter data with Ruter model, change one parameter at a time
clear all; close all; clc;

% directory management
progPath = fileparts(which(mfilename)); % The program directory
cd(progPath) % go there just in case we are far away
addpath(genpath(progPath)); % add the folder and subfolders to path

% if there's no results directory, create one
if exist([progPath, '\results\'], 'dir') == 0
    mkdir('results');
end

if exist([progPath, '\results\parameter_grid_search'], 'dir') == 0
    cd('./results')
    mkdir('parameter_grid_search');
    cd(progPath)    
end

% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.53;       % [s]         
wongWang_gain = 0.52;     % gain from boxes stage to decision stage
wongWang_mu0 = 0.55;      % wongWang "reactivity" -> high mu = "jumpy" network

dataType = 'ruter';
subjectNumber = 7;
tStart = 0.1056;
tStart2 = 0.475;

%p = [tauIntegrate, wongWang_gain, wongWang_mu0];
%plotOutputRuter(p, dataType, subjectNumber,tStart,['results/parameter_grid_search/All']);


%% vary tauIntegrate
for tauIntegrate = 0.4:0.01:0.6
    p = [tauIntegrate, wongWang_gain, wongWang_mu0];
    %call function
    plotOutputRuter(p, dataType, subjectNumber,tStart,['results/parameter_grid_search/tStart_0.1056_', num2str(p)]);
    plotOutputRuter(p, dataType, subjectNumber,tStart2,['results/parameter_grid_search/tStart_0475', num2str(p)]);
end
tauIntegrate = 0.53;  

%% vary wongWang_gain
for wongWang_gain = 0.4:0.01:.6
    p = [tauIntegrate, wongWang_gain, wongWang_mu0];
    %call function
    plotOutputRuter(p, dataType, subjectNumber,tStart,['results/parameter_grid_search/tStart_0.1056_', num2str(p)]);
    plotOutputRuter(p, dataType, subjectNumber,tStart2,['results/parameter_grid_search/tStart_0475', num2str(p)]);
end
wongWang_gain = 0.52;

%% vary wongWang_mu0
for wongWang_mu0 = 0.4:0.01:0.6
    p = [tauIntegrate, wongWang_gain, wongWang_mu0];
    %call function
    plotOutputRuter(p, dataType, subjectNumber,tStart,['results/parameter_grid_search/tStart_0.1056_', num2str(p)]);
    plotOutputRuter(p, dataType, subjectNumber,tStart2,['results/parameter_grid_search/tStart_0475', num2str(p)]);
end
wongWang_mu0 = 0.55; 
