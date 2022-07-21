close all
clear all
settings.paradigm = 6; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes; 6 - Kinga


addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')



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
elseif settings.paradigm == 6
    root='D:\Drive\6 - Kinga\';
end


pathLoadData_MARA=[root '\MARA\additional_info\'];
pathLoadData_chans=[root '\Preprocessed_new_pipeline\additional_info'];
pathLoadData_trials=[root '\Epoching_EpochRejection\additional_info'];
list_MARA=dir([pathLoadData_MARA '\MARA_components*.mat'  ]);
list_chans=dir([pathLoadData_chans '\removed_channels*.mat'  ]);
list_trials=dir([pathLoadData_trials '\removed_trials*.mat'  ]);
savePath = [pathLoadData_MARA, '\'];
participants_MARA = length(list_MARA);
participants_chans = length(list_chans);
participants_trials = length(list_trials);

for i = 1:(participants_chans)
   if i <= (participants_MARA) 
    list_MARA_files(i) = str2num(list_MARA(i).name(16:20))
   end
   list_chans_files(i) = str2num(list_chans(i).name(17:21))
   list_trials_files(i) = str2num(list_trials(i).name(15:19))
end





for i=1:(participants_chans)
        
        participant = list_trials_files(i)
        MARA_idx = find(list_MARA_files == participant)
        
        data(i).participant = list_chans_files(i)
        temp_chan = load([pathLoadData_chans '\' list_chans(i).name]);
        data(i).removed_channels = sum(temp_chan.removed_channels);
        
        temp_trials = load([pathLoadData_trials '\' list_trials(i).name]);
        data(i).removed_trials = numel(temp_trials.to_reject);
        try
        temp_MARA = load([pathLoadData_MARA '\' list_MARA(MARA_idx).name]);
        data(i).rejected_components = numel(temp_MARA.artcomps);
        catch end;
        clear temp*
    
end

summary.mean_channels = mean([data.removed_channels])
summary.std_channels = std([data.removed_channels])
summary.mean_trials = mean([data.removed_trials])
summary.std_trials = std([data.removed_trials])
summary.mean_components = mean([data.rejected_components])
summary.std_components = std([data.rejected_components])

% external plugin required for an export to html --> https://www.mathworks.com/matlabcentral/fileexchange/25078-html-table-writer
% can be found in /helpers/

colheads_data = fieldnames(data)'
colheads_summary = fieldnames(summary)'

all_data = squeeze(struct2cell(data))'
all_data2 = [colheads_data; all_data]

summary_data = squeeze(struct2cell(summary))'
summary_data2 = [colheads_summary; summary_data]
html_table(all_data2, [savePath 'all_data.html'])
html_table(summary_data2, [savePath 'summary_data.html'])
