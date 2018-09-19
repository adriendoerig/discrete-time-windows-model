% directory management
progPath = fileparts(which(mfilename)); % The program directory
cd(progPath) % go there just in case we are far away
addpath(genpath(progPath)); % add the folder and subfolders to path

for tStart = [.1056, .45]
    
    if tStart == .1056
        baseFolder = 'results\explosion_tstart_mean_of_fusion_fit';
    else
        baseFolder = 'results\explosion_tstart_450ms';
    end
    
    
    for expType = [{'E4'}, {'E8'}, {'E18'}]
        
        for subjectID = 1:7
            
            folder = [progPath, filesep, baseFolder, filesep, expType{1}];
            cd(folder)
            
            if subjectID == 7
                pOpt = loadSingleVariableMATFile('average_best_parameters.mat');
                plotOutputRuter(pOpt, expType{1}, subjectID, tStart, 'best_average_parameters_plot');
            else
                pOpt = loadSingleVariableMATFile(['subject_', num2str(subjectID), '_best_parameters.mat']);
                plotOutputRuter(pOpt, expType{1}, subjectID, tStart, ['subject_', num2str(subjectID), '_best_parameters_plot']);
            end
            
            cd(progPath)
        end
        
    end
    
end
