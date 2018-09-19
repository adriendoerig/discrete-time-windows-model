function [err] = errorFitWongWang(p, data, stimType)
% Compute the error of the model prediction WITHOUT CARING ABOUT TND
% Use with p0 = [...,...,...]; 
% pOptimized = fminsearch(error,p0)

% p(1) = wongWang_gain
% p(2) = wongWang_sigma
% p(3) = wongWang_mu0

    pT = pTransformWongWang(p); %Transforms the parameter vector such that all values to optimize vary between 0 and 1.
    
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
    concatStimuli = cell(1,length(stimuli));
    t_stab = .5; % [s], to let the network stabilize
    
    % model outputs
    conds = length(avgExpDecisions);
    decisions = cell(1,conds);
    modelRTs = decisions;
    avgModelDecisions = zeros(1,conds);
    avgRTs = zeros(1,conds);
    successSum = 0;
    
    for i = 1:conds
        
        % transform boxed stimuli in a single continuous box
        concatStimuli{i} = cat(2, stimuli{i}{:});
        
        % run nTrials trials
        nTrials = 160;
        decisions{i} = zeros(1,nTrials);
        modelRTs{i} = decisions{i};
        
        for n = 1:nTrials
            % take boxes stage output and add gain and noise
            wongWang_input = normrnd(pT(1).*concatStimuli{i}, pT(2), [1, length(concatStimuli{i})]);
            wongWang_input = [zeros(1,t_stab/dt), wongWang_input];
%             figure(1)
%             plot(wongWang_input)
%             drawnow
            % feed this to wongWang
            [decisions{i}(n), modelRTs{i}(n), success] = WongWangVaryingV(wongWang_input, pT(3));
            modelRTs{i}(n) = modelRTs{i}(n)*dt; % in [s]
            successSum = successSum + success;
        end

        avgModelDecisions(i) = mean(decisions{i})*100;
        avgRTs(i) = mean(modelRTs{i});    
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute error
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    err = sum((avgModelDecisions-avgExpDecisions).^2)*10 + 10^15*(conds*nTrials-successSum);
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