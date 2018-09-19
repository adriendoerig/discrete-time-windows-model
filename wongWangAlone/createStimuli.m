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
    
    case 'fusion V=AV' % V and AV have same duration
        
        fusionDuration = [.02 .04 .08 .16 .25 .40 .60 .80 1 1.2 1.5]; % [s] total duration of VAV
        
        nStimuli = length(fusionDuration);
        stimuli = cell(1,nStimuli);
        for i = 1:length(fusionDuration)
            stimuli{i} = {[1*ones(1,(fusionDuration(i)/2)/dt), -1*ones(1,(fusionDuration(i)/2)/dt)]};
        end
    
    case 'vernier' % V and AV have same duration
        
        fusionDuration = [.01 .02 .04 .08]; % [s] total duration of VAV
        
        nStimuli = length(fusionDuration);
        stimuli = cell(1,nStimuli);
        for i = 1:length(fusionDuration)
            stimuli{i} = {1*ones(1,fusionDuration(i)/dt)};
        end
end



