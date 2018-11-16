% Parameters from optimization
clear all; close all; clc;
% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.2048761;        % [s]
tauDecay = 0.2052579;               % [s]
wongWang_gain = 0.204561344;          % gain from boxes stage to decision stage
wongWang_sigma = 0.20481139;       % noise from boxes stage to decision stage
wongWang_mu0 = 0.20474972;          % wongWang "reactivity" -> high mu = "jumpy" network
p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'All';
subjectNumber = 7;

readoutTime = 0.475;

%call function
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);

%% All 
clear all; close all; clc;
% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.25;       % [s]
tauDecay = 0.45;           % [s]
wongWang_gain = 0.73;     % gain from boxes stage to decision stage
wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;       % wongWang "reactivity" -> high mu = "jumpy" network

p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'All';
subjectNumber = 7;
readoutTime = 0.475;

%call function
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);

%% Averages - tries
clear all; close all; clc;
% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.25;       % [s]
tauDecay = 0.45;           % [s]
wongWang_gain = 0.73;     % gain from boxes stage to decision stage
wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;       % wongWang "reactivity" -> high mu = "jumpy" network
p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'E18'; %options: 'E4', 'E8', 'E18'
subjectNumber = 7;
readoutTime = 0.475;

%call function
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);

%% Ruter
clear all; close all; clc;
% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.3;       % [s]
tauDecay = 0.45;           % [s]
wongWang_gain = 0.73;     % gain from boxes stage to decision stage
wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;       % wongWang "reactivity" -> high mu = "jumpy" network
p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'ruter';
subjectNumber = 7;
readoutTime = 0.475;

%call function
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);