settings.paradigm = 1

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
end
pathEEGData = [root '\MARA\']
pathSaveData = [root '\PSDS_mean\']
pathLoadData = pathEEGData;
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
eeglab nogui

listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData)
EEG = pop_loadset('filename',listEEGData(1).name,'filepath',pathEEGData);
chanlocs = EEG.chanlocs;
[~,~,~,times,freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
clear EEG ALLCOM ALLEEG LASTCOM CURRENTSET CURRENTSTUDY STUDY PLUGINLIST currentFile channel B C participantID s
close all

settings.times_roi = times >= -650 & times <= -50;
settings.freqs_roi = freqs>= 8 & freqs <= 14;

channels(1).M1 = find(strcmp({chanlocs.labels}, 'M1')==1);  			%INDEX CHANNEL
channels.M2 = find(strcmp({chanlocs.labels}, 'M2')==1);              	%INDEX CHANNEL
channels.CP1 = find(strcmp({chanlocs.labels}, 'CP1')==1);
channels.CPz = find(strcmp({chanlocs.labels}, 'CPz')==1);
channels.CP2 = find(strcmp({chanlocs.labels}, 'CP2')==1);
channels.P1 = find(strcmp({chanlocs.labels}, 'P1')==1);
channels.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1);
channels.P2 = find(strcmp({chanlocs.labels}, 'P2')==1);
channels.O1 = find(strcmp({chanlocs.labels}, 'O1')==1);
channels.Oz = find(strcmp({chanlocs.labels}, 'Oz')==1);
channels.O2 = find(strcmp({chanlocs.labels}, 'O2')==1);
channels.PO7 = find(strcmp({chanlocs.labels}, 'PO7')==1);
channels.PO8 = find(strcmp({chanlocs.labels}, 'PO8')==1);
channels.PO3 = find(strcmp({chanlocs.labels}, 'PO3')==1);
channels.PO4 = find(strcmp({chanlocs.labels}, 'PO4')==1);
channels.POz = find(strcmp({chanlocs.labels}, 'POz')==1);
channels.P1 = find(strcmp({chanlocs.labels}, 'P1')==1);
channels.P2 = find(strcmp({chanlocs.labels}, 'P2')==1);
channels.P3 = find(strcmp({chanlocs.labels}, 'P3')==1);
channels.P4 = find(strcmp({chanlocs.labels}, 'P4')==1);
channels.P5 = find(strcmp({chanlocs.labels}, 'P5')==1);
channels.P6 = find(strcmp({chanlocs.labels}, 'P6')==1);
channels.P7 = find(strcmp({chanlocs.labels}, 'P7')==1);
channels.P8 = find(strcmp({chanlocs.labels}, 'P8')==1);
channels.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1);
channels.Iz = find(strcmp({chanlocs.labels}, 'Iz')==1);
channels.VEOG = find(strcmp({chanlocs.labels}, 'VEOG')==1);									%INDEX CHANNEL
channels.HEOG = find(strcmp({chanlocs.labels}, 'HEOG')==1);									%INDEX CHANNEL

settings.selected_channels = [channels.O1 channels.Oz channels.O2 channels.PO7 channels.PO8 channels.PO3 channels.PO4 channels.POz channels.Iz channels.P1 channels.Pz channels.P2 channels.P3 channels.P5 channels.P7];


try
    
    load([root 'events.mat']);
    fileEEGData=listEEGData(1).name;
    EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
    
catch
    for s=[1:participants]
        fileEEGData=listEEGData(s).name;
        EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
        if settings.paradigm ==1
            EEG = pop_selectevent( EEG, 'type',[120 121 126 127 130 131 136 137 140 141 146 147 150 151 156 157] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 2
            EEG = pop_selectevent( EEG, 'type',[61 62 63 64] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 3
            EEG = pop_selectevent( EEG, 'type',[101 100 106 107] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 4
            EEG = pop_selectevent( EEG, 'type',[103 104] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 5
            
        end
        chanlocs_all{s} = EEG.chanlocs;
        events{s} = EEG.event;
    end
    save([root 'events.mat'], 'events');
end
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY








for s=[1:length(listEEGData)]
    file=listEEGData(s).name;
    EEG = pop_loadset('filename',file,'filepath',pathLoadData);
    EEG = pop_selectevent( EEG, 'type',[120 121 126 127 130 131 136 137 140 141 146 147 150 151 156 157] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
    participant_event = EEG.event;
    
    idx_highpas = logical([participant_event.pas] >= 3);
    idx_lowpas = logical([participant_event.pas] < 3);
    idx_corr = logical([participant_event.identification2] ==1);
    idx_inc = logical([participant_event.identification2] == 0);
    
    data_all_lowpas = squeeze(mean(mean(EEG.data(settings.selected_channels,settings.times_roi, idx_lowpas), 3), 1));
    data_all_highpas = squeeze(mean(mean(EEG.data(settings.selected_channels,settings.times_roi, idx_highpas), 3), 1));
    data_all_corr_id = squeeze(mean(mean(EEG.data(settings.selected_channels,settings.times_roi, idx_corr), 3), 1));
    data_all_inc_id = squeeze(mean(mean(EEG.data(settings.selected_channels,settings.times_roi, idx_inc), 3), 1));
    
    %clear tfdata data_psds
    tic

    addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal');
    if any(isnan([data_all_highpas]))
        data_psds_highpas(s,:) = 0;
    else
        [psds, freqs] = pwelch(data_all_lowpas, [], [], [], EEG.srate);
        
        Pxx = periodogram(data_all_lowpas.', 'power')
        psds = psds';
        data_psds_lowpas(s,:)= psds;
        
        clear freqs psds
    end
    if any(isnan([data_all_highpas]))
        data_psds_highpas(s,:) = 0;
    else
        [psds, freqs] = pwelch(data_all_highpas, [], [], [], EEG.srate);
        psds = psds';
        data_psds_highpas(s,:) = psds;
        clear freqs psds
    end
    
    if any(isnan([data_all_highpas]))
        data_psds_highpas(s,:) = 0;
    else
        [psds, freqs] = pwelch(data_all_corr_id, [], [], [], EEG.srate);
        psds = psds';
        data_psds_corr_id(s,:) = psds;
        clear freqs psds
    end
    
    if any(isnan([data_all_highpas]))
        data_psds_highpas(s,:) = 0;
    else
        [psds, freqs] = pwelch(data_all_inc_id, [], [], [], EEG.srate);
        psds = psds';
        data_psds_inc_id(s,:) = psds;
        clear freqs psds
    end
    toc
    
    clear data_all*
    close all
    
    
    display(['processing: ' num2str(s) ' out of ' num2str(length(listEEGData))]);
    
end


    save([  pathSaveData '/pwelch_participant_lowpas'], 'data_psds_lowpas', '-v7.3')  ;
    save([  pathSaveData '/pwelch_participant_highpas'], 'data_psds_highpas', '-v7.3')  ;
    save([  pathSaveData '/pwelch_participant_corr_id'], 'data_psds_corr_id', '-v7.3')  ;
    save([  pathSaveData '/pwelch_participant_inc_id'], 'data_psds_inc_id', '-v7.3')  ;