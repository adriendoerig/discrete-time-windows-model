function [] = plotOutputNoNDtimeChooseReadoutTime(p, dataType, subjectNumber, readoutTime, varargin)
% PLOTOUTPUT plots model output (specify parameters in p -- careful with 
% the pTransfom function!!) alongside experimental data (specify dataType)
% for the subject specified by subjectNumber.
%
% dataType is the experiment, e.g. 'E4'
% subjectNumber is the ID of the subject (7 is the average data)
% as an optional argument you can give a filename and it will save the plot
% in the current directory under this filename, e.g. 'subject1'

p = pTransformNoNDtimeChooseReadoutTime(p);

% get data
if contains(dataType, 'E')
    [dataLength4, dataLength8, dataLength18] = makeData(); % extract explosion data from excel file
elseif contains(dataType, 'ruter')
    data = makeDataRuter();
elseif contains(dataType, 'All')
    %dataAll = [0.75; 0.25; 0.25; 0.25; 0.25; 0.25; 0.25; 0.25; 0.25; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.75; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.75]*100;
    %for 2 window model
    dataAll = [0.75; 0.25; 0.25; 0.25; 0.25; 0.25; 0.25; 0.25; 0.25; 0.25; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.25; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.9; 0.75]*100; 
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
    case 'ruter' % all of ruter's conditions
        stimuli = createStimuli(dt, 'ruter');
        data = data{subjectNumber}; 
    case 'All'
        stimuli = createStimuli(dt,'All');
        data = dataAll;
end

% model outputs
conds = length(stimuli);
decisions = cell(1,conds);
modelRTs = decisions;
avgModelDecisions = zeros(1,conds);
avgRTs = zeros(1,conds);
successSum = 0;
wongWang_input = cell(1,conds);
avgwongWang_input = zeros(1,conds);

successSum2 = 0;

for i = 1:conds

    % run nTrials trials
    nTrials = 1000;
    decisions{i} = zeros(1,nTrials);
    modelRTs{i} = decisions{i};
    wongWang_input{i} = zeros(1,nTrials);

    for n = 1:nTrials
        [decisions{i}(n), modelRTs{i}(n), success, wongWang_input{i}(n)] = runTrial(1, stimuli{i}, dt, ...
            0, readoutTime, p(1), p(2), p(3), p(4), p(5));
        successSum = successSum + success;
    end

    avgModelDecisions(i) = mean(decisions{i})*100; %simo deleted ; to see results
    avgRTs(i) = mean(modelRTs{i}); 
    avgwongWang_input(i) = mean(wongWang_input{i})*100;
    
    if length(stimuli{i}) > 23
        for n = 1:nTrials
            [decisions2{i}(n), modelRTs2{i}(n), success2, wongWang_input2{i}(n)] = runTrial(1, stimuli{i}, dt, ...
                0, 2*readoutTime, p(1), p(2), p(3), p(4), p(5));
            successSum2 = successSum2 + success2;
        end
        
        avgModelDecisions2(i) = mean(decisions2{i})*100; %simo deleted ; to see results
        avgRTs2(i) = mean(modelRTs2{i});
        avgwongWang_input2(i) = mean(wongWang_input2{i})*100;
    else
        avgModelDecisions2(i) = 0;
        avgwongWang_input2(i) = 0;        
    end
end

% plot
figure(9999)
if strcmpi(dataType, 'ruter')
    bar([data', avgModelDecisions'])
else
    %bar([data, avgModelDecisions', avgwongWang_input'])
    bar([data, avgModelDecisions', avgModelDecisions2'])
end
title(dataType)
xlabel('condition')
ylabel('1st vernier dominance %')
legend('humans','model','2windowModel','Location','Best')
% save if requested
if nargin == 5
    plotName = varargin{1};
    saveas(gcf,[plotName, '.png'])
end
% figure(99992)
% bar([avgModelDecisions', avgwongWang_input'])
% xlabel('condition')
% legend('model output', 'wongWang_input')
% if nargin == 5
%     plotName = varargin{1};
%     saveas(gcf,[plotName, '_wongwanginput', '.png'])
% end
    