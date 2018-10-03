% Master script to run the whole model
%
% Be careful to give all temporal parameters in [s]
%
% NOTE: In contrast to the DecisionNeuralNew model that has a fixed
% Tstart, here Tstart CANNOT be incorporated in the non-decisional time Tnd 
% because it varies depending on the stimulus.
% So here Tnd has a DIFFERENT interpretation: it is everything that does
% NOT belong to stages 1,2&3 (so it includes retinal, motor delays etc).

% IDEAS: 
% About STAGE I, the trick is really to find the right filters. We need
% to worry about i) the absolute simescale to match empirical speeds of 10s
% of ms of stimulus presentation and ii) -- more importantly and more
% challenging -- we need to find the right interplay between the two
% pathways. If the P pathway is too SLOW it will always eat up all the
% M-transients (apart from the first one, which provokes a "void" signal
% coming from the earlier absence of information). If the P pathway is too
% FAST, it will not kill the M-transients that need to be killed in order
% to explain fusion. So the crucial part of the whole model is the filter.
% We know that the rest works. For now I created filters using fourier and
% signal detection theory, but that is just one idea, maybe other things
% would be better?
%
% About STAGE II, the only problem right now is probably that we could
% forget about the first transient that climbs over threshold, since maybe
% it is really about reading out the "old, stimulus-less" information. In
% other words, it is useless.
%
% About STAGE III, the only thing is that maybe c, mu0 and sigmaV are
% redundant. I think we can set c to 1, and keep only mu0 as gain and
% sigmaV as noise. It seems to me that all that c is doing is modifying the
% signal to noise ratio. Something to think about.

plotting = 1;           % Decide if you want to plot graphs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% experimental parameters
stims = [.05 .0 .0];    % duration of V-interval-AV in [s]
nTrials = 40;

% temporal parameters
Tstart = .5;            % decision stage starts at Tstart if it has not started before.
dt = 0.0005;            % time step of the simulation in [s]
t_max = 2;              % total duration of the experiment in [s]
time = dt:dt:t_max;     % for plotting

% Level 2 parameters
threshold = .0005;      % m-threshold at which p-integrated evidence pE is sent to the decision stage.
nDecisionsMax = 4;      % max number of decision stages for a given input (not very important)

% Level 3 parameters
c = 25;                 % gain between stages 2&3
sigmaV = 0.005;         % noise between stages 2&3
t_stab = .5;            % stabilisation time for the decision network so that it is not stabilizing when we call it.
mu0 = 25;               % wong&wang decision stage gain parameter

% Output parameters
meanTnd = 0.1;          % mean non-decisional time
widthTnd = 0.1;         % non-decisional time is drawn from a uniform distribution centered at meanTnd and of width widthTnd


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run the model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mE = zeros(nTrials,t_max/dt);                       % m-integrator values
pE = zeros(nTrials,t_max/dt);                       % p-integrator values
decisionTimes = zeros(nTrials,nDecisionsMax);       % times at which the decision stage kicks in
decisions = zeros(nTrials,size(decisionTimes,2));   % there will be one decision threshold passing
DTs = zeros(nTrials,nDecisionsMax);                 % decision times (from network initialization to decision);
RTs = zeros(nTrials,nDecisionsMax);                 % reaction times are (decision + non-decisional) time

for trial = 1:nTrials
    
    decisionN = 0;                                  % counts the times stage 3 kicked in

    % level 1: the input is filtered by the M- and P- systems
    [ mOut, pOutV, pOutAV ] = filterInput( stims, dt );


    aboveThresh = 0;
    % level 2: the output of level 1 is fed to the competing integrators.
    % careful, each entry in the final vector "lasts" dt.
    for t = 1:t_max/dt-1
        [ mE(trial, t+1), pE(trial, t+1) ] = competingIntegratorsStep( mOut(t), pOutV(t), pOutAV(t), mE(trial, t), pE(trial, t), dt);

        % Level 3
        % Times at which pE is sent to the decision stage.
        % pE is sent only at t when the threshold is reached
        % (and is not continuously sent during the whole
        % duration when mE is above threshold)
        % NOTE: cases where no decision has been made until Tstart
        % will be handled outside the time loop. They are characterized by
        % nDecision = 0 after the time loop.
        if abs(mE(trial, t+1)) > threshold && aboveThresh == 0 && t < Tstart/dt
            decisionN = decisionN + 1;
            decisionTimes(trial, decisionN) = t+1;
            v = normrnd(pE(trial,t+1),sigmaV); % Noisy input to decision stage
            v = 2*(atan(2*v))/pi; %maps [-Inf,Inf] to [0,1] ( because wongWangBoxes expects v in [0,1]
            [decisions(trial, decisionN), DTs(trial, decisionN), ~] = WongWangNew(v, t_stab, mu0);
            aboveThresh = 1;
        end
        % Times when the activity goes down below threshold again
        if aboveThresh == 1 && abs(mE(trial, t+1)) < threshold
            aboveThresh = 0;
        end
    % end of time loop    
    end

    % case in which no decision was made before Tstart: level 3
    if decisionN == 0
        % this is the input to stage 3, with a stabilisation period t_stab
        % [s] to let the WongWang network settle down
        v = [zeros(1,t_stab/dt), normrnd(pE(trial, Tstart/dt:end), sigmaV.*ones(1,length(pE(trial, Tstart/dt:end))))];
            
        [decisions(trial, 1), DTs(trial, 1), ~] = WongWangVaryingV(v, mu0);

        % Reaction times are (decision + non-decisional) time.
        % RTs are given in [ms]: meanTnd is in [s], DTs in [ms] and Tstart in [s]
        % t_stab is cut off inside WongWangVaryingV so no worry there
        RTs(trial, 1) = ((rand-.5)*widthTnd+meanTnd)*1000 + DTs(trial, 1) + Tstart*1000; 

    % case in which at least one decision was made before Tstart
    else
        % Reaction times are (decision + non-decisional) time.
        % RTs are given in [ms]: meanTnd is in [s], DTs in [ms] and decisionTimes in [ms/2]
        % t_stab is cut off inside WongWangNew so no worry there
        for i = 1:decisionN
            RTs(trial, i) = ((rand-.5)*widthTnd+meanTnd)*1000 + DTs(trial, i) + decisionTimes(trial,i)/2; 
        end
    end
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot stuff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if plotting
    figure(100)
    subplot(2,1,1)
    plot(time,mE)
    subplot(2,1,2)
    plot(time,pE)
    title('top: M-integrator --- bottom: P-integrator')
end

meanDecisions = mean(decisions)
meanRTs = mean(RTs)