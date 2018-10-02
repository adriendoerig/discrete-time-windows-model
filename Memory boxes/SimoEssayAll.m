% E4
clear all; close all; clc;
% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.05;        % [s]
tauDecay = 1;               % [s]
wongWang_gain = 1;          % gain from boxes stage to decision stage
wongWang_sigma = .01;       % noise from boxes stage to decision stage
wongWang_mu0 = 1;          % wongWang "reactivity" -> high mu = "jumpy" network
p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'All';
subjectNumber = 7;
readoutTime = 0.45;

%call function
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);




