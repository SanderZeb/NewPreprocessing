% general settings
settings.paradigm = 3; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes
settings.inverted = 1; % 1 for regression equation with X as magnitude and Y as responses; 0 for reg. eq. with X as responses and Y as magnitude
settings.intercept = 1; % 1 for equation with intercept included; 0 for equation without intercept & interactions

settings.prefix = 'conservative_'; % additional prefix for naming plots



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
if settings.inverted== 1 & settings.intercept== 1
    pathBETAS = [root '\tfdata\betas_odwrotne_intercept\']
    mkdir(pathBETAS, '\export_odwrotne_intercept\');
    savepath = [pathBETAS '\export_odwrotne_intercept\']
elseif settings.inverted== 1 & settings.intercept== 0
    pathBETAS = [root '\tfdata\betas_odwrotne\']
    mkdir(pathBETAS, '\export_odwrotne\');
    savepath = [pathBETAS '\export_odwrotne\']
elseif settings.inverted == 0 & settings.intercept== 1
    pathBETAS = [root '\tfdata\betas_intercept\']
    mkdir(pathBETAS, '\export_intercept\');
    savepath = [pathBETAS '\export_intercept\']
elseif settings.inverted== 0 & settings.intercept== 0
    pathBETAS = [root '\tfdata\betas\']
    mkdir(pathBETAS, '\export\');
    savepath = [pathBETAS '\export\']
end
pathTFData = [root '\tfdata\']
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'

eeglab nogui

listBetas=dir([pathBETAS '*.mat'  ]);
listEEGData=dir([pathEEGData '*.set'  ]);
listTFData=dir([pathTFData '*.mat'  ]);
participants = length(listEEGData);



EEG = pop_loadset('filename',listEEGData(1).name,'filepath',pathEEGData);
chanlocs = EEG.chanlocs;
[~,~,~,times,freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
clear EEG ALLCOM ALLEEG LASTCOM CURRENTSET CURRENTSTUDY STUDY PLUGINLIST currentFile channel B C participantID s
close all

settings.times_roi = times >= -650 & times <= -50;
settings.freqs_roi = freqs>= 8 & freqs <= 14;

channels.CP1 = find(strcmp({chanlocs.labels}, 'CP1')==1);
channels.CPz = find(strcmp({chanlocs.labels}, 'CPz')==1);
channels.CP2 = find(strcmp({chanlocs.labels}, 'CP2')==1);
channels.P1 = find(strcmp({chanlocs.labels}, 'P1')==1);
channels.P3 = find(strcmp({chanlocs.labels}, 'P3')==1);
channels.P5 = find(strcmp({chanlocs.labels}, 'P5')==1);
channels.P7 = find(strcmp({chanlocs.labels}, 'P7')==1);
channels.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1);
channels.P2 = find(strcmp({chanlocs.labels}, 'P2')==1);
channels.P4 = find(strcmp({chanlocs.labels}, 'P4')==1);
channels.P6 = find(strcmp({chanlocs.labels}, 'P6')==1);
channels.P8 = find(strcmp({chanlocs.labels}, 'P8')==1);
channels.O1 = find(strcmp({chanlocs.labels}, 'O1')==1);
channels.Oz = find(strcmp({chanlocs.labels}, 'Oz')==1);
channels.O2 = find(strcmp({chanlocs.labels}, 'O2')==1);
channels.PO7 = find(strcmp({chanlocs.labels}, 'PO7')==1);
channels.PO8 = find(strcmp({chanlocs.labels}, 'PO8')==1);
channels.PO3 = find(strcmp({chanlocs.labels}, 'PO3')==1);
channels.PO4 = find(strcmp({chanlocs.labels}, 'PO4')==1);
channels.POz = find(strcmp({chanlocs.labels}, 'POz')==1);
channels.Iz = find(strcmp({chanlocs.labels}, 'Iz')==1);


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
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY

for s=1:length(listTFData)
    
    file=listTFData(s).name;
    
    B = regexp(file,'\d*','Match');
    listTFData(s).channel = str2num(B{1, 1})
    listTFData(s).participant = str2num(B{1, 2})
end


for s=1:length(listBetas)
    
    file=listBetas(s).name;
    if  ~strcmp(file, 'betas.mat')
        B = regexp(file,'\d*','Match');
        if length(B) == 2
            participantID = str2num(B{1, 1});
            channel =  str2num(B{1, 2});
        elseif length(B) == 3
            participantID = str2num(B{1, 1});
            channel =  str2num(B{1, 3});
        end
        
        listBetas(s).participant = participantID;
        listBetas(s).channel = channel;
        
        C = regexp(file,'s_\w*_chann','Match');
        currentFile = C{1,1}(3:end-6);
        
        
        
        listBetas(s).(currentFile) = 1;
    end
end


fnames = fieldnames(listBetas)
fnames(1:8) = []
idx_channels = any([listBetas.channel] == [settings.selected_channels.'])
listBetas2 = listBetas(idx_channels)


for i = 1:length(fnames)
    %idx = ([listBetas2.(fnames{i, 1})] == 1);
    for n = 1 :length(listBetas2)
        if ~isempty(listBetas2(n).(fnames{i,1}))
            idx(n) = 1;
        else
            idx(n) = 0;
        end
    end
    idx = logical(idx);
    new_list = listBetas2(idx);
    T = struct2table(new_list);
    sortedT.(fnames{i, 1}) = sortrows(T, 'participant');
    all_lists.(fnames{i, 1}).new_list = table2struct(sortedT.(fnames{i, 1}));
   
    clear idx new_list
    
end


all = []
i=1;
s=1
for s=1:length(all_lists.(fnames{i, 1}).new_list)
    participantID = all_lists.(fnames{i, 1}).new_list(s).participant;
    channel = all_lists.(fnames{i, 1}).new_list(s).channel;
    name = listEEGData(participantID).name;
    
    for i = 1:length(fnames)
        field_name = ['beta_' fnames{i,1}];
        
        temp = load([pathBETAS all_lists.(fnames{i, 1}).new_list(s).name]);
        data_temp = temp.(field_name)(settings.freqs_roi, settings.times_roi);
        data = mean(mean(data_temp, 1));
        
        dataset.(fnames{i, 1}) = data;
    end
    dataset.participantID = name;
    dataset.channel = channel;
    
    all = cat(2, all, dataset);
    clear temp data data_raw data_db data_db_mean_data_raw_mean y y_standarized dataset
    display(['Currently we are at: ' num2str(s)]);
end


writetable(struct2table(all), [savepath '\betas.csv'])
save([savepath '\betas.mat'],'all')
