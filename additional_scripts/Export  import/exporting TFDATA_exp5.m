settings.paradigm = 5;

if settings.paradigm == 5
    settings.task_type = 1 % 1 for object 0 for background
end
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

%settings.times_roi = times >= -650 & times <= -50;
%settings.times_roi = times >= -1250 & times <= -700;
%settings.freqs_roi = freqs>= 8 & freqs <= 14;
settings.times_roi = times >= -800 & times <= 0;
settings.freqs_roi = freqs>= 7 & freqs <= 14;

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

%% clear mess, assign channel and participant index to files list

for s=1:length(listTFData)

    file=listTFData(s).name;

    B = regexp(file,'\d*','Match');
    listTFData(s).channel = str2num(B{1, 1})
    listTFData(s).participant = str2num(B{1, 2})
end
error_rate = 0;
for i = 1:length(events)

    participant_event = events{1, i}
    clear empty_event

    %participant_event = rmfield(participant_event, 'stimulus');

    empty_event = cellfun(@isempty, struct2cell(participant_event));
    empty_events(s) = sum(sum(empty_event));

    if sum(sum(empty_event)) > 0
        empty_event = squeeze(empty_event)';
        [empty_event_r, empty_event_c] = find(empty_event==1);

        %         if length(unique(empty_event_r)) == 1
        %             x([unique(empty_event_r)]).pas = 1;
        %             x([unique(empty_event_r)]).detection2 = 0;
        %             x([unique(empty_event_r)]).identification2 = 0;
        %
        %         end
        id_to_drop = unique(empty_event_r)
        error_rate = error_rate +1;
    else
        id_to_drop = [];
    end

    participant_event([id_to_drop]) = [];
    events2{i} = participant_event;
    %test(i).eventssss = participant_event(end).epoch;;
end

idx_selected_channels = any([listTFData.channel] == settings.selected_channels.')
new_list = listTFData(idx_selected_channels)
T = struct2table(new_list)
sortedT = sortrows(T, 'participant')
new_list = table2struct(sortedT)

%% calculate real and imaginary part of complex numbers to phase and magnitude of frequency
all = []
n=1;
error_rate = 0;
for s=1:length(new_list)

    participantID = new_list(s).participant;
    channel = new_list(s).channel;
    participant_event = events{participantID};



    participant_event = rmfield(participant_event, 'stimulus');
    clear empty_event  id_to_drop
    empty_event = cellfun(@isempty, struct2cell(participant_event));
    empty_events(s) = sum(sum(empty_event));

    if sum(sum(empty_event)) > 0
        empty_event = squeeze(empty_event)';
        [empty_event_r, empty_event_c] = find(empty_event==1);

        %         if length(unique(empty_event_r)) == 1
        %             x([unique(empty_event_r)]).pas = 1;
        %             x([unique(empty_event_r)]).detection2 = 0;
        %             x([unique(empty_event_r)]).identification2 = 0;
        %
        %         end
        id_to_drop = unique(empty_event_r);
        error_rate = error_rate +1;
    else
        id_to_drop = [];
    end

    participant_event([id_to_drop]) = [];


    temp = load([pathTFData new_list(s).name]);
    temp2 = temp.tfdata(:,:, [participant_event.epoch]);
    data_raw(n, :,:,:) = abs(temp2).^2      ;                                              % convert to (uV^2/Hz)



    if s+1 > length(new_list) || participantID ~= new_list(s+1).participant
        data_temp = squeeze(mean(data_raw, 1));
        data_db(:,:,:) = 10 * log10(data_temp) ;



        participant_event_clean = participant_event;
        participant_event_clean = rmfield(participant_event_clean, 'latency');
        participant_event_clean = rmfield(participant_event_clean, 'urevent');
        %participant_event_clean = rmfield(participant_event_clean, 'epoch');
        %try
        %participant_event_clean = rmfield(participant_event_clean, 'duration');
        %catch

        %end
        participant_event_clean = rmfield(participant_event_clean, 'identification');
        %participant_event_clean = rmfield(participant_event_clean, 'version');
        %participant_event_clean = rmfield(participant_event_clean, 'task_order');
        [participant_event_clean.id2] = participant_event_clean.corrected_id;
        participant_event_clean = rmfield(participant_event_clean,'corrected_id');

        data_db_mean = mean(squeeze(mean(data_db(settings.freqs_roi,settings.times_roi,:),1)),1);
        data_raw_mean = squeeze(mean(mean(squeeze(mean(data_raw(:, settings.freqs_roi,settings.times_roi,:),1)),1),2));
        y = mean(squeeze(mean(data_db(settings.freqs_roi,settings.times_roi,:),1)),1);
        y_standarized = (y - mean(y))/std(y);


        for(i=1:length(participant_event_clean))
            if ~(contains(class(participant_event_clean(1).type), 'int32')) & ~(contains(class(participant_event_clean(1).type), 'double'))
                for p=1:length(participant_event_clean)
                    participant_event_clean(p).type =  str2num(participant_event_clean(p).type);
                end
            end
            participant_event_clean(i).alpha_zscore = y_standarized(i);
            participant_event_clean(i).alpha_dB = data_db_mean(i);
            participant_event_clean(i).avg_dB = mean(data_db_mean);
            participant_event_clean(i).participant = participantID;


        end
        all = cat(2, all, participant_event_clean);
        n=1;
        clear temp* data*  y* participant_event*
    else
        n=n+1;
    end

    display(['Currently we are at: ' num2str(s)])
end





writetable(struct2table(all), ['D:\export\exp5_scenes_alpha.csv'])

save([pathTFData '\exp5_scenes_alpha.mat'],'all')

