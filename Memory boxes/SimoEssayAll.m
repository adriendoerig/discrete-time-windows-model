% All, change one parameter at a time
clear all; close all; clc;

% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.204876118312500;       % [s]
tauDecay = 0.205257993312500;           % [s]
wongWang_gain = 0.204561344062500;      % gain from boxes stage to decision stage
wongWang_sigma = 0.204811396750000;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.204749724562500;       % wongWang "reactivity" -> high mu = "jumpy" network

dataType = 'All';
subjectNumber = 7;
readoutTime = 0.45;
plotNumber = 1;

%% vary tauIntegrate
for tauIntegrate = 0.1:0.1:1
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, plotNumber);
    plotNumber = plotNumber+1;
end
tauIntegrate = 0.204876118312500;  

%% vary tauDecay
for tauDecay = 0.1:0.1:1
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, plotNumber);
    plotNumber = plotNumber+1;
end
tauDecay = 0.205257993312500;

%% vary wongWang_gain
for wongWang_gain = 0.1:0.1:1
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, plotNumber);
    plotNumber = plotNumber+1;
end
wongWang_gain = 0.204561344062500; 

%% vary wongWang_sigma
for wongWang_sigma = 0.1:0.1:1
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, plotNumber);
    plotNumber = plotNumber+1;
end
wongWang_sigma = 0.204811396750000;

%% vary wongWang_mu0
for wongWang_mu0 = 0.1:0.1:1
    p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];
    %call function
    plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, plotNumber);
    plotNumber = plotNumber+1;
end
wongWang_mu0 = 0.204749724562500;


