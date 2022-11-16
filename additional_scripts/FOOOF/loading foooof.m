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
pathTFData = [root '\tfdata\']
pathEEGData = [root '\MARA\']
savepath = [pathTFData '\export\']

addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
eeglab nogui

listTFData=dir([pathTFData 'tfdata*.mat'  ]);
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


foooofy = 'C:\Users\user\Desktop\Nowy folder\participants';
FOOOFList = dir([foooofy '\*\*.mat']);

settings.selected_channels_2 = settings.selected_channels-1; % correction for python convention - starting from 0 instead of 1

for s=1:length(FOOOFList)
    clear B temp 
    file=FOOOFList(s).name;
    
    B = regexp(file,'\d*','Match');
    FOOOFList(s).participant = str2num(B{1, 1});
    FOOOFList(s).events_num = length(events{1, str2num(B{1, 1})});
    %temp = load([FOOOFList(s).folder '\' FOOOFList(s).name]);
    %FOOOFlist(s).trials_num = length(unique(temp.trial));
end


for i=1:length(FOOOFList)
    
    clear idx* FOOOOFfile* participant_events FOOOOFparticipant
   FOOOOFfile = load([FOOOFList(i).folder '\' FOOOFList(i).name]);
   FOOOOFparticipant = FOOOFList(i).participant;
   
  % if length(unique(FOOOOFfile.trial)) == length(events{1,FOOOOFparticipant})
       participant_events = events{1,FOOOOFparticipant};
  % else
  %     display('ERRRRRRORRRRRRR');
  % end
   
    idx_channels = any([FOOOOFfile.channel] == [settings.selected_channels_2.']);
    
    FOOOOFfile_selected.channel = FOOOOFfile.channel(idx_channels);
    FOOOOFfile_selected.trial= FOOOOFfile.channel(idx_channels);
    FOOOOFfile_selected.results = FOOOOFfile.results(idx_channels);

    
%     idx_pas4 = [participant_events.pas] == 4;
%     idx_pas3 = [participant_events.pas] == 3;
%     idx_pas2 = [participant_events.pas] == 2;
%     idx_pas1 = [participant_events.pas] == 1;
    idx_pas4 = find([participant_events.pas] == 4);
    idx_pas3 = find([participant_events.pas] == 3);
    idx_pas2 = find([participant_events.pas] == 2);
    idx_pas1 = find([participant_events.pas] == 1);
    
    
    idx_id_corr = find([participant_events.identification2] == 1);
    idx_id_inc = find([participant_events.identification2] == 0);
    
    idx.pas4_corrected = idx_pas4-1;
    %idx.pas4_corrected = idx_pas4;
    idx.pas4_trials = any([FOOOOFfile_selected.trial] == [idx.pas4_corrected.']);
    
    idx.pas3_corrected = idx_pas3-1;
    %idx.pas3_corrected = idx_pas3;
    idx.pas3_trials = any([FOOOOFfile_selected.trial] == [idx.pas3_corrected.']);
    
    idx.pas2_corrected = idx_pas2-1;
    %idx.pas2_corrected = idx_pas2;
    idx.pas2_trials = any([FOOOOFfile_selected.trial] == [idx.pas2_corrected.']);
    
    idx.pas1_corrected = idx_pas1-1;
    %idx.pas1_corrected = idx_pas1;
    idx.pas1_trials = any([FOOOOFfile_selected.trial] == [idx.pas1_corrected.']);
    
    idx.corr_corrected = idx_id_corr-1;
    %idx.corr_corrected = idx_id_corr;
    idx.corr_trials = any([FOOOOFfile_selected.trial] == [idx.corr_corrected.']);
    
    idx.inc_corrected = idx_id_inc-1;
    %idx.inc_corrected = idx_id_inc;
    idx.inc_trials = any([FOOOOFfile_selected.trial] == [idx.inc_corrected.']);
    
    FOOOOFfile_selected.pas4 = FOOOOFfile_selected.results(idx.pas4_trials);
    FOOOOFfile_selected.pas3 = FOOOOFfile_selected.results(idx.pas3_trials);
    FOOOOFfile_selected.pas2 = FOOOOFfile_selected.results(idx.pas2_trials);
    FOOOOFfile_selected.pas1 = FOOOOFfile_selected.results(idx.pas1_trials);
    
    FOOOOFfile_selected.corr = FOOOOFfile_selected.results(idx.corr_trials);
    FOOOOFfile_selected.inc = FOOOOFfile_selected.results(idx.inc_trials);
    
    for n=1:length(FOOOOFfile_selected.pas4)
       aperiodic_params.pas4(i, n,:) = [FOOOOFfile_selected.pas4{1,n}.aperiodic_params];
       r_squared.pas4(i, n,:) = [FOOOOFfile_selected.pas4{1,n}.r_squared];
       error.pas4(i, n,:) = [FOOOOFfile_selected.pas4{1,n}.error];
    end 
    for n=1:length(FOOOOFfile_selected.pas3)
       aperiodic_params.pas3(i, n,:) = [FOOOOFfile_selected.pas3{1,n}.aperiodic_params];
       r_squared.pas3(i, n,:) = [FOOOOFfile_selected.pas3{1,n}.r_squared];
       error.pas3(i, n,:) = [FOOOOFfile_selected.pas3{1,n}.error];
    end   
    for n=1:length(FOOOOFfile_selected.pas2)
       aperiodic_params.pas2(i, n,:) = [FOOOOFfile_selected.pas2{1,n}.aperiodic_params];
       r_squared.pas2(i, n,:) = [FOOOOFfile_selected.pas2{1,n}.r_squared];
       error.pas2(i, n,:) = [FOOOOFfile_selected.pas2{1,n}.error];
    end   
    for n=1:length(FOOOOFfile_selected.pas1)
       aperiodic_params.pas1(i, n,:) = [FOOOOFfile_selected.pas1{1,n}.aperiodic_params];
       r_squared.pas1(i, n,:) = [FOOOOFfile_selected.pas1{1,n}.r_squared];
       error.pas1(i, n,:) = [FOOOOFfile_selected.pas1{1,n}.error];
    end      
    
    for n=1:length(FOOOOFfile_selected.corr)
       aperiodic_params.corr(i, n,:) = [FOOOOFfile_selected.corr{1,n}.aperiodic_params];
       r_squared.corr(i, n,:) = [FOOOOFfile_selected.corr{1,n}.r_squared];
       error.corr(i, n,:) = [FOOOOFfile_selected.corr{1,n}.error];
    end      
    for n=1:length(FOOOOFfile_selected.inc)
       aperiodic_params.inc(i, n,:) = [FOOOOFfile_selected.inc{1,n}.aperiodic_params];
       r_squared.inc(i, n,:) = [FOOOOFfile_selected.inc{1,n}.r_squared];
       error.inc(i, n,:) = [FOOOOFfile_selected.inc{1,n}.error];
    end      
    
        
end

aperiodic_pas = [squeeze(mean(aperiodic_params.pas1(:,:,1),2, 'omitnan')) squeeze(mean(aperiodic_params.pas2(:,:,1),2, 'omitnan'))  squeeze(mean(aperiodic_params.pas3(:,:,1),2, 'omitnan')) squeeze(mean(aperiodic_params.pas4(:,:,1),2, 'omitnan'))];
periodic_pas =  [squeeze(mean(aperiodic_params.pas1(:,:,2),2, 'omitnan')) squeeze(mean(aperiodic_params.pas2(:,:,2),2, 'omitnan'))  squeeze(mean(aperiodic_params.pas3(:,:,2),2, 'omitnan')) squeeze(mean(aperiodic_params.pas4(:,:,2),2, 'omitnan'))];

figure; hold on
title('aperiodic')
boxplot(aperiodic_pas)
xlabel('PAS value')
ylabel('Expotent')
ylim([-0.2 1.5])


figure; hold on
title('periodic')
boxplot(periodic_pas)
xlabel('PAS value')
ylabel('Expotent')
ylim([-0.2 1.5])


aperiodic_cor = [squeeze(mean(aperiodic_params.corr(:,:,1),2, 'omitnan')) squeeze(mean(aperiodic_params.inc(:,:,1),2, 'omitnan'))];
periodic_corr = [squeeze(mean(aperiodic_params.corr(:,:,2),2, 'omitnan')) squeeze(mean(aperiodic_params.inc(:,:,2),2, 'omitnan')) ];

figure; hold on
title('aperiodic')
boxplot(aperiodic_cor)
xlabel('Correctness')
ylabel('Expotent')
ylim([-0.2 1.5])
xticklabels({'1','0'})

figure; hold on
title('periodic')
boxplot(periodic_corr)
xlabel('Correctness')
ylabel('Expotent')
ylim([-0.2 1.5])
xticklabels({'1','0'})

r_squared_pas = [squeeze(mean(r_squared.pas1,2, 'omitnan')) squeeze(mean(r_squared.pas2,2, 'omitnan')) squeeze(mean(r_squared.pas3,2, 'omitnan')) squeeze(mean(r_squared.pas4,2, 'omitnan'))];
error_pas = [ squeeze(mean(error.pas1,2, 'omitnan')) squeeze(mean(error.pas2,2, 'omitnan')) squeeze(mean(error.pas3,2, 'omitnan')) squeeze(mean(error.pas4,2, 'omitnan'))];

figure; hold on
title('Goodness of fit')
boxplot(r_squared_pas)
boxplot(error_pas)
xlabel('Correctness')
ylabel('Expotent')
ylim([-0.2 1.5])
xticklabels({'1','0'})

r_squared_corr = [squeeze(mean(r_squared.corr,2, 'omitnan')) squeeze(mean(r_squared.inc,2, 'omitnan')) ];
error_corr = [ squeeze(mean(error.corr,2, 'omitnan')) squeeze(mean(error.inc,2, 'omitnan')) ];
