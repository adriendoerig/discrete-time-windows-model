% OPTIMIZEALL finds optimal parameters for all conditions, subjects and
% averages. Fits the explosion data.

clear

readoutTime = .45;

% directory management
progPath = fileparts(which(mfilename)); % The program directory
cd(progPath) % go there just in case we are far away
addpath(genpath(progPath)); % add the folder and subfolders to path

% if there's no results directory, create one
if exist([progPath, '\results\'], 'dir') == 0
    mkdir('results');
end

% run over everything and optimize
% for expType = [{'E4'}, {'E8'}, {'E18'}, {'All'}]
for expType = [{'All'}]
    
    cd(progPath)
    
    % create a file for this expType if it doesn' exist
    if exist([progPath,  '\results\', expType{1}], 'dir') == 0
        cd([progPath, '\results'])
        mkdir(expType{1});
    end
    
    resPath = [progPath, '\results\', expType{1}]; % path to data folder
  
    %nSubjects = 8;
    
    for subjectID = 1%:nSubjects+1 % LAST ENTRY contains the average over subjects
        
        disp(['optimizing ', expType{1}, ' for subject ', num2str(subjectID), ' (subject ', num2str(nSubjects+1), ' = is avg of all subjects).'])
        
        cd(progPath)
        
        % compute best params, plot output with these params for this condition and save plot
        pOpt = fitParametersBoxesNoNDtimeChooseReadoutTime(expType{1},subjectID, readoutTime);
        
        % save best params
        cd(resPath)
        if subjectID == nSubjects+1
            save('average_best_parameters','pOpt')
            plotOutputNoNDtimeChooseReadoutTime(pOpt, expType{1}, subjectID, readoutTime, 'best_average_parameters_plot');
        else
            save(['subject_', num2str(subjectID), '_best_parameters'],'pOpt')
            plotOutputNoNDtimeChooseReadoutTime(pOpt, expType{1}, subjectID, readoutTime, ['subject_', num2str(subjectID), '_best_parameters_plot']);
        end

    end

end

cd(progPath)
        