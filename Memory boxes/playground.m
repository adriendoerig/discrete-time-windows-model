% just to try things out

% temporal and box parameters
dt = 0.001;                 % [s]
boxLength = 0.2;            % [s]
simulationTime = 1;         % [s]
tauIntegrate = 0.05;        % [s]
tauDecay = 1;               % [s]
readoutTime = 0.8;          % [s]
NDtime = 0.3;               % [s]

% wong & wang parameters
wongWang_gain = 1;          % gain from boxes stage to decision stage
wongWang_sigma = .01;       % noise from boxes stage to decision stage
wongWang_mu0 = 25;          % wongWang "reactivity" -> high mu= = "jumpy" network

% a few common stimuli to put in the boxes
vernier = ones(1,boxLength/dt);
grating = zeros(1,boxLength/dt);
antivernier = -1*ones(1,boxLength/dt);

% create a stimulus sequence
nBoxes = 3;
stimulus = cell(1,nBoxes);  % one cell to describe each boxe's content
stimulus{1} = vernier;      % box 1 content
stimulus{2} = grating;      % box 2 content
stimulus{3} = antivernier;  % box 3 content

% run nTrials trials
nTrials = 100;
decision = zeros(1,nTrials);
RT = decision;
for n = 1:nTrials
    [decision(n), RT(n)] = runTrial(simulationTime, stimulus, dt, NDtime, readoutTime, tauIntegrate, tauDecay, wongWang_gain, wongWang_sigma, wongWang_mu0);
end

avgDecision = mean(decision);
avgRT = mean(RT);
