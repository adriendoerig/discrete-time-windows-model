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
                 0.02 , 0.03, 0.02, 0;
                 0.02 , 0.07, 0.02, 0;
                 0.02 , 0.11, 0.02, 0;
                 0.02 , 0.03, 0   , 0.02;
                 0.02 , 0.07, 0   , 0.02;
                 0.02 , 0.11, 0   , 0.02];
    case 'E8'
        conds = [0.02 , 0   , 0   , 0;
                 0    , 0.13, 0.02, 0;
                 0    , 0.21, 0.02, 0;
                 0    , 0.29, 0.02, 0;
                 0.02 , 0.11, 0.02, 0;
                 0.02 , 0.19, 0.02, 0;
                 0.02 , 0.27, 0.02, 0;
                 0.02 , 0.11, 0   , 0.02;
                 0.02 , 0.19, 0   , 0.02;
                 0.02 , 0.27, 0   , 0.02];
    case 'E18'
        conds = [0.02 , 0   , 0   , 0;
                 0    , 0.29, 0.02, 0;
                 0    , 0.45, 0.02, 0;
                 0    , 0.57, 0.02, 0;
                 0.02 , 0.27, 0.02, 0;
                 0.02 , 0.43, 0.02, 0;
                 0.02 , 0.55, 0.02, 0;
                 0.02 , 0.27, 0   , 0.02;
                 0.02 , 0.43, 0   , 0.02;
                 0.02 , 0.55, 0   , 0.02];
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
successSum = zeros(1,nConds);

for i = 1:nConds
    % run nTrials trials
    nTrials = 1000;%160;;
    decisions{i} = zeros(1,nTrials);
    modelRTs{i} = decisions{i};

    for n = 1:nTrials
        [modelRTs{i}, decisions{i}(n), success] = decisionNeuralNew(conds(i,:), [pT(1), pT(2), pT(3), tStart, 0.02, 0.3], dataType);
%             modelRTs{i}(n) = modelRTs{i}(n)*dt; % in [s]
        successSum(i) = successSum(i) + success;
    end
    
    avgModelDecisions(i) = mean(decisions{i})*100;
    avgRTs(i) = mean(modelRTs{i});    
end

% plot
figure(1)
if strcmpi(dataType, 'ruter')
    bar([data', avgModelDecisions', successSum'/10])
else
    bar([data, avgModelDecisions', successSum'/10])
end
title(dataType) %, ' Success sum ', num2str(successSum)])
xlabel('condition')
ylabel('1st vernier dominance %')
legend('humans','model', 'successSum /10', 'Location','Best')
% save if requested
if nargin == 5
    plotName = varargin{1};
    saveas(gcf,[plotName, '.png'])
end
    
    