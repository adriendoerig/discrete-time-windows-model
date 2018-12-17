%Grid search to Fit data with WongWang, change one parameter at a time
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
wongWang_gain = 0.3;      % gain from boxes stage to decision stage
wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.4;       % wongWang "reactivity" -> high mu = "jumpy" network

%p = [wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'E4';
dataType2 = 'E8';
dataType3 = 'E18';
subjectNumber = 7;


%% vary wongWang_gain
for wongWang_gain = 0.1:0.05:.6
    p = [wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputWongWang(p, dataType, subjectNumber,['results/parameter_grid_search/E4_', num2str(p)]);
    plotOutputWongWang(p, dataType2, subjectNumber,['results/parameter_grid_search/E8_', num2str(p)]);
    plotOutputWongWang(p, dataType3, subjectNumber,['results/parameter_grid_search/E18_', num2str(p)]);
end
wongWang_gain = 0.3;

%% vary wongWang_sigma
for wongWang_sigma = 0.1:0.05:0.6
    p = [wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputWongWang(p, dataType, subjectNumber,['results/parameter_grid_search/E4_', num2str(p)]);
    plotOutputWongWang(p, dataType2, subjectNumber,['results/parameter_grid_search/E8_', num2str(p)]);
    plotOutputWongWang(p, dataType3, subjectNumber,['results/parameter_grid_search/E18_', num2str(p)]);
end
wongWang_sigma = 0.2;

%% vary wongWang_mu0
for wongWang_mu0 = 0.1:0.05:0.6
    p = [wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputWongWang(p, dataType, subjectNumber,['results/parameter_grid_search/E4_', num2str(p)]);
    plotOutputWongWang(p, dataType2, subjectNumber,['results/parameter_grid_search/E8_', num2str(p)]);
    plotOutputWongWang(p, dataType3, subjectNumber,['results/parameter_grid_search/E18_', num2str(p)]);
end
wongWang_mu0 = 0.2; 
