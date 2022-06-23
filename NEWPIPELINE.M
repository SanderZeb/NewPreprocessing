close all
clear all

addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
root='D:\Drive\2 - Cue\';
path = [root '\raw\']
mkdir([root, '\Preprocessed_test'])
pathSaveData=[root '\Preprocessed_test\'];
mkdir([pathSaveData, '\additional_info'])
eeglab nogui
list=dir([path '\*.bdf'  ])
participants = length(list)


for s=[1:participants]
    try
    path = [root '\raw\']
    mkdir([root, '\Preprocessed_test'])
    pathSaveData=[root '\Preprocessed_test\'];
    mkdir([pathSaveData, '\additional_info'])
    file=list(s).name;
    
    ID=str2num(file(1:5));
    EEG = pop_biosig([path '\' file], 'importevent','on');  
    addpath('C:\Users\user\Documents\GitHub\NewWayOfPreprocessingEEG')
    EEG = events_cue(EEG)
    
    
    EEG=pop_chanedit(EEG, 'changefield',{65,'labels','HEOG'},'changefield',{65,'type','EOG'},'rplurchanloc',1);
    EEG=pop_chanedit(EEG, 'changefield',{66,'labels','HEOG2'},'changefield',{66,'type','EOG'},'rplurchanloc',1);
    EEG=pop_chanedit(EEG, 'changefield',{67,'labels','VEOG'},'changefield',{67,'type','EOG'},'rplurchanloc',1);
    EEG=pop_chanedit(EEG, 'changefield',{68,'labels','VEOG2'},'changefield',{68,'type','EOG'},'rplurchanloc',1);
    EEG=pop_chanedit(EEG, 'changefield',{69,'labels','Heartrate'},'changefield',{69,'type','ECG'},'rplurchanloc',1);
    EEG=pop_chanedit(EEG, 'changefield',{71,'labels','M1'},'changefield',{71,'type','EEG'},'rplurchanloc',1);
    EEG=pop_chanedit(EEG, 'changefield',{72,'labels','M2'},'changefield',{72,'type','EEG'},'rplurchanloc',1);
    EEG=pop_select(EEG, 'nochannel',{'EXG6', 'GSR1', 'GSR2', 'Erg1', 'Erg2', 'Resp', 'Plet', 'Temp'});
    
    EEG=pop_chanedit(EEG, 'lookup','C:\Users\user\Desktop\eeglab2020_0\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp');
    cd('C:\Program Files\MATLAB\R2019b\toolbox\signal');
    
    channels_before_rejection = EEG.chanlocs
    
    
    EEG = pop_eegfiltnew(EEG, 'locutoff',0.5,'hicutoff',40,'plotfreqz',0);
    %EEG = pop_eegfiltnew(EEG, 'locutoff',49,'hicutoff',51,'revfilt',1,'plotfreqz',0);
    
    EEG = pop_resample( EEG, 256);
    
    corr_threshold = 0.85;
    noise_threshold = 4;
    window_len = 5;
    max_broken_time = 0.4;
    num_samples = 50;
    subset_size = 0.25;
    
    [EEG,removed_channels] = clean_channels(EEG,corr_threshold,noise_threshold,window_len,max_broken_time,num_samples,subset_size)
    
    clear corr_threshold noise_threshold window_len max_broken_time num_samples subset_size
    
    EEG = pop_interp(EEG, channels_before_rejection)
    
    EEG = pop_saveset( EEG, 'filename', file ,'filepath', pathSaveData);
    save([pathSaveData '\additional_info\removed_channels' file '.mat'], 'removed_channels')
    %clear EEG channels_before_rejection
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            events arranging             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    idx_cue = [EEG.event.type] == 61 | [EEG.event.type] == 62 | [EEG.event.type] == 63 | [EEG.event.type] == 64
    idx_cue2 = find(idx_cue)
    idx_stim = [EEG.event.type] == 130 | [EEG.event.type] == 131 | [EEG.event.type] == 137  | [EEG.event.type] == 136  | [EEG.event.type] == 120 | [EEG.event.type] == 121 | [EEG.event.type] == 127 | [EEG.event.type] == 126 | [EEG.event.type] == 140 | [EEG.event.type] == 141 | [EEG.event.type] == 147 | [EEG.event.type] == 146 | [EEG.event.type] == 150 | [EEG.event.type] == 151 | [EEG.event.type] == 157 | [EEG.event.type] == 156
    idx_stim2 = find(idx_stim)
    idx = idx_cue + idx_stim
    events = EEG.event(boolean(idx))
    events_backup = EEG.event
    for(i=1:length(events))
        if events(i).type > 100 & events(i-1).type == events(i).cue
            events(i-1).detection = events(i).detection
            events(i-1).identification = events(i).identification
            events(i-1).pas = events(i).pas
            events(i-1).corr_corr = events(i).corr_corr
            events(i-1).cue = events(i).cue
            events(i-1).detection2 = events(i).detection2
            events(i-1).identification2 = events(i).identification2
            events(i-1).stimulus = events(i).type
            events(i).stimulus = events(i).type
        end
    end
    
    %idx_cue_events = [events.type] == 61 | [events.type] == 62 | [events.type] == 63 | [events.type] == 64
    clear EEG.event
    EEG.event = events
    
    clear idx*
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
    EEG = pop_epoch( EEG, {'61', '62', '63', '64'}, [-2  2], 'epochinfo', 'yes');
    
    epochs_vals = epoch_properties(EEG, 1:size(EEG.data, 1))           % to run this line, you need to have FASTER plugin
    zscored_epoch_vals = zscore(epochs_vals)
    to_reject = find(sum( abs(zscored_epoch_vals)>3 ,2))
    
    reject_idx = zeros(size(EEG.data, 3), 1)
    reject_idx(to_reject) = 1
    EEG = pop_rejepoch( EEG, reject_idx ,0);
    
    
    mkdir([root, '\Rejected_trials'])
    pathSaveData=[root '\Rejected_trials\'];
    mkdir([pathSaveData, '\additional_info'])
    EEG = pop_saveset( EEG, 'filename', file ,'filepath', pathSaveData);
    save([pathSaveData '\additional_info\removed_trials' file '.mat'], 'to_reject')
    
    
    
    EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
    [artcomps, info] = MARA(EEG);
    
    mkdir([root, '\ICA'])
    pathSaveData=[root '\ICA\'];
    mkdir([pathSaveData, '\additional_info'])
    EEG = pop_saveset( EEG, 'filename', file ,'filepath', pathSaveData);
    save([pathSaveData '\additional_info\MARA_components' file '.mat'], 'artcomps')
    save([pathSaveData '\additional_info\MARA_info' file '.mat'], 'info')
    
   
        fileID = fopen([start '\log.txt'],'a');
        fprintf(fileID, 'success in ICA\n\n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n');
        fclose(fileID);
    catch
        warning('Something went wrong.');
        fileID = fopen([start '\log.txt'],'a');
        fprintf(fileID, 'Error in pipeline\n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n');
        fclose(fileID);
    end
end