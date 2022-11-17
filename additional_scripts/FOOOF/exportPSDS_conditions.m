settings.paradigm = 5

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
pathdata = [root '\pwelch\']
mkdir([pathdata, '\pwelch_result'])
pathSaveData = [pathdata '\pwelch_result\']
pathEEGData = [root '\MARA\'];

mkdir([pathSaveData, '\highpas'])
mkdir([pathSaveData, '\lowpas'])
mkdir([pathSaveData, '\corrid'])
mkdir([pathSaveData, '\incid'])

pathLoadData = pathEEGData;
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
eeglab nogui

listdata=dir([pathdata '*.mat'  ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData)
EEG = pop_loadset('filename',listEEGData(1).name,'filepath',pathEEGData);
chanlocs = EEG.chanlocs;
[~,~,~,times,freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
clear EEG ALLCOM ALLEEG LASTCOM CURRENTSET CURRENTSTUDY STUDY PLUGINLIST currentFile channel B C participantID s
close all

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

for s=1:length(listdata)
    clear B temp
    file=listdata(s).name;
    
    B = regexp(file,'\d*','Match');
    listdata(s).participant = str2num(B{1, 1});
    listdata(s).events_num = length(events{1, str2num(B{1, 1})});
    %temp = load([FOOOFList(s).folder '\' FOOOFList(s).name]);
    %FOOOFlist(s).trials_num = length(unique(temp.trial));
end

if settings.paradigm ~= 5
    for s=[1:length(listdata)]
        file=listdata(s).name;
        temp = load([listdata(s).folder '\' file]);
        data_psds = temp.data_psds;
        participant_event = events{listdata(s).participant};
        
        idx_highpas = logical([participant_event.pas] >= 2);
        idx_lowpas = logical([participant_event.pas] == 1);
        if settings.paradigm == 1 | settings.paradigm == 4
            idx_corr = logical([participant_event.identification2] ==1);
            idx_inc = logical([participant_event.identification2] == 0);
        elseif settings.paradigm == 3
            idx_corr = logical([participant_event.corr_corr] ==1);
            idx_inc = logical([participant_event.corr_corr] == 0);
        end
        
        lowpas = squeeze(mean(mean(data_psds(settings.selected_channels, idx_lowpas, :), 2), 1));
        highpas = squeeze(mean(mean(data_psds(settings.selected_channels, idx_highpas, :), 2), 1));
        corr_id = squeeze(mean(mean(data_psds(settings.selected_channels, idx_corr, :), 2), 1));
        inc_id = squeeze(mean(mean(data_psds(settings.selected_channels, idx_inc, :), 2), 1));
        
        
        
        save([pathSaveData '\highpas\' num2str(listdata(s).participant) '.mat'],'highpas');
        save([pathSaveData '\lowpas\' num2str(listdata(s).participant) '.mat'],'lowpas');
        save([pathSaveData '\corrid\' num2str(listdata(s).participant) '.mat'],'corr_id');
        save([pathSaveData '\incid\' num2str(listdata(s).participant) '.mat'],'inc_id');
        
        
        clear lowpas highpas corr_id inc_id idx_highpas idx_lowpas idx_corr idx_inc participant_event data_psds temp file
    end
    
    
elseif settings.paradigm == 5
    mkdir([pathSaveData, '\obj\'])
    mkdir([pathSaveData, '\bgr\'])
    pathSaveData_obj = [pathSaveData '\obj\']
    pathSaveData_bgr = [pathSaveData '\bgr\']
    for s=[1:length(listdata)]
        file=listdata(s).name;
        temp = load([listdata(s).folder '\' file]);
        data_psds = temp.data_psds;
        participant_event = events{listdata(s).participant};
        
        clear idx_participant_event* participant_event_bgr participant_event_obj
        for i=1:length(participant_event)
        idx_participant_event_bgr(i) = strcmp(participant_event(i).task_type, 'background');
        idx_participant_event_obj(i) = strcmp(participant_event(i).task_type, 'object');
        end
        participant_event_bgr = participant_event(idx_participant_event_bgr);
        participant_event_obj = participant_event(idx_participant_event_obj);
        
        
        %% object
        idx_highpas = logical([participant_event_obj.pas] >= 2);
        idx_lowpas = logical([participant_event_obj.pas] == 1);

        idx_corr = logical([participant_event_obj.corrected_id] ==1);
        idx_inc = logical([participant_event_obj.corrected_id] == 0);

        
        lowpas = squeeze(mean(mean(data_psds(settings.selected_channels, idx_lowpas, :), 2), 1));
        highpas = squeeze(mean(mean(data_psds(settings.selected_channels, idx_highpas, :), 2), 1));
        corr_id = squeeze(mean(mean(data_psds(settings.selected_channels, idx_corr, :), 2), 1));
        inc_id = squeeze(mean(mean(data_psds(settings.selected_channels, idx_inc, :), 2), 1));
        
        
        
        save([pathSaveData_obj '\highpas\' num2str(listdata(s).participant) '.mat'],'highpas');
        save([pathSaveData_obj '\lowpas\' num2str(listdata(s).participant) '.mat'],'lowpas');
        save([pathSaveData_obj '\corrid\' num2str(listdata(s).participant) '.mat'],'corr_id');
        save([pathSaveData_obj '\incid\' num2str(listdata(s).participant) '.mat'],'inc_id');
        clear lowpas highpas corr_id inc_id idx_highpas idx_lowpas idx_corr idx_inc
        %% background
        idx_highpas = logical([participant_event_bgr.pas] >= 2);
        idx_lowpas = logical([participant_event_bgr.pas] == 1);

        idx_corr = logical([participant_event_bgr.corrected_id] ==1);
        idx_inc = logical([participant_event_bgr.corrected_id] == 0);

        
        lowpas = squeeze(mean(mean(data_psds(settings.selected_channels, idx_lowpas, :), 2), 1));
        highpas = squeeze(mean(mean(data_psds(settings.selected_channels, idx_highpas, :), 2), 1));
        corr_id = squeeze(mean(mean(data_psds(settings.selected_channels, idx_corr, :), 2), 1));
        inc_id = squeeze(mean(mean(data_psds(settings.selected_channels, idx_inc, :), 2), 1));
        
        
        
        save([pathSaveData_bgr '\highpas\' num2str(listdata(s).participant) '.mat'],'highpas');
        save([pathSaveData_bgr '\lowpas\' num2str(listdata(s).participant) '.mat'],'lowpas');
        save([pathSaveData_bgr '\corrid\' num2str(listdata(s).participant) '.mat'],'corr_id');
        save([pathSaveData_bgr '\incid\' num2str(listdata(s).participant) '.mat'],'inc_id');
        clear lowpas highpas corr_id inc_id idx_highpas idx_lowpas idx_corr idx_inc participant_event data_psds temp file
    end
end

