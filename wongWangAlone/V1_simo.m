%try to fit 1st vernier with a bigger mu0
clear all; close all; clc;
% parameters necessary for plotOutputNoNDtimeChooseReadoutTime function
wongWang_gain = 0.3;      % gain from boxes stage to decision stage
wongWang_sigma = 0.2;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;       % wongWang "reactivity" -> high mu = "jumpy" network
p = [wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'E4';
dataType2 = 'E8';
dataType3 = 'E18';
subjectNumber = 7;


%successSum1 = plotOutputWongWang(p, dataType, subjectNumber);
%successSum2 = plotOutputWongWang(p, dataType2, subjectNumber);
successSum3 = plotOutputWongWang(p, dataType3, subjectNumber);