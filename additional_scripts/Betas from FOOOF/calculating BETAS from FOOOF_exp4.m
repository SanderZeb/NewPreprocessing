settings.paradigm = 4;

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

load('D:\Drive\4 - Faces\events_new3.mat')
events_new = events_new3;

participants_to_drop = [61 62 63 82]  %[34375 50935 68100 84136 85124 93496 94182]; % exp3

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
    %if any(s == [211:234])
        clear participantID channel participant_event temp data_timef acc pas epoch y y_standarized data data_table* lme coefficients
        participantID = listTFData(s).participant;

        participant_event = events_new{participantID};
        temp = load([pathTFData listTFData(s).name]);
        data_timef = (temp.data);
        acc = [participant_event.accuracy].';
        %acc([acc] == 0) = 0;
        pas = [participant_event.pas_resp].';
        x_input = [zscore(acc) zscore(pas) zscore(acc).*zscore(pas)];
        tStart = tic;
        for (k=1:length(settings.times))
            for(j=1:length(settings.freqs))
                clear y* ;
                y = zscore(squeeze(data_timef(j,k,:)));
                betas(j,k,:) = mvregress(y, x_input);
            end
        end
        tEnd = toc(tStart);
        tTotal = tTotal+tEnd;
        estimated_time = tEnd*(length(listTFData) - s);
        display(['procesuję: ' num2str(s) ' z ' num2str(length(listTFData)) '. Trwało: ' num2str(tEnd) 's.']);
        display(['Szacowany czas: ' num2str(estimated_time/60) 'min. Mineło: ' num2str(tTotal/60) 'min.' ]);
        if listTFData(s).aperiodic == 1
            save([pathBETAS '\aperiodic\' num2str(participantID) '_betas'], 'betas');
        else
            save([pathBETAS '\periodic\' num2str(participantID) '_betas'], 'betas');
        end

        clear betas acc pas x_input data_timef participant_event
    %else
    %    continue
    %end
end