close all
clear all

settings.fileType = 1; % 1 - raw (bdf); 0 - .set file
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
elseif settings.paradigm == 7
    root='C:\Users\user\Desktop\Kinga\';
end

if settings.fileType == 0
    pathLoadData = [root '\Preprocessed\']
    list=dir([pathLoadData '\*.set'  ])
elseif settings.fileType == 1
    pathLoadData = [root '\raw\']
    list=dir([pathLoadData '\*.bdf'  ])
end
participants = length(list)


mkdir([root, '\Preprocessed_new_pipeline'])
pathSaveData=[root '\Preprocessed_new_pipeline\'];
mkdir([pathSaveData, '\additional_info'])
eeglab nogui


for s=[1:participants]
    try
        
        file=list(s).name;
        ID=str2num(file(1:5));
        
        if settings.fileType == 0
            EEG = pop_loadset('filename',file,'filepath',pathLoadData);
        elseif settings.fileType == 1
            EEG = pop_biosig([pathLoadData '\' file], 'importevent','on');
        end
        addpath('C:\Users\user\Documents\GitHub\NewPreprocessing\helpers\')
        
        
        if settings.paradigm == 1
            EEG = events_thresh(EEG);
        elseif settings.paradigm == 2
            EEG = events_cue(EEG);
        elseif settings.paradigm == 3
            EEG = events_mask(EEG);
        elseif settings.paradigm == 4
            EEG = events_faces(EEG);
        elseif settings.paradigm == 5
            EEG = events_scenes(EEG);
        elseif settings.paradigm == 6
            EEG = events_Kinga(EEG);
        end
        
        EEG = pop_eegfiltnew(EEG, 'locutoff',0.5,'hicutoff',40,'plotfreqz',0);
        
        corr_threshold = 0.7;
        noise_threshold = 5;
        window_len = 5;
        max_broken_time = 0.4;
        num_samples = 50;
        subset_size = 0.25;
        %EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion','off','WindowCriterion','off','BurstRejection','off','Distance','Euclidian','channels',{'Fp1','AF7','AF3','F1','F3','F5','F7','FT7','FC5','FC3','FC1','C1','C3','C5','T7','TP7','CP5','CP3','CP1','P1','P3','P5','P7','P9','PO7','PO3','O1','Iz','Oz','POz','Pz','CPz','Fpz','Fp2','AF8','AF4','AFz','Fz','F2','F4','F6','F8','FT8','FC6','FC4','FC2','FCz','Cz','C2','C4','C6','T8','TP8','CP6','CP4','CP2','P2','P4','P6','P8','P10','PO8','PO4','O2'});
        
        EEG_all= EEG
        EEG = pop_select(EEG, 'channel', 1:64)
        channels_before_rejection = EEG.chanlocs
        
        [EEG,removed_channels] = clean_channels(EEG,corr_threshold,noise_threshold,window_len,max_broken_time,num_samples,subset_size)
        
        clear corr_threshold noise_threshold window_len max_broken_time num_samples subset_size
        
        
        EEG = pop_interp(EEG, channels_before_rejection)
        
        
        EEG.data = cat(1, EEG.data, EEG_all.data(65:size(EEG_all.data, 1), :))
        missing_chanlocs = EEG_all.chanlocs(:,65:size(EEG_all.chanlocs,2))
        EEG.chanlocs = cat(2, EEG.chanlocs, missing_chanlocs)
        EEG.nbchan = size(EEG.chanlocs,2)
        
        EEG = pop_saveset( EEG, 'filename', file ,'filepath', pathSaveData);
        save([pathSaveData '\additional_info\removed_channels' file '.mat'], 'removed_channels')
        %save([pathSaveData '\additional_info\chanlocs_' file '.mat'], 'EEG.chanlocs')
        
        
        
        fileID = fopen([root '\log_preprocessing.txt'],'a');
        fprintf(fileID, 'success in Preprocessing\n\n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n');
        fclose(fileID);
    catch
        warning('Something went wrong.');
        fileID = fopen([root '\log.txt'],'a');
        fprintf(fileID, 'Error in pipeline\n');
        fprintf(fileID,'%s %s \n',list(s).name, '\n');
        fclose(fileID);
    end
end