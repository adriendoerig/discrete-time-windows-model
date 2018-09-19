stimType = 'E4';
stimID = 1;

gain = 12;
stdev = 10;
mu0 = 12;

dt = .001;
stimuli = createStimuli(dt, stimType);
concatStimuli = cell(stimID,length(stimuli));
% transform boxed stimuli in a single continuous box
concatStimuli{stimID} = cat(2, stimuli{stimID}{:});
avgSuccess = 0;

% run nTrials trials
nTrials = 100;
decisions{stimID} = zeros(stimID,nTrials);
modelRTs{stimID} = decisions{stimID};

for n = 1:nTrials
    % take boxes stage output and add gain and noise
    wongWang_input = normrnd(gain.*concatStimuli{stimID}, stdev, [stimID, length(concatStimuli{stimID})]);
%             figure(stimID)
%             plot(wongWang_input)
%             drawnow
    % feed this to wongWang
    [decisions{stimID}(n), modelRTs{stimID}(n), success] = WongWangVaryingV(wongWang_input, mu0);
    modelRTs{stimID}(n) = modelRTs{stimID}(n)*dt; % in [s]
    avgSuccess = avgSuccess + success/nTrials;
end

avgModelDecisions = mean(decisions{stimID})*100;
avgRTs = mean(modelRTs{stimID});

disp(['Average decision = ', num2str(avgModelDecisions)])
disp(['Average success = ', num2str(avgSuccess)])
