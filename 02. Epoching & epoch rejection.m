close all
clear all

addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
root='D:\Drive\2 - Cue\';
pathLoadData = [root '\Preprocessed\']
mkdir([root, '\Rejected_trials'])
pathSaveData=[root '\Rejected_trials\'];
mkdir([pathSaveData, '\additional_info'])
eeglab nogui
list=dir([pathLoadData '\*.set'  ])
participants = length(list)


for s=[1:participants]
    try
        file=list(s).name;
        EEG = pop_loadset('filename',file,'filepath',pathLoadData);
        
        EEG = pop_epoch( EEG, {'61', '62', '63', '64'}, [-2  2], 'epochinfo', 'yes');
        
        epochs_vals = epoch_properties(EEG, 1:size(EEG.data, 1))           % to run this line, you need to have FASTER plugin
        addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
        zscored_epoch_vals = zscore(epochs_vals)
        to_reject = find(sum( abs(zscored_epoch_vals)>3 ,2))
        
        reject_idx = zeros(size(EEG.data, 3), 1)
        reject_idx(to_reject) = 1
        EEG = pop_rejepoch( EEG, reject_idx ,0);
        
        
        
        EEG = pop_saveset( EEG, 'filename', file ,'filepath', pathSaveData);
        save([pathSaveData '\additional_info\removed_trials' file '.mat'], 'to_reject')
        
        
        fileID = fopen([start '\log_epoching.txt'],'a');
        fprintf(fileID, 'success \n\n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n');
        fclose(fileID);
    catch
        warning('Something went wrong.');
        fileID = fopen([start '\log_epoching.txt'],'a');
        fprintf(fileID, 'Error in \n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n\n\n\n');
        fclose(fileID);
    end
end   
        
        