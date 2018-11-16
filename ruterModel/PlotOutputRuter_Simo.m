%plot Output Ruter model
clear all; close all; clc;
% parameters necessary for plotOutputRuter function
tauIntegrate = 0.25;       % [s]
%tauDecay = 0.45;           % [s]
wongWang_gain = 0.4;     % gain from boxes stage to decision stage
%wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;       % wongWang "reactivity" -> high mu = "jumpy" network

p = [tauIntegrate, wongWang_gain, wongWang_mu0];

dataType = 'E4';
subjectNumber = 7;
tStart = 0.1056;

%call function

plotOutputRuter(p, dataType, subjectNumber, tStart)