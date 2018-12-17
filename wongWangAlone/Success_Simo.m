%success rate Wong Wang
%3 for each dataType: one everything at 50%, one what we expect, one what
%seems nice but probably just by chance
clear all; close all; clc;

dataType = 'E4';
dataType2 = 'E8';
dataType3 = 'E18';
subjectNumber = 7;

%p = [wongWang_gain, wongWang_sigma, wongWang_mu0];
p1 = [0.3,0.2,0.35];
p2 = [0.3,0.5,0.2];
p3 = [0.3,0.2,0.25];
p4 = [0.3,0.4,0.2];
p5 = [0.3,0.3,0.2];
p6 = [0.3,0.45,0.2];

successSum1 = plotOutputWongWang(p1, dataType, subjectNumber);
successSum2 = plotOutputWongWang(p2, dataType, subjectNumber);
successSum3 = plotOutputWongWang(p3, dataType2, subjectNumber);
successSum4 = plotOutputWongWang(p4, dataType2, subjectNumber);
successSum5 = plotOutputWongWang(p5, dataType3, subjectNumber);
successSum6 = plotOutputWongWang(p6, dataType3, subjectNumber);