%run single stim
%set plotMemoryTraces=1 in MEMORYBOXESDYNAMICSDIFFERENTDURATIONS 
% to see the memories unfold. But CAREFUL! Switch it back to 0
% subsequently.
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
stimID = 7;

%call function
runSingleStim(p, dataType, subjectNumber, readoutTime, stimID)