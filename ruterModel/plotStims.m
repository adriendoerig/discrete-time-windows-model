function [] = plotStims(stims)


    t_max = 2;              % simulation time in seconds
    t_stab = 0.5;           % stabilization time (for the WongWang network) in s (so that the network is not "booting" when we send the stimulus).
    t_stimA = stims(1);     % duration stim A
    t_stimB = stims(2);     % duration stim B
    dt = 0.0005;            % time step = 0.5 ms

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
            input(int32(t_stimA/dt+1):int32((t_stimA+t_stimB)/dt)) = 0;
        else
            input(1:int32((t_stimA+t_stimB)/dt)) = 0;
        end
        input(int32((t_stimA+t_stimB)/dt+1):int32((t_stimA+t_stimB+t_stimC)/dt)) = -1;
        input(int32((t_stimA+t_stimB+t_stimC)/dt+1):int32((t_stimA+t_stimB+t_stimC+t_stimD)/dt)) = 1;
    else
        error('stims must have 2 or 4 entries')
    end
    
    figure()
    plot(1:length(input), input)