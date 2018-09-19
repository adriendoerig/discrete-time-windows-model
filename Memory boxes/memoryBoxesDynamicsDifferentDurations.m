function [ summedBoxOutputs ] = memoryBoxesDynamicsDifferentDurations( stimulus, tauIntegrate, tauDecay, readoutTime, simulationTime, dt)
%MEMORYBOXESDYNAMICS Manages the memory boxes and returns their output
% Parameters:
% inputSequence : vector of 1, 0 & -1: 1 for vernier, -1 for anti-vernier
% inputGain     : "strength" of input
% tau           : time constant
% dt            : time step [s]
% varargin      : you may include an initial  value (default = 0)% to play around

plottingMemoryTraces = 0;                           % plots box traces if set to 1.

nBoxes = length(stimulus);
boxLength = zeros(1,nBoxes);
for i = 1:nBoxes
    boxLength(i) = length(stimulus{i})*dt;          % [s]
end
memoryTraces = zeros(nBoxes, simulationTime/dt);    % will store memory traces in each box
summedBoxOutputs = 0;                               % will store final result

% all boxes go (all the round() functions are to avoid matlab changing n to
% n.00000 when dividing by dt. 
for i = 1:nBoxes
    
    if i == 1
        % integration
        [integrationOutput,memoryTraces(i,1:boxLength(1)/dt)] = boxIntegrate(stimulus{i},tauIntegrate,dt);
        % decay
        memoryTraces(i,boxLength(1)/dt+1:end) = boxDecay(integrationOutput,simulationTime-boxLength(1), tauDecay, dt);
    else
        % integration
        [integrationOutput,memoryTraces(i,round(sum(boxLength(1:i-1))/dt+1):round(sum(boxLength(1:i))/dt))] = boxIntegrate(stimulus{i},tauIntegrate,dt);
        % decay
        memoryTraces(i,round(sum(boxLength(1:i))/dt+1):end) = boxDecay(integrationOutput,simulationTime-sum(boxLength(1:i)), tauDecay, dt);
    end

    % summing box states at readout time.
    summedBoxOutputs = summedBoxOutputs+memoryTraces(i,round(readoutTime/dt));
    
end

if plottingMemoryTraces
    figure(1000)
    for i = 1:nBoxes
        subplot(nBoxes,1,i)
        plot(1:length(memoryTraces(i,:)), memoryTraces(i,:))
        line([readoutTime/dt, readoutTime/dt], [-.05 .05], 'Color', 'g');
        mtit(['Memory boxes in temporal order. Summed value for decision stage = ', num2str(summedBoxOutputs)])
    end
end

