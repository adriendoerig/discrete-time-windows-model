%Grid search to Fit Leila data with Ruter model, change one parameter at a time
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
wongWang_gain = 0.46;     % gain from boxes stage to decision stage
wongWang_mu0 = 0.55;      % wongWang "reactivity" -> high mu = "jumpy" network

dataType1 = 'ruter';
dataType = 'E4';
dataType2 = 'E8';
dataType3 = 'E18';
subjectNumber = 7;
tStart = 0.475;
tStart2 = 0.1056;

p = [tauIntegrate, wongWang_gain, wongWang_mu0];
plotOutputRuter(p, dataType1, subjectNumber, tStart, ['results/parameter_grid_search/ruter_', num2str(p)]);
plotOutputRuter(p, dataType, subjectNumber, tStart, ['results/parameter_grid_search/E4_', num2str(p)]);
plotOutputRuter(p, dataType2, subjectNumber, tStart, ['results/parameter_grid_search/E8_', num2str(p)]);
plotOutputRuter(p, dataType3, subjectNumber, tStart, ['results/parameter_grid_search/E18_', num2str(p)]);
plotOutputRuter(p, dataType, subjectNumber, tStart2, ['results/parameter_grid_search/E4_tStart0.1056_', num2str(p)]);
plotOutputRuter(p, dataType2, subjectNumber, tStart2, ['results/parameter_grid_search/E8_tStart0.1056_', num2str(p)]);
plotOutputRuter(p, dataType3, subjectNumber, tStart2, ['results/parameter_grid_search/E18_tStart0.1056_', num2str(p)]);

%plotOutputRuter(p, dataType, subjectNumber,tStart,['results/parameter_grid_search/All']);


%% vary tauIntegrate
% for tauIntegrate = 0.49:0.01:.55
%     p = [tauIntegrate, wongWang_gain, wongWang_mu0];
%     %call function
%     plotOutputRuter(p, dataType, subjectNumber, tStart, ['results/parameter_grid_search/E4_', num2str(p)]);
%     plotOutputRuter(p, dataType2, subjectNumber, tStart, ['results/parameter_grid_search/E8_', num2str(p)]);
%     plotOutputRuter(p, dataType3, subjectNumber, tStart, ['results/parameter_grid_search/E18_', num2str(p)]);
% end
% tauIntegrate = 0.47; 
% 
% %% vary gain
% for wongWang_gain = 0.43:0.01:.49
%     p = [tauIntegrate, wongWang_gain, wongWang_mu0];
%     %call function
%     plotOutputRuter(p, dataType, subjectNumber, tStart, ['results/parameter_grid_search/E4_', num2str(p)]);
%     plotOutputRuter(p, dataType2, subjectNumber, tStart, ['results/parameter_grid_search/E8_', num2str(p)]);
%     plotOutputRuter(p, dataType3, subjectNumber, tStart, ['results/parameter_grid_search/E18_', num2str(p)]);
% end
% tauIntegrate = 0.47; 
% 
% %% vary wongWang_mu0
% for wongWang_mu0 = 0.49:0.01:.55
%      p = [tauIntegrate, wongWang_gain, wongWang_mu0];
%     %call function
%     plotOutputRuter(p, dataType, subjectNumber,tStart,['results/parameter_grid_search/E4_', num2str(p)]);
%     plotOutputRuter(p, dataType2, subjectNumber,tStart,['results/parameter_grid_search/E8_', num2str(p)]);
%     plotOutputRuter(p, dataType3, subjectNumber,tStart,['results/parameter_grid_search/E18_', num2str(p)]);
% end
% wongWang_mu0 = 0.55; 