function [err] = errorFitRuter(p, data, dataType, tStart)
% Compute the error of the model prediction WITHOUT CARING ABOUT TND
% Use with p0 = [...,...,...]; 
% pOptimized = fminsearch(error,p0)

% p(1) = integration_tau
% p(2) = wongWang_gain
% p(3) = wongWang_mu0

    pT = pTransformRuter(p); %Transforms the parameter vector such that all values to optimize vary between 0 and 1.
    
    % just an iteration counter
    global nruns;
    nruns = nruns + 1;
    disp('')
    disp(['This is iteration ', num2str(nruns)])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get empirical data for all conditions
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    avgExpDecisions = data;
    expRTs = []; % we don't have any RTs in this experiment, but maybe in the future
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get model simulations for all conditions
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    switch dataType
        case 'ruter'
            conds = [0.004, 0.016;
                     0.01,  0.01;
                     0.016, 0.004;
                     0.008, 0.032;
                     0.02,  0.02;
                     0.032, 0.008;
                     0.016, 0.064;
                     0.04,  0.04;
                     0.064, 0.016;
                     0.032, 0.128;
                     0.08,  0.08;
                     0.128, 0.032];
        case 'E4'
            conds = [0.02 , 0   , 0   , 0;
                     0    , 0.05, 0.02, 0;
                     0    , 0.09, 0.02, 0;
                     0    , 0.13, 0.02, 0;
                     0.02 , 0.05, 0.02, 0;
                     0.02 , 0.09, 0.02, 0;
                     0.02 , 0.13, 0.02, 0;
                     0.02 , 0.05, 0   , 0.02;
                     0.02 , 0.09, 0   , 0.02;
                     0.02 , 0.13, 0   , 0.02];
        case 'E8'
            conds = [0.02 , 0   , 0   , 0;
                     0    , 0.13, 0.02, 0;
                     0    , 0.21, 0.02, 0;
                     0    , 0.29, 0.02, 0;
                     0.02 , 0.13, 0.02, 0;
                     0.02 , 0.21, 0.02, 0;
                     0.02 , 0.29, 0.02, 0;
                     0.02 , 0.13, 0   , 0.02;
                     0.02 , 0.21, 0   , 0.02;
                     0.02 , 0.29, 0   , 0.02];
        case 'E18'
            conds = [0.02 , 0   , 0   , 0;
                     0    , 0.29, 0.02, 0;
                     0    , 0.45, 0.02, 0;
                     0    , 0.57, 0.02, 0;
                     0.02 , 0.29, 0.02, 0;
                     0.02 , 0.45, 0.02, 0;
                     0.02 , 0.57, 0.02, 0;
                     0.02 , 0.29, 0   , 0.02;
                     0.02 , 0.45, 0   , 0.02;
                     0.02 , 0.57, 0   , 0.02];
    end
    
    nConds = size(conds,1);

    dt = .001;
    
    % model outputs
    decisions = cell(1,nConds);
    modelRTs = decisions;
    avgModelDecisions = zeros(1,nConds);
    avgRTs = zeros(1,nConds);
    successSum = 0;
    
    for i = 1:nConds
        % run nTrials trials
        nTrials = 160;
        decisions{i} = zeros(1,nTrials);
        modelRTs{i} = decisions{i};
        
        for n = 1:nTrials
            [modelRTs{i}, decisions{i}(n), success] = decisionNeuralNew(conds(i,:), [pT(1), pT(2), pT(3), tStart, 0.02, 0.3]);
%             modelRTs{i}(n) = modelRTs{i}(n)*dt; % in [s]
            successSum = successSum + success;
        end

        avgModelDecisions(i) = mean(decisions{i})*100;
        avgRTs(i) = mean(modelRTs{i});    
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute error
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    err = sum((avgModelDecisions-avgExpDecisions').^2)*10 + 10^15*(nConds*nTrials-successSum);
    size(err)
    size(avgModelDecisions)
    size(avgExpDecisions)
    size(successSum)
    
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
    disp(['There were ' num2str(nConds*nTrials-successSum), ' trials where no decision was reached.'])
    
end