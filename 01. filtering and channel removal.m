close all
clear all

addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
root='D:\Drive\2 - Cue\';
path = [root '\raw\']
mkdir([root, '\Preprocessed_test'])
pathSaveData=[root '\Preprocessed\'];
mkdir([pathSaveData, '\additional_info'])
eeglab nogui
list=dir([path '\*.bdf'  ])
participants = length(list)


for s=[1:participants]
    try
        
        file=list(s).name;
        ID=str2num(file(1:5));
        EEG = pop_biosig([path '\' file], 'importevent','on');
        addpath('C:\Users\user\Documents\GitHub\NewWayOfPreprocessingEEG')
        EEG = events_cue(EEG) % my own script for managing events
        
        
        EEG=pop_chanedit(EEG, 'changefield',{65,'labels','HEOG'},'changefield',{65,'type','EOG'},'rplurchanloc',1);
        EEG=pop_chanedit(EEG, 'changefield',{66,'labels','HEOG2'},'changefield',{66,'type','EOG'},'rplurchanloc',1);
        EEG=pop_chanedit(EEG, 'changefield',{67,'labels','VEOG'},'changefield',{67,'type','EOG'},'rplurchanloc',1);
        EEG=pop_chanedit(EEG, 'changefield',{68,'labels','VEOG2'},'changefield',{68,'type','EOG'},'rplurchanloc',1);
        EEG=pop_chanedit(EEG, 'changefield',{69,'labels','Heartrate'},'changefield',{69,'type','ECG'},'rplurchanloc',1);
        EEG=pop_chanedit(EEG, 'changefield',{71,'labels','M1'},'changefield',{71,'type','EEG'},'rplurchanloc',1);
        EEG=pop_chanedit(EEG, 'changefield',{72,'labels','M2'},'changefield',{72,'type','EEG'},'rplurchanloc',1);
        EEG=pop_select(EEG, 'nochannel',{'EXG6', 'GSR1', 'GSR2', 'Erg1', 'Erg2', 'Resp', 'Plet', 'Temp'});
        
        EEG=pop_chanedit(EEG, 'lookup','C:\Users\user\Desktop\eeglab2020_0\plugins\dipfit\standard_BESA\standard-10-5-cap385.elp');
        addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal');
        
        channels_before_rejection = EEG.chanlocs
        
        
        EEG = pop_eegfiltnew(EEG, 'locutoff',0.5,'hicutoff',40,'plotfreqz',0);
        %EEG = pop_eegfiltnew(EEG, 'locutoff',49,'hicutoff',51,'revfilt',1,'plotfreqz',0);
        
        EEG = pop_resample( EEG, 256);
        
        corr_threshold = 0.85; %Correlation threshold. If a channel is correlated at less than this value to its robust estimate (based on other channels), it is considered abnormal in the given time window. 
        noise_threshold = 4; %If a channel has more line noise relative to its signal than this value, in standard deviations from the channel population mean, it is considered abnormal.
        window_len = 5; %Length of the windows (in seconds) for which correlation is computed
        max_broken_time = 0.4; %Maximum time (either in seconds or as fraction of the recording) during which a retained channel may be broken
        num_samples = 50; %Number of RANSAC samples. This is the number of samples to generate in the random sampling consensus process. The larger this value, the more robust but also slower   %the processing will be.
        subset_size = 0.25; %Subset size. This is the size of the channel subsets to use for robust reconstruction, as a fraction of the total number of channels.
        
        [EEG,removed_channels] = clean_channels(EEG,corr_threshold,noise_threshold,window_len,max_broken_time,num_samples,subset_size)
        
        clear corr_threshold noise_threshold window_len max_broken_time num_samples subset_size
        
        EEG = pop_interp(EEG, channels_before_rejection)
        
        EEG = pop_saveset( EEG, 'filename', file ,'filepath', pathSaveData);
        save([pathSaveData '\additional_info\removed_channels' file '.mat'], 'removed_channels')
        
        
        
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
