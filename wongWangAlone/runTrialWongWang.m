function [decision, RT, success] = runTrialWongWang(stimulus, dt, wongWang_gain, wongWang_sigma, wongWang_mu0)
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
% wangWang_gain: gain from summed box activity to wongWang input
% wongWang_sigma: noise from summed box activity to wongWang input
% wongWang_mu0: reactivity of the wongWang stage. high mu0 means that
%     small differences in initial conditions lead to quick, random decisions

    

% take boxes stage output and add gain and noise
wongWang_input = normrnd(wongWang_gain*stimulus, wongWang_sigma, [1, length(stimulus)]);

% feed this to wongWang
[decision, DT, success] = WongWangVaryingV(wongWang_input, wongWang_mu0);
RT = DT*dt; % in [s]