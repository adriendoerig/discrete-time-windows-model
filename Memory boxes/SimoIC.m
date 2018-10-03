% All, find 'optimal' initial condition to use in 'SimoEssayAll'
clear all; close all; clc;
% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.204876118312500;       % [s]
tauDecay = 0.17;           % [s]
wongWang_gain = 0.204561344062500;      % gain from boxes stage to decision stage
wongWang_sigma = 0.204811396750000;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.204749724562500;       % wongWang "reactivity" -> high mu = "jumpy" network
p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'All';
subjectNumber = 7;
readoutTime = 0.8;
plotNumber = 1;

%call function
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, plotNumber);