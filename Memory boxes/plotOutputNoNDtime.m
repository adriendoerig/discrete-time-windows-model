function [] = plotOutputNoNDtime(p, dataType, subjectNumber, varargin)
% PLOTOUTPUT plots model output (specify parameters in p -- careful with 
% the pTransfom function!!) alongside experimental data (specify dataType)
% for the subject specified by subjectNumber.
%
% dataType is the experiment, e.g. 'E4'
% subjectNumber is the ID of the subject (7 is the average data)
% as an optional argument you can give a filename and it will save the plot
% in the current directory under this filename, e.g. 'subject1'

p = pTransformNoNDtime(p);

% get data
if contains(dataType, 'E')
    [dataLength4, dataLength8, dataLength18] = makeData(); % extract explosion data from excel file
elseif contains(dataType, 'fusion')
    % I havent created a script yet
elseif contains(dataType, 'vernier')
    % I havent created a script yet
else
    error('Invalid dataType.')
end

% timeStep & create stimuli
dt = .001;
switch dataType
    case 'E4' % explosion with 4 bars
        stimuli = createStimuli(dt, 'E4');
        data = dataLength4{subjectNumber};
    case 'E8' % explosion with 8 bars
        stimuli = createStimuli(dt, 'E8');
        data = dataLength8{subjectNumber};
    case 'E18' % explosion with 18 bars
        stimuli = createStimuli(dt, 'E18');
        data = dataLength18{subjectNumber};
    case 'fusion V=AV' % V and AV have the same duration
        stimuli = createStimuli(dt, 'fusion V=AV');
        data = [50 42 38 38 42 50 60 65 70 80 100]';
    case 'vernier'
        stimuli = createStimuli(dt, 'vernier');
        data = [75 75 75 75]';
end

% model outputs
conds = length(stimuli);
decisions = cell(1,conds);
modelRTs = decisions;
avgModelDecisions = zeros(1,conds);
avgRTs = zeros(1,conds);
successSum = 0;

for i = 1:conds

    % run nTrials trials
    nTrials = 400;
    decisions{i} = zeros(1,nTrials);
    modelRTs{i} = decisions{i};

    for n = 1:nTrials
        [decisions{i}(n), modelRTs{i}(n), success] = runTrial(1, stimuli{i}, dt, ...
            0, p(1), p(2), p(3), p(4), p(5), p(6));
        successSum = successSum + success;
    end

    avgModelDecisions(i) = mean(decisions{i})*100;
    avgRTs(i) = mean(modelRTs{i});    
end

% plot
figure(1)
bar([data, avgModelDecisions'])
title(dataType)
xlabel('condition')
ylabel('1st vernier dominance %')
legend('humans','model')
% save if requested
if nargin == 4
    plotName = varargin{1};
    saveas(gcf,[plotName, '.png'])
end
    
    