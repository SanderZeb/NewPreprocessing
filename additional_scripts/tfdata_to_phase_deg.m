settings.paradigm = 1;
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
mkdir(pathTFData, 'phase');
pathBETAS = [pathTFData '\phase\'];
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
load('D:\Drive\1 - Threshold\events_new3.mat')
participants_to_drop = [19933 32180 39332 41820 50935 81615 16942 19520 20998 72974 22154];

for s=1:length(listTFData)
    if contains(listTFData(s).name, 'tfdata_chan_') == 1
        file=listTFData(s).name;
        B = regexp(file,'\d*','Match');
        listTFData(s).channel = str2num(B{1, 1});
        listTFData(s).participant = str2num(B{1, 2});
        if any([events_new{listTFData(s).participant, 2}] == [participants_to_drop])    
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
    temp = load([pathTFData listTFData(s).name]);
    data_timef = abs(temp.tfdata);
    data_phase = angle(temp.tfdata);
    phase_deg = data_phase * (180/pi);
    phase = zeros(length(settings.freqs), length(settings.times), size(phase_deg,3));
    
    tStart = tic;
    for (k=1:length(settings.freqs))
        for(j=1:length(settings.times))
            for (t=1:size(phase_deg,3))
                if phase_deg(k,j,t) >= 0 
                    phase(k, j, t) = phase_deg(k,j,t);
                elseif phase_deg(k,j,t) <0
                    phase(k,j,t) = 360 - abs(phase_deg(k,j,t));
                end
            end
        end
    end
    participant_event = events_new{participantID, 1};
    acc = [participant_event.identification2];
    pas = [participant_event.pas];
    phase_acc1 = phase(:,:, [acc] == 1);
    phase_acc0 = phase(:,:, [acc] == 0);
    if sum([pas]==1) > 10
        phase_pas1 = phase(:,:, [pas] == 1);
    end
    if sum([pas]==2) > 10
        phase_pas2 = phase(:,:, [pas] == 2);
    end
    if sum([pas]==3) > 10
        phase_pas3 = phase(:,:, [pas] == 3);
    end
    if sum([pas]==4) > 10
        phase_pas4 = phase(:,:, [pas] == 4);
    end

    [circ_mean,range,X,Y,cos_a,sin_a] = circle_mean(phase_pas1);

    tEnd = toc(tStart);
    tTotal = tTotal+tEnd;
    estimated_time = tEnd*(length(listTFData) - s);
    display(['procesuję: ' num2str(s) ' z ' num2str(length(listTFData)) '. Trwało: ' num2str(tEnd) 's.']);
    display(['Szacowany czas: ' num2str(estimated_time/60) 'min. Mineło: ' num2str(tTotal/60) 'min.' ]);
    save([pathBETAS num2str(participantID) '_phase_degrees_' num2str(channel)], 'phase');
    clear betas acc pas x_input data_timef participant_event
end