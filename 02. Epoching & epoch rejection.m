close all
clear all

addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
root='D:\Drive\3 - Mask\';
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
        
        
        
        
        % SPECIFICALLY FOR MASK
        for i=1:length(EEG.event)
            if strcmp(EEG.event(i).type, 'boundary')
                idx(i) = 1;
            else
                idx(i) = 0;
            end
            if strcmp(class(EEG.event(i).type), 'char')
                EEG.event(i).type = str2num(EEG.event(i).type);
            end
        end
        EEG.event(idx==1) = []
        clear idx;
        for i=1:length(EEG.event)
           

                
                if i>1 & EEG.event(i-1).type == 10 & i+1 <= length(EEG.event)
                    EEG.event(i).stimulus = EEG.event(i).type
                    EEG.event(i).identification = EEG.event(i+1).type
                    EEG.event(i).detection = []
                    if EEG.event(i).identification == EEG.event(i).stimulus
                        EEG.event(i).corr_corr = 1;
                    else
                        EEG.event(i).corr_corr = 0;
                    end
                end


                if i>1 & EEG.event(i-1).type == 10 & i+4 <= length(EEG.event)
                    if EEG.event(i+1).type > 0 & EEG.event(i+1).type < 5
                        EEG.event(i).pas = EEG.event(i+1).type;
                    end
                    if EEG.event(i+2).type > 0 & EEG.event(i+2).type < 5
                        EEG.event(i).pas = EEG.event(i+2).type;
                    end
                    if EEG.event(i+3).type > 0 & EEG.event(i+3).type < 5
                        EEG.event(i).pas = EEG.event(i+3).type;
                    end
                    if EEG.event(i+4).type > 0 & EEG.event(i+4).type < 5
                        EEG.event(i).pas = EEG.event(i+4).type;
                    end


                end
             
        end
        
        for i=1:length(EEG.event)

            if isempty(EEG.event(i).stimulus) | isempty(EEG.event(i).pas)
                idx(i) = 1;
            else
                idx(i) = 0;
            end
        end
        EEG.event(idx ==1) = [];
        EEG.event = rmfield(EEG.event, 'detection');
        
        
        
        
        
        %EEG = pop_epoch( EEG, {'61', '62', '63', '64'}, [-2  2], 'epochinfo', 'yes');
        
        
        
        
        EEG = pop_epoch( EEG, {'101', '100', '106', '107'}, [-2  2], 'epochinfo', 'yes');
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
    catch
        warning('Something went wrong.');
        fileID = fopen([root '\log_epoching.txt'],'a');
        fprintf(fileID, 'Error in \n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n\n\n\n');
        fclose(fileID);
    end
end   
        
        