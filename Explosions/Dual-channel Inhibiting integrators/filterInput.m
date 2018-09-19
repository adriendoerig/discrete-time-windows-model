function [ mOut, pOutV, pOutAV ] = filterInput( stims, dt )
%FILTERINPUT takes the stimulus as input and returns the output of the M-
%and P- streams
%   The M-pathway just gives a transient and does not worry about the sign
%   of the stimulus. Th P-pathway cares about the sign, so there are two
%   "detectors", one for the V (mOuV) and another for the AV (mOutAV).
% 
%   stim is a vector with the v, interval, and av durations in [s]
%       (in fact, ALL temporal parameters must be given in s).
%   dt is the time step of the simulation in [s] (usually 0.0005 -->.5ms)
%
%   outputs returned as vectors of dt [s] grain.

    plotting = evalin('caller','plotting'); % import the plotting option from runModel

    % Declare general parameters
    t_max = 2;              % simulation time in seconds
    t_pre = dt;
    time = dt:dt:t_max;     % for plotting
    inputGain = 5;          % how strong the stimulus is 
    
    % Check stimulus compatibility
    if sum(stims) > t_max
        error('stimulus is too long')
    end
    
    % declare output variables and associated time constants in ms.
    mOut = zeros(1,t_max/dt);
    pOutV = zeros(1,t_max/dt);  % vernier channel
    pOutAV = zeros(1,t_max/dt); % anti-vernier channel
    mTau = .01; % [s]
    pTau = .15; % [s]
    
    % input (represents the V-AV stimuli) (the stabilisation time for the
    % WongWang network is taken into account in the WongWang scripts).    
    % ATTENTION on peut mettre autre chose que +-1 comme valeur pour le gain!
    input = zeros(1,t_max/dt);
    inputV = input;
    inputAV = input;
    t_stimA = stims(1);     % duration vernier
    t_interval = stims(2);  % duration with no vernier (only vertical bars)
    t_stimB = stims(3);     % duration antivernier
    
    if any(stims)
        input(1:t_pre/dt) = 0;
        input(t_pre/dt:t_stimA/dt+t_pre/dt) = inputGain;
        input(t_stimA/dt+t_pre/dt:(t_stimA+t_interval)/dt+t_pre/dt) = 0;
        input((t_stimA+t_interval)/dt+t_pre/dt:(t_stimA+t_interval+t_stimB)/dt+t_pre/dt) = -inputGain;
        
        inputV(t_pre/dt:t_stimA/dt+t_pre/dt) = inputGain;
        
        inputAV((t_stimA+t_interval)/dt+t_pre/dt:(t_stimA+t_interval+t_stimB)/dt+t_pre/dt) = -inputGain;
    end
    
    % filters for adaptation
    ampAdaptM = 0.052;
    tAdaptM = .01; % [s]
    mFilter = @(t) -heaviside(t).*ampAdaptM.*exp(-t./(tAdaptM/dt));
    MfilteredInput = conv(abs(input),mFilter(1:t_max/dt),'full');

%     ampAdaptP = 0.048;    % right now the p-pathway has no adaptation. in
%     the case we use adaptation at 0.048, tauP = .1 does a good job.
    ampAdaptP = 0;
    tAdaptP = .01; % [s]
    pFilter = @(t) -heaviside(t).*ampAdaptP.*exp(-t./(tAdaptP/dt));
    PfilteredInputV = conv(inputV,pFilter(1:t_max/dt),'full');
    PfilteredInputAV = conv(inputAV,pFilter(1:t_max/dt),'full');
   
    %integration loop
    for t=1:t_max/dt-1
        % M pathways is just for transients. Doesn't care about the sign of the input
        mOut(t+1) = mOut(t)*(1-dt/mTau) + (abs(input(t))+MfilteredInput(t))*dt;
        pOutV(t+1) = pOutV(t)*(1-dt/pTau) + (inputV(t)+PfilteredInputV(t))*dt; % only 
        pOutAV(t+1) = pOutAV(t)*(1-dt/pTau) + (inputAV(t)+PfilteredInputAV(t))*dt;
    end
    
    mOut = mOut./max(mOut);
    pOutV = pOutV./max(abs(pOutV));
    pOutAV = pOutAV./max(abs(pOutAV));

    if plotting
        figure(1)
        subplot(3,1,1)
        plot(time,mOut);
        subplot(3,1,2)
        plot(time,pOutV);
        subplot(3,1,3)
        plot(time,pOutAV);
        title('M(top)- , PV(middle)- & PAV(bottom)- pathways outputs')
    end    
end

