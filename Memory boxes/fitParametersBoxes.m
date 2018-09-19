% Run this to fit parameters with fminsearch

global nruns;                           % iteration counter
nruns = 0;
global firstErr;
firstErr = 100000000000000;             % will remember the first error.
global minErr;
minErr = 100000000000000;               % minimal error (will be updated as we optimize).

% load from excel file NOTE: if an error comes up saying the worksheet 
% could not be activated, open the excel file, switch to Sheet1 and save.
% if it still doesn't work, close and reopen matlab.
makeData                                % get experimental data

subjectNumber = 1;                      % choose which subject to fit
data = dataLength8{subjectNumber};     % choose which experimental data to use

p0 = 0.25*ones(1,7);                     % initial parameters (but see function pTranform)

options = optimset('DiffMinChange', 0.1, 'DiffMaxChange', 10, 'MaxFunEvals', 1000);

pOptimized = fminsearchOS('errorFitBoxes', p0, options, data);

save('pOptimized','pOptimized');