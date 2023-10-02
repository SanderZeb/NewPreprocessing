settings.paradigm = 3;
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

settings.times_roi = times >= -1200 & times <= 0;
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
settings.selected_channels_left = [channels.O1  channels.PO3  channels.PO7 channels.P1 channels.P3 channels.P5 channels.P7]
settings.selected_channels_right = [channels.O2  channels.PO4  channels.PO8 channels.P2 channels.P4 channels.P6 channels.P8]

try
    
    load([root 'events_new.mat']);
    events = events_new;
    
catch
    display('not found events mixed with behawior');
%     for s=[1:participants]
%         fileEEGData=listEEGData(s).name;
%         EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
%         if settings.paradigm ==1
%             EEG = pop_selectevent( EEG, 'type',[120 121 126 127 130 131 136 137 140 141 146 147 150 151 156 157] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
%         elseif settings.paradigm == 2
%             EEG = pop_selectevent( EEG, 'type',[61 62 63 64] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
%         elseif settings.paradigm == 3
%             EEG = pop_selectevent( EEG, 'type',[101 100 106 107] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
%         elseif settings.paradigm == 4
%             EEG = pop_selectevent( EEG, 'type',[103 104] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
%         elseif settings.paradigm == 5
%             
%         end     
%         chanlocs_all{s} = EEG.chanlocs;
%         events{s} = EEG.event;
%     end
%     save([root 'events.mat'], 'events');
end

%% clear mess, assign channel and participant index to files list

for s=1:length(listTFData)
    
    file=listTFData(s).name;
    
    B = regexp(file,'\d*','Match');
    listTFData(s).channel = str2num(B{1, 1});
    listTFData(s).participant = str2num(B{1, 2});
end



idx_selected_channels = any([listTFData.channel] == settings.selected_channels.')
new_list = listTFData(idx_selected_channels)
T = struct2table(new_list)
sortedT = sortrows(T, 'participant')
new_list = table2struct(sortedT)

%% calculate real and imaginary part of complex numbers to phase and magnitude of frequency
clear all_data participantID id idx current participant_event participant_event_clean temp* data* n s i 
all_data = []
n=1;
for s=s:length(new_list)
    participantID = new_list(s).participant; 
    if participantID ~= 41 & participantID~= 66 & participantID~= 103 & participantID~= 142 & participantID~= 145 & participantID~= 162
    %if participantID ~= 82 & participantID~= 128 & participantID~= 129 & participantID~= 161 
        channel = new_list(s).channel;
        id = listEEGData(participantID).name(1:5);
        for i = 1:length(events)
            if ~isempty(events{2, i}) & all(events{2, i}(1:5) == id)
                idx(i) = 1;
            else
                idx(i) = 0;
            end
        end
        current = events{:, logical(idx)};
        clear idx

        for i = 1:size(current, 1)



            if current.orientation(i) == -45
                current.stim(i) = 101;
            elseif current.orientation(i) == 45
                current.stim(i) = 107;
            elseif current.orientation(i) == 0
                current.stim(i) = 100;
            elseif current.orientation(i) == 90
                current.stim(i) = 106;
            end
            if current.orientationResponse_pressKey(i) == 0
                current.stim_resp_angles(i) = 0;
                current.stim_resp(i) = 100;
            elseif current.orientationResponse_pressKey(i) == 1
                current.stim_resp_angles(i) = -45;
                current.stim_resp(i) = 101;
            elseif current.orientationResponse_pressKey(i) == 6
                current.stim_resp_angles(i) = 90;
                current.stim_resp(i) = 106;
            elseif current.orientationResponse_pressKey(i) == 7
                current.stim_resp_angles(i) = 45;
                current.stim_resp(i) = 107;
            end
            if current.pasResponse_pressKey(i) == 0
                current.pas_resp(i) = 1;
            elseif current.pasResponse_pressKey(i) == 1
                current.pas_resp(i) = 2;
            elseif current.pasResponse_pressKey(i) == 6
                current.pas_resp(i) = 3;
            elseif current.pasResponse_pressKey(i) == 7
                current.pas_resp(i) = 4;
            end
            if current.stim_resp(i) == current.stim(i)
                current.accuracy(i) = 1;
            elseif current.stim_resp(i) ~= current.stim(i)
                current.accuracy(i) = 0;

            end


        end
        current = removevars(current, ["stim_resp_angles","frameRate","VarName35","response","finalOpacity","postOri","stimulation_dur","post_fixation","stepSize","intensity", ...
            "image_name","global_start_time","global_end_time","pressKey","pressRT","releaseRT","image_started","image_ended","name"]);

        participant_event_clean = current;

        temp = load([pathTFData new_list(s).name]);
        data = abs(temp.tfdata);


        data_raw(n, :,:,:) = abs(temp.tfdata).^2      ;                                              % convert to (uV^2/Hz)



        if s+1 > length(new_list) || participantID ~= new_list(s+1).participant
            data_temp = squeeze(mean(data_raw, 1));
            data_db(:,:,:) = 10 * log10(data_temp) ;



            data_db_mean = mean(squeeze(mean(data_db(settings.freqs_roi,settings.times_roi,:),1)),1);
            data_raw_mean = squeeze(mean(mean(squeeze(mean(data_raw(:, settings.freqs_roi,settings.times_roi,:),1)),1),2));
            y = mean(squeeze(mean(data_db(settings.freqs_roi,settings.times_roi,:),1)),1);
            y_standarized = (y - mean(y))/std(y);

            %	130 = LL0			140 = LR0
            %	131 = LL-45			141 = LR-45
            %	137 = LL45			147 = LR45
            %	136 = LL90			146 = LR90
            %
            %	120 = UL0			150 = UR0
            %	121	= UL-45			151 = UR-45
            %	127 = UL45			157 = UR45
            %	126	= UL90			156 = UR90
            for(i=1:size(participant_event_clean, 1))
                %             if ~(contains(class(participant_event_clean(1).type), 'int32')) & ~(contains(class(participant_event_clean(1).type), 'double'))
                %                 for p=1:size(participant_event_clean, 1)
                %                     participant_event_clean(p).type =  str2num(participant_event_clean(p).type);
                %                 end
                %             end
                participant_event_clean.alpha_zscore(i) = y_standarized(i);
                participant_event_clean.alpha_dB(i) = data_db_mean(i);
                participant_event_clean.avg_dB(i) = mean(data_db_mean);
                participant_event_clean.ID_data(i) = {id};
                %participant_event_clean(i).participant(i) = participantID;
                if strcmp(class(participant_event_clean.ID), 'categorical')
                    participant_event_clean.ID2(i) = (string(participant_event_clean.ID(i)));
                    participant_event_clean.ID3(i) = str2num(participant_event_clean(i,:).ID2{1}(1:5));
                    %participant_event_clean.ID(i) = participant_event_clean.ID(i)
                end
            end
            if strcmp(class(participant_event_clean.ID), 'categorical')
                participant_event_clean = removevars(participant_event_clean, "ID");
                participant_event_clean = removevars(participant_event_clean, "ID2");
                participant_event_clean.Properties.VariableNames(29) = "ID";
            end

            all_data = cat(1, all_data, participant_event_clean);
            n=1;
            clear temp* data*  y* participant_event*
        else
            n=n+1;

        end
        display(['Currently we are at: ' num2str(s)])
    end
end

%
% alpha_mean = mean([all.alpha_dB])
% for i =1:length(all)
%
%     if alpha_mean > all(i).avg_dB
%         all(i).group = 1
%     else
%         all(i).group = 0
%     end
%
% end
%
%
% for i =1:length(all)
%     curr_participant = all(i).participant;
%     epochs = length(events{1, curr_participant}  );
%
%     if all(i).epoch / epochs <= 0.25
%         all(i).quartile = 1;
%     elseif all(i).epoch / epochs > 0.25 & all(i).epoch / epochs <= 0.5
%         all(i).quartile = 2;
%     elseif all(i).epoch / epochs > 0.5 & all(i).epoch / epochs <= 0.75
%         all(i).quartile = 3;
%     elseif all(i).epoch / epochs > 0.75
%         all(i).quartile = 4;
%     end
%
%
% end


writetable((all_data), [pathTFData '\behawior_alpha.csv'])
if settings.paradigm == 1
    writetable((all_data), ['D:\export\exp1_threshold_behawior_alpha.csv'])
elseif settings.paradigm == 2
    writetable((all_data), ['D:\export\exp2_cue_behawior_alpha.csv'])
elseif settings.paradigm == 3
    writetable((all_data), ['D:\export\exp3_mask_behawior_alpha_new.csv'])
elseif settings.paradigm == 4
    writetable((all_data), ['D:\export\exp4_faces_behawior_alpha.csv'])
end
save([pathTFData '\behawior_alpha.mat'],'all_data')

