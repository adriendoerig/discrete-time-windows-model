function [ stimuli ] = createStimuli( dt, stimType )
%CREATESTIMULI returns a cell of cells containing stimuli from the family
%stimType (see human data excel sheet). 
%   elementDuration is the duration of one "element" (e.g. a vernier) [s]
%   isiDuration is the duration of inter-element interval [s]
%   dt is the timeStep of your simulation
%   stimType is 'E4', 'E8' or 'E18'

switch stimType
    case 'E4'
        
        elementDuration = .02;
        isiDuration = .02;
        
        % stimulus components
        ISI = zeros(1,isiDuration/dt);
        longISI = zeros(1,1.5*isiDuration/dt);
        vernier = ones(1,elementDuration/dt);
        grating = zeros(1,elementDuration/dt);
        antivernier = -1*ones(1,elementDuration/dt);
        
        nStimuli = 10;
        stimuli = cell(1,nStimuli);
        stimuli{1}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,4)]; % V alone
        stimuli{2}  = [{grating}, {longISI}, {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,3)]; % AV1
        stimuli{3}  = [{grating}, {longISI}, repmat([{grating}, {ISI}],1,1), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,2)]; % AV2
        stimuli{4}  = [{grating}, {longISI}, repmat([{grating}, {ISI}],1,2), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,1)]; % AV3
        stimuli{5}  = [{vernier}, {longISI}, {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,3)]; % VAV1
        stimuli{6}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,1), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,2)]; % VAV2
        stimuli{7}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,2), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,1)]; % VAV3
        stimuli{8}  = [{vernier}, {longISI}, {vernier}, {ISI}, repmat([{grating}, {ISI}],1,3)]; % VPV1
        stimuli{9}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,1), {vernier}, {ISI}, repmat([{grating}, {ISI}],1,2)]; % VPV2
        stimuli{10} = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,2), {vernier}, {ISI}, repmat([{grating}, {ISI}],1,1)]; % VPV3
    
    case 'E8'
        
        elementDuration = .02;
        isiDuration = .02;
        
        % stimulus components
        ISI = zeros(1,isiDuration/dt);
        longISI = zeros(1,1.5*isiDuration/dt);
        vernier = ones(1,elementDuration/dt);
        grating = zeros(1,elementDuration/dt);
        antivernier = -1*ones(1,elementDuration/dt);
        
        nStimuli = 10;
        stimuli = cell(1,nStimuli);
        stimuli{1}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,8)]; % V alone
        stimuli{2}  = [{grating}, {longISI}, repmat([{grating}, {ISI}],1,2), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,5)]; % AV3
        stimuli{3}  = [{grating}, {longISI}, repmat([{grating}, {ISI}],1,4), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,3)]; % AV5
        stimuli{4}  = [{grating}, {longISI}, repmat([{grating}, {ISI}],1,6), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,1)]; % AV7
        stimuli{5}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,2), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,5)]; % VAV3
        stimuli{6}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,4), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,3)]; % VAV5
        stimuli{7}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,6), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,1)]; % VAV7
        stimuli{8}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,2), {vernier}, {ISI}, repmat([{grating}, {ISI}],1,5)]; % VPV3
        stimuli{9}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,4), {vernier}, {ISI}, repmat([{grating}, {ISI}],1,3)]; % VPV5
        stimuli{10} = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,6), {vernier}, {ISI}, repmat([{grating}, {ISI}],1,1)]; % VPV7
    
    case 'E18'
        
        elementDuration = .02;
        isiDuration = .02;
        
        % stimulus components
        ISI = zeros(1,isiDuration/dt);
        longISI = zeros(1,1.5*isiDuration/dt);
        vernier = ones(1,elementDuration/dt);
        grating = zeros(1,elementDuration/dt);
        antivernier = -1*ones(1,elementDuration/dt);
        
        nStimuli = 10;
        stimuli = cell(1,nStimuli);
        stimuli{1}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,18)]; % V alone
        stimuli{2}  = [{grating}, {longISI}, repmat([{grating}, {ISI}],1,5), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,12)]; % AV7
        stimuli{3}  = [{grating}, {longISI}, repmat([{grating}, {ISI}],1,9), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,8)]; % AV11
        stimuli{4}  = [{grating}, {longISI}, repmat([{grating}, {ISI}],1,12), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,5)]; % AV14
        stimuli{5}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,5), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,12)]; % VAV7
        stimuli{6}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,9), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,8)]; % VAV11
        stimuli{7}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,12), {antivernier}, {ISI}, repmat([{grating}, {ISI}],1,5)]; % VAV14
        stimuli{8}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,5), {vernier}, {ISI}, repmat([{grating}, {ISI}],1,12)]; % VPV7
        stimuli{9}  = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,9), {vernier}, {ISI}, repmat([{grating}, {ISI}],1,8)]; % VPV11
        stimuli{10} = [{vernier}, {longISI}, repmat([{grating}, {ISI}],1,12), {vernier}, {ISI}, repmat([{grating}, {ISI}],1,5)]; % VPV14
    
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
             
         nStimuli = size(conds,1);
         stimuli = cell(1,nStimuli);
         for i = 1:nStimuli
             stimuli{i}  = [{ones(1,conds(i,1)/dt), -1*ones(1,conds(i,2)/dt)}, {zeros(1,1/dt);}];
         end
end



