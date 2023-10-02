settings.paradigm = 3;
settings.confirmatory = 0;

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
mkdir(pathTFData, 'betas_interaction_regress2');
pathBETAS = [pathTFData '\betas_interaction_regress2\'];
%eeglab nogui
listTFData=dir([pathTFData '*.mat'  ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData);
fileEEGData=listEEGData(1).name;
EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
[~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
close all
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY fileEEGData temp data_timef y* x* beta* EEG B file s
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
%load('D:\Drive\1 - Threshold\events_new3.mat')
load('D:\Drive\3 - Mask\events_new2.mat')
events_new = events_new2;
%participants_to_drop = [19933 32180 39332 41820 50935 81615 16942 19520
%20998 72974 22154]; % exp1
participants_to_drop = [41 66 103 142 145 162]  %[34375 50935 68100 84136 85124 93496 94182]; % exp3
for s=1:length(listTFData)
    if contains(listTFData(s).name, 'tfdata_chan_') == 1
        file=listTFData(s).name;
        B = regexp(file,'\d*','Match');
        listTFData(s).channel = str2num(B{1, 1});
        listTFData(s).participant = str2num(B{1, 2});
        %if any([events_new{listTFData(s).participant, 2}] == [participants_to_drop])    
        if any(listTFData(s).participant == [participants_to_drop])   
            idx(s) = 1;
        else
            idx(s) = 0;
        end
        
    else
        idx(s) = 1;
    end
end
listTFData([idx]==1) = [];
clear idx

tTotal = 0;
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats';
for s=1:length(listTFData)
    clear participantID channel participant_event temp data_timef acc pas epoch y y_standarized data data_table* lme coefficients
    participantID = listTFData(s).participant;
    channel = listTFData(s).channel;
    participant_event = events_new{participantID};
    temp = load([pathTFData listTFData(s).name]);
    data_timef = abs(temp.tfdata);
    acc = [participant_event.accuracy].';
    acc([acc] == 0) = -1;
    pas = [participant_event.pas_resp].';
    %x_input = [ones(length(acc),1) zscore(acc) zscore(pas) zscore(acc).*zscore(pas)];
    x_input = [ones(length(acc),1) (acc) (pas) (acc).*(pas)];

    tStart = tic;
    for (k=1:length(settings.times))
        for(j=1:length(settings.freqs))
            clear y* ;
            y = zscore(squeeze(data_timef(j,k,:)));
            betas(j,k,:) = regress(y, x_input);
                    
        end
    end
    tEnd = toc(tStart);
    tTotal = tTotal+tEnd;
    estimated_time = tEnd*(length(listTFData) - s);
    display(['procesuję: ' num2str(s) ' z ' num2str(length(listTFData)) '. Trwało: ' num2str(tEnd) 's.']);
    display(['Szacowany czas: ' num2str(estimated_time/60) 'min. Mineło: ' num2str(tTotal/60) 'min.' ]);
    save([pathBETAS num2str(participantID) '_betas_chann_' num2str(channel)], 'betas');
    clear betas acc pas x_input data_timef participant_event
end