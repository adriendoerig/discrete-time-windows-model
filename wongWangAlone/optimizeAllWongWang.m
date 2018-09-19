% OPTIMIZEALL finds optimal parameters for all conditions, subjects and
% averages. Fits the explosion data.

clear

% directory management
progPath = fileparts(which(mfilename)); % The program directory
cd(progPath) % go there just in case we are far away
addpath(genpath(progPath)); % add the folder and subfolders to path

% if there's no results directory, create one
if exist([progPath, '\results\'], 'dir') == 0
    mkdir('results');
end

% run over everything and optimize
for expType = [{'E4'}, {'E8'}, {'E18'}]
    
    cd(progPath)
    
    % create a file for this expType if it doesn' exist
    if exist([progPath,  '\results\', expType{1}], 'dir') == 0
        cd([progPath, '\results'])
        mkdir(expType{1});
    end
    
    resPath = [progPath, '\results\', expType{1}]; % path to data folder
  
    for subjectID = 1:7 % 7 contains the average over subjects for that expType
        
        disp(['optimizing ', expType{1}, ' for subject ', num2str(subjectID), ' (subject 7 = is avg of all subjects).'])
        
        cd(progPath)
        
        % compute best params, plot output with these params for this condition and save plot
        pOpt = fitParametersWongWang(expType{1},subjectID);
        
        % save best params
        cd(resPath)
        if subjectID == 7
            save('average_best_parameters','pOpt')
            plotOutputWongWang(pOpt, expType{1}, subjectID, 'best_average_parameters_plot');
        else
            save(['subject_', num2str(subjectID), '_best_parameters'],'pOpt')
            plotOutputWongWang(pOpt, expType{1}, subjectID, ['subject_', num2str(subjectID), '_best_parameters_plot']);
        end

    end

end

cd(progPath)
        