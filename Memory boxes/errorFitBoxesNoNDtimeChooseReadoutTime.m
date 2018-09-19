function [err] = errorFitBoxesNoNDtimeChooseReadoutTime(p, data, stimType, readoutTime)
% Compute the error of the model prediction WITHOUT CARING ABOUT TND
% Use with p0 = [...,...,...]; 
% pOptimized = fminsearch(error,p0)

% p(1) = tauIntegrate
% p(2) = tauDecay
% p(3) = wongWang_gain
% p(4) = wongWang_sigma
% p(5) = wongWang_mu0

    pT = pTransformNoNDtimeChooseReadoutTime(p); %Transforms the parameter vector such that all values to optimize vary between 0 and 1.
    
    % just an iteration counter
    global nruns;
    nruns = nruns + 1;
    disp('')
    disp(['This is iteration ', num2str(nruns)])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get empirical data for all conditions
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    avgExpDecisions = data';
    expRTs = []; % we don't have any RTs in this experiment, but maybe in the future
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get model simulations for all conditions
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % define stimuli here
    elementDuration = 0.02;
    isiDuration = 0.02;
    dt = .001;

    stimuli = createStimuli(dt, stimType);
    
    % model outputs
    conds = length(avgExpDecisions);
    decisions = cell(1,conds);
    modelRTs = decisions;
    avgModelDecisions = zeros(1,conds);
    avgRTs = zeros(1,conds);
    successSum = 0;
    
    for i = 1:conds
        
        % run nTrials trials
        nTrials = 160;
        decisions{i} = zeros(1,nTrials);
        modelRTs{i} = decisions{i};
        
        for n = 1:nTrials
            [decisions{i}(n), modelRTs{i}(n), success] = runTrial(1, stimuli{i}, dt, ...
                0, readoutTime, pT(1), pT(2), pT(3), pT(4), pT(5));
            successSum = successSum + success;
        end

        avgModelDecisions(i) = mean(decisions{i})*100;
        avgRTs(i) = mean(modelRTs{i});    
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute error
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % the data is not formatted in the same way in rüter and leila's data
    % nothing important, just a transpose is needed
    if strcmpi(stimType, 'ruter') 
        err = sum((avgModelDecisions-avgExpDecisions').^2)*10 + 10^15*(conds*nTrials-successSum);
    else
        err = sum((avgModelDecisions-avgExpDecisions).^2)*10 + 10^15*(conds*nTrials-successSum);
    end
    global minErr;
    minErr = min(minErr,err);
    global firstErr;
    if nruns == 1
        firstErr = err;
    end
    
    disp('Current parameters are: ')
    disp(pT)
    disp('Which corresponds to raw parameters: ')
    disp(p)
    disp(['Current error is ', num2str(err), '. Minimum error was ', num2str(minErr), ', starting error was ', num2str(firstErr)])
    disp(['There were ' num2str(conds*nTrials-successSum), ' trials where no decision was reached.'])
    
end