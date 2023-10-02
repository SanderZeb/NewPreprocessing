settings.paradigm = 5;

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

pathTFData = [root '\tfdata\fooof2\']

pathEEGData = [root '\MARA\']
mkdir(pathTFData, 'betas_fooof');
pathBETAS = [pathTFData '\betas_fooof\'];

listTFData=dir([pathTFData '*.mat'  ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData);
fileEEGData=listEEGData(1).name;
EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
[~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
close all
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY fileEEGData temp data_timef y* x* beta* EEG B file s
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'

load('D:\Drive\5 - Scenes\events.mat')
events_new = events;
participants_to_drop = [33]
for s=1:length(listTFData)
    if contains(listTFData(s).name, 'fooof_') == 1
        file=listTFData(s).name;
        B = regexp(file,'\d*','Match');
        listTFData(s).participant = str2num(B{1, 1});
        if contains(listTFData(s).name, '_aperiodic') & ~contains(listTFData(s).name, '_periodic')
            listTFData(s).aperiodic = 1;
            listTFData(s).periodic = 0;
        elseif ~contains(listTFData(s).name, '_aperiodic') & contains(listTFData(s).name, '_periodic')
            listTFData(s).aperiodic = 0;
            listTFData(s).periodic = 1;
        end


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

mkdir(pathBETAS, 'aperiodic');
mkdir(pathBETAS, 'periodic');
tTotal = 0;
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats';
for s=1:length(listTFData)
    clear participantID channel participant_event temp data_timef acc pas epoch y y_standarized data data_table* lme coefficients
    participantID = listTFData(s).participant;

    participant_event_objects = events_new{participantID};
    idx_objects = ones(length(participant_event_objects), 1);
    idx_objects([strcmp({participant_event_objects.task_type}, 'object')]) = 0;
    temp = load([pathTFData listTFData(s).name]);
    data_timef_objects = abs(temp.data);
    data_timef_objects(:,:,[idx_objects]==1) = [];
    participant_event_objects(logical(idx_objects)) = [];
    acc_objects = [participant_event_objects.accuracy].';
    acc_objects([acc_objects] == 0) = -1;
    pas_objects = [participant_event_objects.pas].';
    %x_input = [ones(length(acc),1) zscore(acc) zscore(pas) zscore(acc).*zscore(pas)];
    x_input_objects = [ones(length(acc_objects),1) zscore(acc_objects) zscore(pas_objects) zscore(acc_objects).*zscore(pas_objects)];
    %%%%%%%%%%%

    participant_event_backgrounds = events_new{participantID};
    idx_backgrounds = ones(length(participant_event_backgrounds), 1);
    idx_backgrounds([strcmp({participant_event_backgrounds.task_type}, 'background')]) = 0;
    temp = load([pathTFData listTFData(s).name]);
    data_timef_backgrounds = abs(temp.data);
    data_timef_backgrounds(:,:,[idx_backgrounds]==1) = [];
    participant_event_backgrounds(logical(idx_backgrounds)) = [];
    acc_backgrounds = [participant_event_backgrounds.accuracy].';
    acc_backgrounds([acc_backgrounds] == 0) = -1;
    pas_backgrounds = [participant_event_backgrounds.pas].';
    %x_input = [ones(length(acc),1) zscore(acc) zscore(pas) zscore(acc).*zscore(pas)];
    x_input_backgrounds = [ones(length(acc_backgrounds),1) zscore(acc_backgrounds) zscore(pas_backgrounds) zscore(acc_backgrounds).*zscore(pas_backgrounds)];


    tStart = tic;
    for (k=1:length(settings.times))
        for(j=1:length(settings.freqs))
            clear y* ;
            y_objects = zscore(squeeze(data_timef_objects(j,k,:)));
            betas_objects(j,k,:) = mvregress(y_objects, x_input_objects);
              


            y_backgrounds = zscore(squeeze(data_timef_backgrounds(j,k,:)));
            betas_backgrounds(j,k,:) = mvregress(y_backgrounds, x_input_backgrounds);
        end
    end

    tEnd = toc(tStart);
    tTotal = tTotal+tEnd;
    estimated_time = tEnd*(length(listTFData) - s);
    display(['procesuję: ' num2str(s) ' z ' num2str(length(listTFData)) '. Trwało: ' num2str(tEnd) 's.']);
    display(['Szacowany czas: ' num2str(estimated_time/60) 'min. Mineło: ' num2str(tTotal/60) 'min.' ]);
    if listTFData(s).aperiodic == 1
        save([pathBETAS '\aperiodic\' num2str(participantID) '_betas_objects'], 'betas_objects');
        save([pathBETAS '\aperiodic\' num2str(participantID) '_betas_backgrounds'], 'betas_backgrounds');
    else
        save([pathBETAS '\periodic\' num2str(participantID) '_betas_objects'], 'betas_objects');
        save([pathBETAS '\periodic\' num2str(participantID) '_betas_backgrounds'], 'betas_backgrounds');
    end

    clear betas acc pas x_input data_timef participant_event

end