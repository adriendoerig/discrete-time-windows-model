function [decision, RT, success] = runTrial(simulationTime, stimulus, dt, NDtime, readoutTime, tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0)
% RUNTRIAL simulates performance on one trial and returns the answer and
% RT.
%
% Note: to plot memory traces and wongWangBoxes output, go to these
% functions and set plotting to 1.
%
% simulationTime: total time to simulate [s]
% stimulus: specifies the stimulus (a sequence of -1 = AV, 0 = no vernier and 
%     1 = V. One number per dt.
% dt: time step [s]
% NDtime: non-decisional time
% readoutTime: time of readout [s]
% tauIntegrate: timescale for integration in boxes
% tauDecay: timescale for decay in boxes
% wangWang_gain: gain from summed box activity to wongWang input
% wongWang_sigma: noise from summed box activity to wongWang input
% wongWang_mu0: reactivity of the wongWang stage. high mu0 means that
%     small differences in initial conditions lead to quick, random decisions

    
    
% compute dynamics of the memory boxes 
summedBoxOutputs = memoryBoxesDynamicsDifferentDurations( stimulus, tauIntegrate, tauDecay, readoutTime, simulationTime, dt);

% take boxes stage output and add gain and noise
wongWang_input = normrnd(wongWang_gain*summedBoxOutputs, wongWang_sigma);

% feed this to wongWang
[decision, DT, success] = WongWangBoxes(wongWang_input, wongWang_mu0);
RT = DT*dt + readoutTime + NDtime; % in [s]