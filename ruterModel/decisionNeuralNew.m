function [RTs, perf, success] = decisionNeuralNew(stims, p)
%DECISIONNEURALNEW Runs the stimuli (representing vernier-antivernier) given in "stims" through a two-stage
% decision model. The integration stage is the same as in Rüter et al.,
% 2012. The decision stage is the neural network simplification by
% Wong&Wang, 2006.
% returns RTs, performance (% of responses to the first stim) and success
% (=1 if the decision process successfully reached a conclusion, 0
% otherwise).
%
%   stims : duration in SECONDS of stimulus A, then B - e.g. [0.01 0.04]
%       means the first vernier lasts 10 ms, the antivernier lasts 40 ms.
%   p : a vector containing the parameters of the model
%       p(1) : tau
%       p(2) : c
%       p(3) : mu0 (see WongWang scripts)
%       p(4) : tStart
%       p(5) : widthTnd
%       p(6) : meanTnd
%
% NOTE: In contrast to the general model that can also decide before
% Tstart, here Tstart may be incorporated in the non-decisional time 
% because it is constant.
% So here Tnd is everything EXCEPT the decision stage: It goes from 0 to
% Tstart, and additionally includes motor delays, etc.

    plotting = 0;

    t_max = 2;              % simulation time in seconds
    t_stab = 0.5;           % stabilization time (for the WongWang network) in s (so that the network is not "booting" when we send the stimulus).
    t_stimA = stims(1);     % duration stim A
    t_stimB = stims(2);     % duration stim B
    t_start = p(4);         % decision stage starts at t_start
    dt = 0.0005;            % time step = 0.5 ms
    T = t_max/dt;           % number of time steps. eg. t_max = 2 seconds, dt = 0.0005 s -> 2/0.0005 = 4000 0.5ms steps.

    trials = 1;             % number of trials is taken care of in errorFitRuter
    perf = 0;               % will count the number of outputs where the first vernier wins.
    RTs = zeros(1,trials);  % we will collect RTs here.
    
    % input (represents the V-AV stimuli) (the stabilisation time for the
    % WongWang network is taken into account in the WongWang scripts).
    input = zeros(1,t_max/dt);
    if numel(stims) == 2
        input(1:t_stimA/dt) = 1;
        input(t_stimA/dt:(t_stimA+t_stimB)/dt) = -1;
    elseif numel(stims) == 4
        t_stimC = stims(3);
        t_stimD = stims(4);
        if t_stimA > 0
            input(1:int32(t_stimA/dt)) = 1;
            input(int32(t_stimA/dt):int32((t_stimA+t_stimB)/dt)) = 0;
        else
            input(1:int32((t_stimA+t_stimB)/dt)) = 0;
        end
        input(int32((t_stimA+t_stimB)/dt):int32((t_stimA+t_stimB+t_stimC)/dt)) = -1;
        input(int32((t_stimA+t_stimB+t_stimC)/dt):int32((t_stimA+t_stimB+t_stimC+t_stimD)/dt)) = 1;
    else
        error('stims must have 2 or 4 entries')
    end
    
    % integrated evidence variables
    E = zeros(1,t_max/dt);
    tau = p(1);

    % decision process variables
    c = p(2);
    sigmaV = 0.05; % 2;

    % non-decisional time variables [s]
    widthTnd = p(5);
    meanTnd = p(6);

    % do many trials
    for ii=1:trials
        close all
        
        % main loop if sitmulus duration < t_start
        if (t_stimA+t_stimB)<=t_start
            
            buffer = 0;  % at the end of the stimulus, buffer will be set to one so that E(t) is written in the buffer.
            
            for t=1:T-1
                if t == (t_stimA+t_stimB)/dt % buffer at the end of stim presentation
                    buffer = 1;
                end
                
                if buffer == 0
                    E(t+1) = E(t)*(1-dt/tau) + input(t)*dt;
                else
                    E(t+1:end) = E(t);
                end               
                                
                if t>=t_start/dt        % the decision process starts a t_start. We get the drift rate v from the buffered value in E, and use the WongWang network to make a decision.
                    v = normrnd(c*E(t),sigmaV);
                    v = 2*(atan(2*v))/pi; %maps [-Inf,Inf] to [0,1] ( because wongWangBoxes expects v in [0,1]
                    % Decision stage :::: decision = 1 for first vernier; DT = decision time; success = 1 if the network successfully reaches a decision.
                    [decision, DT, success] = WongWangNew(v, t_stab, p(3));
                    Tnd = (rand-.5)*widthTnd+meanTnd;
                    RTs(ii)= DT+(Tnd*1000); % We want RT in ms. this is what comes out of WongWang, but we must convert the other values. Tnd in sec * 1000 = Tnd in ms
                    
                    if decision == 1
                        perf = perf + 1; % counter for decision == 1.
                    end
                    
                    if plotting
                        figure('Position',[180 439 612 439])
                        plot(1:T,E)
                        xlabel('time in a silly unit: [ms/2]')
                        ylabel('Integrated evidence E [arbitrary units]')
                        drawnow
                    end
                    
                    break % we're done with this trial.
                end
            end
        end
        
        % main loop if stimulus duration > t_start
        if (t_stimA+t_stimB)>t_start
            
            buffer = 0;     % at the end of the stimulus, buffer will be set to one so that E(t) is written in the buffer.
            vtemp = zeros(1,T); % we will run the WongWangVaryingV script on output values of v starting at t_start (we will set values of v for t<t_start to 0).
            
            for t=1:T-1 % fill vector v
                
                if buffer == 0; % before the end of the stimulus, integration happens (even after t_start)
                    E(t+1) = E(t)*(1-dt/tau) + input(t)*dt;
                end
                
                if t==(t_stimA+t_stimB)/dt && buffer == 0  % buffering of E(t) at the end of stimulus
                        E(t+1:end) = E(t+1);
                        buffer = 1;
                end
                
                if t > t_start/dt % at t_start (which is before the end of the stimulus), feed the output of integration to the decision process (of course, t is (t_start/dt) steps ahead of the vtemp index)
                     vtemp(t) = normrnd(c*E(t),sigmaV);
                end
                
            end
            
            v = [zeros(1,t_stab/dt),vtemp]; % we must wait for the full v to feed to the WongWang network. v contains zeros in the beginning to let WongWang stabilize.

            % Decision stage :::: decision = 1 for first vernier; DT = decision time; success = 1 if the network successfully reaches a decision.
            [decision, DT, success] = WongWangVaryingV(v,length(v),p(3));
            Tnd = (rand-.5)*widthTnd + meanTnd;
            RTs(ii)= DT + (Tnd - t_stab)*1000; % We want RT in ms. this is what comes out of WongWang, but we must convert the other values.
            
            if decision == 1
                perf = perf + 1;
            end
            
            if plotting
                figure('Position',[180 439 612 439])
                plot(v)
                hold on
                plot([zeros(1,t_stab/dt),E])
                hold off
                xlabel('time in a silly unit: [ms/2]')
                ylabel('arbitrary units')
                legend('v, the bias fed into WongWang', 'Integrated information E')
                drawnow
            end
        end
%         decision
%         DT
%         RTs(ii)
    end
    
%     RTdistrib = ksdensity(RTs, RTeval);
      RTmean = mean(RTs);
      perf = perf/trials;
end