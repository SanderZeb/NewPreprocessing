close all
clear all
settings.paradigm = 6; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes; 6 - Kinga


addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')



if settings.paradigm == 1
    root = 'D:\Drive\1 - Threshold\';
elseif settings.paradigm == 2
    root = 'D:\Drive\2 - Cue\';
elseif settings.paradigm == 3
    root = 'D:\Drive\3 - Mask\';
elseif settings.paradigm == 4
    root = 'D:\Drive\4 - Faces\';
elseif settings.paradigm == 5
    root = 'D:\Drive\5 - Scenes\';
elseif settings.paradigm == 6
    root='D:\Drive\6 - Kinga\';
end

pathLoadData = [root '\Preprocessed_new_pipeline\']
mkdir([root, '\Epoching_EpochRejection'])
pathSaveData=[root '\Epoching_EpochRejection\'];
mkdir([pathSaveData, '\additional_info'])
eeglab nogui
list=dir([pathLoadData '\*.set'  ])
participants = length(list)


for s=[1:participants]
    try
        
        clear idx
        file=list(s).name;
        EEG = pop_loadset('filename',file,'filepath',pathLoadData);
        
        
        
        
        
        
        if settings.paradigm == 1
            EEG = events_threshold(EEG);
            EEG = pop_epoch( EEG, {'120', '121', '126', '127', '130', '131', '136', '137', '140', '141', '146', '147', '150', '151', '156', '157'}, [-2  2], 'epochinfo', 'yes');
        elseif settings.paradigm == 2
            EEG = events_cue(EEG);
            EEG = pop_epoch( EEG, {'61', '62', '63', '64'}, [-2  2], 'epochinfo', 'yes');
        elseif settings.paradigm == 3
            EEG = events_mask(EEG);
            EEG = pop_epoch( EEG, {'101', '100', '106', '107'}, [-2  2], 'epochinfo', 'yes');
        elseif settings.paradigm == 4
            EEG = events_faces(EEG);
            
        elseif settings.paradigm == 5
            EEG = events_scenes(EEG);
            
        elseif settings.paradigm == 6
            
            [EEG, events_result] = events_Kinga(EEG);
            
        end
        
        
        if settings.paradigm == 6 & events_result == 1
            %epochs_vals = epoch_properties(EEG, 1:size(EEG.data, 1))           % to run this line, you need to have FASTER plugin
            epochs_vals = epoch_properties(EEG, 1:64)           % to run this line, you need to have FASTER plugin
            addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
            zscored_epoch_vals = zscore(epochs_vals)
            to_reject = find(sum( abs(zscored_epoch_vals)>2 ,2))
            
            reject_idx = zeros(size(EEG.data, 3), 1)
            reject_idx(to_reject) = 1
            EEG = pop_rejepoch( EEG, reject_idx ,0);
            
            
            
            EEG = pop_saveset( EEG, 'filename', file ,'filepath', pathSaveData);
            save([pathSaveData '\additional_info\removed_trials' file '.mat'], 'to_reject')
            
            
            fileID = fopen([root '\log_epoching.txt'],'a');
            fprintf(fileID, 'success \n\n');
            fprintf(fileID,'%s %s \n',list(s).name, '\n');
            fclose(fileID);
        end
    catch
        warning('Something went wrong.');
        fileID = fopen([root '\log_epoching.txt'],'a');
        fprintf(fileID, 'Error in \n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n\n\n\n');
        fclose(fileID);
    end
end

