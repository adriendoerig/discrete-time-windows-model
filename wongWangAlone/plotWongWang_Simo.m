%plot Output WongWang model
clear all; close all; clc;
% parameters necessary for plotOutputRuter function
wongWang_gain = 0.31;      % gain from boxes stage to decision stage
wongWang_sigma = 0.22;     % noise from boxes stage to decision stage
wongWang_mu0 = 0.2;       % wongWang "reactivity" -> high mu = "jumpy" network

p = [wongWang_gain, wongWang_sigma, wongWang_mu0];

dataType = 'E18';
subjectNumber = 7;

%call function
plotOutputWongWang(p, dataType, subjectNumber)