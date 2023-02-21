clear all
settings.paradigm = 3;
if settings.paradigm == 1
    root = 'D:\Drive\1 - Threshold\';
    dropout = [5 6 18 106];
elseif settings.paradigm == 2
    root = 'D:\Drive\2 - Cue\';
elseif settings.paradigm == 3
    root = 'D:\Drive\3 - Mask\';
    dropout = [10 82 99];
elseif settings.paradigm == 4
    root = 'D:\Drive\4 - Faces\';
    dropout = [5 30 36 78 83];
elseif settings.paradigm == 5
    root = 'D:\Drive\5 - Scenes\';
    dropout = [56 74 91];
end
pathEEGData = [root '\MARA\'];
listEEGData=dir([pathEEGData '*.set'  ]);
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
eeglab nogui
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY

load([root 'events.mat']);
for i=1:length(events)
    events{2, i} = listEEGData(i).name(1:5);
end
load([root 'events_new.mat']);

idx_ev_new = zeros(size(events_new, 2), 1);
idx_ev_old = zeros(size(events, 2), 1);
for i = 1:size(events_new, 2)
    if ~isempty(events_new{2, i})
    idx_ev_new(i, :) = str2num(events_new{2, i});
    end
end
for i = 1:size(events, 2)

    idx_ev_old(i,:) = str2num(events{2, i});

end