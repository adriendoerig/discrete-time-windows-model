 function [] = plotOutputRuter(p, dataType, subjectNumber, tStart, varargin)
% PLOTOUTPUT plots model output (specify parameters in p -- careful with 
% the pTransfom function!!) alongside experimental data (specify dataType)
% for the subject specified by subjectNumber.
%
% dataType is the experiment, e.g. 'E4'
% subjectNumber is the ID of the subject (7 is the average data)
% as an optional argument you can give a filename and it will save the plot
% in the current directory under this filename, e.g. 'subject1'

pT = pTransformRuter(p);

% get data and conditions
% get experimental data
if strcmpi(dataType,'ruter')
    disp('Loadgin Rüter''s data')
    data = makeDataRuter();
    data = data{subjectNumber};  
else
    disp('Loading Leila''s data')
    [dataLength4, dataLength8, dataLength18] = makeDataLeila();
    switch dataType
        case 'E4'
            data = dataLength4{subjectNumber};     
        case 'E8'
            data = dataLength8{subjectNumber};
        case 'E18'
            data = dataLength18{subjectNumber};    
    end
end

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

% model outputs
decisions = cell(1,nConds);
modelRTs = decisions;
avgModelDecisions = zeros(1,nConds);
avgRTs = zeros(1,nConds);
successSum = 0;

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

% plot
figure(1)
if strcmpi(dataType, 'ruter')
    bar([data', avgModelDecisions'])
else
    bar([data, avgModelDecisions'])
end
title(dataType)
xlabel('condition')
ylabel('1st vernier dominance %')
legend('humans','model')
% save if requested
if nargin == 5
    plotName = varargin{1};
    saveas(gcf,[plotName, '.png'])
end
    
    