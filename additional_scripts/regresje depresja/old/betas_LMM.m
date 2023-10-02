settings.paradigm = 1;
settings.confirmatory = 0;
%settings.formula = 'alfa~acc*pas+(1+acc+pas|epoch)+(1|pas)'; % Alpha power ~ accuracy * PAS + (1 + accuracy + PAS | ID) + (1 | PAS)
%settings.formula = 'alfa~acc*pas+(1|pas)+(1|acc)+(1|acc:pas)';  % due to
%very long computational time, i had to make it shorter:
settings.formula = 'alfa~acc*pas+(1|acc:pas)';
%settings.formula = 'alfa~acc*pas';
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
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
if settings.confirmatory == 0
    pathTFData = [root '\tfdata\']
elseif settings.confirmatory == 1
    pathTFData = [root '\tfdata_confirmatory\']
end
pathEEGData = [root '\MARA\']
mkdir(pathTFData, 'betas_lmm');
pathBETAS = [pathTFData '\betas_lmm\'];
%eeglab nogui
listTFData=dir([pathTFData '*.mat'  ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData);
load('D:\Drive\1 - Threshold\events_new3.mat')
fileEEGData=listEEGData(1).name;
EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
[~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
chanlocs = EEG.chanlocs;
close all
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY fileEEGData temp data_timef y* x* beta* EEG B file s

participants_to_drop = [19933 32180 39332 41820 50935 81615 16942 19520 20998 72974 22154]; %added 22154 - events missmatched tfdata?
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
settings.selected_channels = [channels.O1 channels.Oz channels.O2 channels.PO7 channels.PO3 channels.POz channels.PO4 channels.PO8 channels.Iz channels.P7 channels.P5 channels.P3 channels.P1 channels.Pz channels.P2 channels.P4 channels.P6 channels.P8];

for s=1:length(listTFData)
    if contains(listTFData(s).name, 'tfdata_chan_') == 1
        file=listTFData(s).name;
        B = regexp(file,'\d*','Match');
        listTFData(s).channel = str2num(B{1, 1});
        listTFData(s).participant = str2num(B{1, 2});
        if any([settings.selected_channels] == listTFData(s).channel) & any([events_new{listTFData(s).participant, 2}] ~= [participants_to_drop])    
            idx(s) = 0;
        else
            idx(s) = 1;
        end
    else
        idx(s) = 1;
    end
end
listTFData([idx]==1) = [];
clear idx

tTotal = 0;
for s=1:length(listTFData)
    clear participantID channel participant_event temp data_timef acc pas epoch y y_standarized data data_table* lme coefficients
    addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
    participantID = listTFData(s).participant;
    channel = listTFData(s).channel;
    participant_event = events_new{participantID, 1};
    temp = load([pathTFData listTFData(s).name]);
    data_timef = abs(temp.tfdata);

    %x_data = [[participant_event.accuracy].' [participant_event.pas_resp].'];
    x_data = [[participant_event.identification2].' [participant_event.pas].'];
    x_table = array2table(x_data, "VariableNames",{'acc', 'pas'});
    x_table.acc = categorical(x_table.acc);
    x_table.pas = categorical(x_table.pas);
    tStart = tic;
    coefficients = zeros(length(settings.freqs), length(settings.times), 8);
    randomEff = zeros(length(settings.freqs), length(settings.times), 6);
    for (k=1:length(settings.times))
        for(j=1:length(settings.freqs))
            clear y* ;
            y = zscore(squeeze(data_timef(j,k,:)));
            y_table = array2table(y, "VariableNames",{'alfa'});
            data_table = [y_table x_table];
                
            coefficients(j,k,:) = fixedEffects(lme);
            %randomEff(j,k,:) = randomEffects(lme);
            clear lme data data_table y y_table lme 
        end
    end
    tEnd = toc(tStart);
    tTotal = tTotal+tEnd;
    estimated_time = tEnd*(length(listTFData) - s);
    display(['procesuję: ' num2str(s) ' z ' num2str(length(listTFData)) '. Trwało: ' num2str(tEnd) 's.']);
    display(['Szacowany czas: ' num2str((estimated_time/60)/60) 'godz. Mineło: ' num2str(tTotal/60) 'min. (' num2str((tTotal/60)/60) 'godz)' ]);
    
    save([pathBETAS num2str(participantID) '_betas_chann_' num2str(channel)], 'coefficients');
    save([pathBETAS num2str(participantID) '_randomEffects_chann_' num2str(channel)], 'randomEff');
    clear randomEff coefficients tEnd
end