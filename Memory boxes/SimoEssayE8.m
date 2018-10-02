% E8
clear all; close all; clc;
% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
tauIntegrate = 0.38315862957120006;        % [s]
tauDecay = 0.37261617388800006;               % [s]
wongWang_gain = 0.37386175457119997;          % gain from boxes stage to decision stage
wongWang_sigma = 0.3754550027312;       % noise from boxes stage to decision stage
wongWang_mu0 = 0.3720957379952001;          % wongWang "reactivity" -> high mu = "jumpy" network
p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'E8';
subjectNumber = 7;
readoutTime = 0.8;

%call function
plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);
