function pOptimized = fitParametersBoxesNoNDtime(dataType, subjectNumber)
% Run this to fit parameters with fminsearch WITHOUT CARING ABOUT TND

global nruns;                           % iteration counter
nruns = 0;
global firstErr;
firstErr = 100000000000000;             % will remember the first error.
global minErr;
minErr = 100000000000000;               % minimal error (will be updated as we optimize).

% load from excel file NOTE: if an error comes up saying the worksheet 
% could not be activated, open the excel file, switch to Sheet1 and save.
% if it still doesn't work, close and reopen matlab.
% get experimental data
[dataLength4, dataLength8, dataLength18] = makeData();

% choose which experimental data to use
switch dataType
    case 'E4'
        data = dataLength4{subjectNumber};     
    case 'E8'
        data = dataLength8{subjectNumber};
    case 'E18'
        data = dataLength18{subjectNumber};    
end
        
p0 = 0.25*ones(1,6);                     % initial parameters (but see function pTranform)

options = optimset('DiffMinChange', 0.1, 'DiffMaxChange', 10, 'MaxFunEvals', 100);

pOptimized = fminsearchOS('errorFitBoxesNoNDtime', p0, options, data, dataType);

% save('pOptimized','pOptimized');