% plots each memory box from a stimulus (which is created by the
% createStimulus function)

stimuli = createStimuli(dt, 'Expt2a'); % second argument determines which experimental stimulus set is created
stimID = 1; % stimuli contains all the stimuli from the chosen experiment. stimID chooses which of these to plot
stimulus = stimuli{stimID};
nBoxes = length(stimulus);

for box = 1:nBoxes
    subplot(nBoxes,1,i)
    plot(1:length(memoryTraces(i,:)), memoryTraces(i,:))
    line([readoutTime/dt, readoutTime/dt], [-.05 .05], 'Color', 'g');
    mtit(['Memory boxes in temporal order. Summed value for decision stage = ', num2str(summedBoxOutp
end