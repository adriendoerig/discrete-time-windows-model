% plot success rate: put success=0 in WongWangBoxes
%add output [successSum, successSum2] to
%plotOutputNonDtimeChooseReadoutTime function and delete it afterwards!
clear all; close all; clc;

tauIntegrate = 0.3;       % [s]
tauDecay = 0.45;           % [s]
wongWang_gain = 0.73;     % gain from boxes stage to decision stage
wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;       % wongWang "reactivity" -> high mu = "jumpy" network

p = [tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0];

subjectNumber = 7;
readoutTime = 0.475;

%% 2 window model
% dataType = 'E18';
% plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, ['results/successRate/E18_', num2str(p)]);
% 
dataType = 'All';
[successSumAll, successSumAll_2] = plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);

%% use 1 window model with explosion_informed data
dataType = 'E4';
[successSumE4, successSumE4_2] = plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);

dataType = 'E8';
[successSumE8, successSumE8_2] = plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);

dataType = 'E18';
[successSumE18, successSumE18_2] = plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);

% dataType = 'ruter';
% successSumRuter = plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime);
% 
% dataType = 'ruter';
% readoutTime2 = .1056;
% successSumRuter2 = plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime2);