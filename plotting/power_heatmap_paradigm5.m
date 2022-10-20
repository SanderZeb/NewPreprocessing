% general settings
settings.paradigm = 5; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes
settings.task_type = 1 % 1 - object; 0 - background
% topoplot cluster permutation test settings
settings.n_perm = 10000;
settings.fwer = .01;
settings.tail = 0;
settings.oldway = 0; % 0 for 4 topoplots [-800 -600; -600 -400; -400 -200; -200 0]; 1 for multiple topoplots with averaged timewindow (specified by settings.step)

% cluster permutation test settings
settings.perm = 10000;
settings.p_val = 0.01;

% general plotting settings
settings.limits.up = 0.06;
settings.limits.down = -0.06;
settings.prefix = 'more_liberal_'; % additional prefix for naming plots


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

    mkdir(pathTFData, 'plots');
    savepath = [pathTFData '\plots\']

addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'

eeglab nogui

listTFData=dir([pathTFData '*mat' ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData);




try
    
    load([root 'events.mat']);
        fileEEGData=listEEGData(1).name;
        EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
    
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



[~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
clear temp data y* x* beta* EEG B file s
close all


try
    if settings.task_type == 1
    load([savepath 'tfdata_object_before_avg_highpas.mat']);
    load([savepath 'tfdata_object_before_avg_lowpas.mat']);
    load([savepath 'tfdata_object_before_avg_corr.mat']);
    load([savepath 'tfdata_object_before_avg_inc.mat']);
    elseif settings.task_type == 0
    load([savepath 'tfdata_background_before_avg_highpas.mat']);
    load([savepath 'tfdata_background_before_avg_lowpas.mat']);
    load([savepath 'tfdata_background_before_avg_corr.mat']);
    load([savepath 'tfdata_background_before_avg_inc.mat']);
    end
    
catch
    
    for s=1:length(listTFData)
        participantID = listTFData(s).participant;
        if participantID ~= 34
        channel = listTFData(s).channel;
        participant_event = events{participantID};

        
        
        participant_event = rmfield(participant_event, 'stimulus')
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
        else
            id_to_drop = [];
        end
        
        participant_event([id_to_drop]) = [];
        
        
        temp = load([pathTFData listTFData(s).name]);
        temp2 = temp.tfdata(:,:, [participant_event.epoch]);
        data = abs(temp2);
        data = data(:,:,:);
        
            for i=1:length(participant_event)
                    idx_object(i) = strcmp(participant_event(i).task_type, 'object');
                    idx_background(i) = strcmp(participant_event(i).task_type, 'background');
            end
        
        idx_ttobject_highpas = [participant_event.pas] >= 3 & idx_object;
        idx_ttobject_lowpas = [participant_event.pas] < 3 & idx_object;
        idx_ttobject_corr = [participant_event.corrected_id] == 1 & idx_object;
        idx_ttobject_inc = [participant_event.corrected_id] == 0 & idx_object;
        
        idx_ttbackground_highpas = [participant_event.pas] >= 3 & idx_background;
        idx_ttbackground_lowpas = [participant_event.pas] < 3 & idx_background;
        idx_ttbackground_corr = [participant_event.corrected_id] == 1 & idx_background;
        idx_ttbackground_inc  = [participant_event.corrected_id] == 0 & idx_background;
        
        data_all_lowpas_object(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_ttobject_lowpas), 3));
        data_all_highpas_object(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_ttobject_highpas), 3));
        data_all_corr_id_object(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_ttobject_corr), 3));
        data_all_inc_id_object(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_ttobject_inc), 3));
        
        data_all_lowpas_background(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_ttbackground_lowpas), 3));
        data_all_highpas_background(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_ttbackground_highpas), 3));
        data_all_corr_id_background(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_ttbackground_corr), 3));
        data_all_inc_id_background(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_ttbackground_inc), 3));
        
        
        
        display(['currently processing: ' num2str(s) ' of ' num2str(length(listTFData)) ]);
        clear idx* data temp*
        end
    end
    save([savepath 'data_all_lowpas_object.mat'], 'data_all_lowpas_object');
    save([savepath 'data_all_highpas_object.mat'], 'data_all_highpas_object');
    save([savepath 'data_all_corr_id_object.mat'], 'data_all_corr_id_object');
    save([savepath 'data_all_inc_id_object.mat'], 'data_all_inc_id_object');
    
    
    save([savepath 'data_all_lowpas_background.mat'], 'data_all_lowpas_background');
    save([savepath 'data_all_highpas_background.mat'], 'data_all_highpas_background');
    save([savepath 'data_all_corr_id_background.mat'], 'data_all_corr_id_background');
    save([savepath 'data_all_inc_id_background.mat'], 'data_all_inc_id_background');
    
    
end

%% TEST Z BASELINEM
  clear data_all*
    load([savepath 'data_all_lowpas_object.mat']);
    load([savepath 'data_all_highpas_object.mat']);
    load([savepath 'data_all_corr_id_object.mat']);
    load([savepath 'data_all_inc_id_object.mat']);
    
    load([savepath 'data_all_lowpas_background.mat']);
    load([savepath 'data_all_highpas_background.mat']);
    load([savepath 'data_all_corr_id_background.mat']);
    load([savepath 'data_all_inc_id_background.mat']);
    
for i = 1:size(data_all_corr_id_background, 1)
for n = 1:size(data_all_corr_id_background, 2)
for m = 1:size(data_all_corr_id_background, 3)
   baseline(i, n, m) = mean(data_all_lowpas_background(i,n,m, 1:10), 'omitnan');
   data_all_lowpas_background(i,n,m, :) = data_all_lowpas_background (i,n,m, :) - baseline(i, n, m);
   
   
   
   baseline(i, n, m) = mean(data_all_highpas_background(i,n,m, 1:10), 'omitnan');
   data_all_highpas_background(i,n,m, :) = data_all_highpas_background (i,n,m, :) - baseline(i, n, m);
   
   
   
   baseline(i, n, m) = mean(data_all_corr_id_background(i,n,m, 1:10), 'omitnan');
   data_all_corr_id_background(i,n,m, :) = data_all_corr_id_background (i,n,m, :) - baseline(i, n, m);
   
   
   
   baseline(i, n, m) = mean(data_all_inc_id_background(i,n,m, 1:10), 'omitnan');
   data_all_inc_id_background(i,n,m, :) = data_all_inc_id_background (i,n,m, :) - baseline(i, n, m);
end
end
end

    
for i = 1:size(data_all_corr_id_background, 1)
for n = 1:size(data_all_corr_id_background, 2)
for m = 1:size(data_all_corr_id_background, 3)
   baseline(i, n, m) = mean(data_all_lowpas_object(i,n,m, 1:10), 'omitnan');
   data_all_lowpas_object(i,n,m, :) = data_all_lowpas_object (i,n,m, :) - baseline(i, n, m);
   
   
   
   baseline(i, n, m) = mean(data_all_highpas_object(i,n,m, 1:10), 'omitnan');
   data_all_highpas_object(i,n,m, :) = data_all_highpas_object (i,n,m, :) - baseline(i, n, m);
   
   
   
   baseline(i, n, m) = mean(data_all_corr_id_object(i,n,m, 1:10), 'omitnan');
   data_all_corr_id_object(i,n,m, :) = data_all_corr_id_object (i,n,m, :) - baseline(i, n, m);
   
   
   
   baseline(i, n, m) = mean(data_all_inc_id_object(i,n,m, 1:10), 'omitnan');
   data_all_inc_id_object(i,n,m, :) = data_all_inc_id_object (i,n,m, :) - baseline(i, n, m);
end
end
end

heatmap(squeeze(mean(mean(data_baselined, 1, 'omitnan'), 2, 'omitnan'))); colormap jet



%% 

mean_all_corr_id_obj = squeeze(mean(data_all_corr_id_object, 1, 'omitnan'));
mean_all_inc_id_obj = squeeze(mean(data_all_inc_id_object, 1, 'omitnan'));
mean_all_highpas_obj = squeeze(mean(data_all_highpas_object, 1, 'omitnan'));
mean_all_lowpas_obj = squeeze(mean(data_all_lowpas_object, 1, 'omitnan'));

mean_all_corr_id_bg = squeeze(mean(data_all_corr_id_background, 1, 'omitnan'));
mean_all_inc_id_bg = squeeze(mean(data_all_inc_id_background, 1, 'omitnan'));
mean_all_highpas_bg = squeeze(mean(data_all_highpas_background, 1, 'omitnan'));
mean_all_lowpas_bg = squeeze(mean(data_all_lowpas_background, 1, 'omitnan'));





fileEEGData=listEEGData(1).name;
EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
chanlocs = EEG.chanlocs;
   channels(1).M1 = find(strcmp({chanlocs.labels}, 'M1')==1);               %INDEX CHANNEL
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
	channels.Iz = find(strcmp({chanlocs.labels}, 'Iz')==1);								
	channels.VEOG = find(strcmp({chanlocs.labels}, 'VEOG')==1);				 %INDEX CHANNEL
	channels.HEOG = find(strcmp({chanlocs.labels}, 'HEOG')==1);				 %INDEX CHANNEL
																													
        																												
settings.selected_channels = [channels.O1 channels.Oz channels.O2 channels.PO7 channels.PO8 channels.PO3 channels.PO4 channels.POz channels.Iz channels.P1 channels.Pz channels.P2];
		

selected_chann_corr_id_obj = squeeze(mean(mean_all_corr_id_obj(settings.selected_channels, :,:), 1));
selected_chann_inc_id_obj =squeeze(mean(mean_all_inc_id_obj(settings.selected_channels, :,:), 1));
selected_chann_highpas_obj =squeeze(mean(mean_all_highpas_obj(settings.selected_channels, :,:), 1, 'omitnan'));
selected_chann_lowpas_obj =squeeze(mean(mean_all_lowpas_obj(settings.selected_channels, :,:), 1));


selected_chann_corr_id_bg  = squeeze(mean(mean_all_corr_id_bg (settings.selected_channels, :,:), 1));
selected_chann_inc_id_bg  =squeeze(mean(mean_all_inc_id_bg (settings.selected_channels, :,:), 1));
selected_chann_highpas_bg  =squeeze(mean(mean_all_highpas_bg (settings.selected_channels, :,:), 1, 'omitnan'));
selected_chann_lowpas_bg  =squeeze(mean(mean_all_lowpas_bg (settings.selected_channels, :,:), 1));




ss=get(0, 'ScreenSize');
m = length(settings.freqs);
n = size(settings.times, 2);

frekwencje = string(int64(settings.freqs));

try
    
    load('C:\Users\user\Desktop\edited czasy decimal.mat'); % manually edited version of ([round(settings.times_roi,-1)])
catch
    czasy = ([round(settings.times_roi,-1)]);
end


for i = 1:length(czasy)
    if mod(czasy(i), 200) == 0 % selecting labels for X axis - every 200 ms;
        czasy2(i) = czasy(i);
    else
        czasy2(i) = 0;
    end
end
czasy3 = string(czasy2);
czasy3(czasy2==0) = " ";
czasy = czasy3;
czasy(100) = "0";

every_3d_element = [1:length(settings.freqs)];
every_3d_element(mod(every_3d_element,3) == 0) = 0;
frekwencje(every_3d_element~=0) = " ";
clear every_3d_element

% to_plot.raw_highpas = (10 * log10(selected_chann_highpas))
% to_plot.raw_lowpas = (10 * log10(selected_chann_lowpas))
% to_plot.raw_correct = (10 * log10(selected_chann_corr_id))
% to_plot.raw_incorrect =  (10 * log10(selected_chann_inc_id))
% 
% 
% to_plot.difference_objective = [(10 * log10(selected_chann_corr_id))      -      (10 * log10(selected_chann_inc_id))];
% to_plot.difference_subjective = [(10 * log10(selected_chann_highpas))      -      (10 * log10(selected_chann_lowpas))];
% if settings.paradigm == 4
% to_plot.raw_fearfull =(10 * log10(selected_chann_fearfull))
% to_plot.raw_neutral = (10 * log10(selected_chann_neutral))
%     to_plot.additional = [(10 * log10(selected_chann_fearfull))      -      (10 * log10(selected_chann_neutral))];
% 
% end
to_plot.raw_highpas_obj = selected_chann_highpas_obj
to_plot.raw_lowpas_obj = selected_chann_lowpas_obj
to_plot.raw_correct_obj = selected_chann_corr_id_obj
to_plot.raw_incorrect_obj =  selected_chann_inc_id_obj

to_plot.raw_highpas_bg = selected_chann_highpas_bg
to_plot.raw_lowpas_bg = selected_chann_lowpas_bg
to_plot.raw_correct_bg = selected_chann_corr_id_bg
to_plot.raw_incorrect_bg =  selected_chann_inc_id_bg

to_plot.difference_objective_obj = [selected_chann_corr_id_obj     -        selected_chann_inc_id_obj];
to_plot.difference_subjective_obj = [selected_chann_highpas_obj      -      selected_chann_lowpas_obj];

to_plot.difference_objective_bg = [selected_chann_corr_id_bg     -        selected_chann_inc_id_bg];
to_plot.difference_subjective_bg = [selected_chann_highpas_bg      -      selected_chann_lowpas_bg];

fnames = fieldnames(to_plot);


%% new plot - using contour * imagesc
for i=1:length(fnames)
    clear temp* mean_data n m
    % preparing data to plot
    
    m = length(settings.freqs);
    n = size(settings.times, 2);
    temp_data = to_plot.(fnames{i,1});
    settings.prefix = 'baseline';
    %temp_data = to_plot.(fnames{i,1})(1:8, :);
    fig = figure('Position', [0 0 ss(3) ss(4)], 'Visible', 'off');
    %heatmap(temp_data, 'ColorLimits',[-1 1])
    if contains((fnames{i,1}), 'difference')
    heatmap(temp_data, 'ColorLimits',[-2 2])    
    else
    heatmap(temp_data, 'ColorLimits',[-8 6])
    end
    colormap('jet')
    grid off
    %xline(100.5)

    
    saveas(fig,[savepath settings.prefix fnames{i,1} '.png']);
    saveas(fig,[savepath settings.prefix fnames{i,1} '.fig']);
    close all
    
    clear temp_data 
    
    
    
end


% 
% 
% figure;
% heatmap(selected_chann_corr_id-selected_chann_inc_id, 'ColorLimits',[-1 1])
% colormap('jet')
% grid off
% 
% figure;
% heatmap(selected_chann_highpas-selected_chann_lowpas, 'ColorLimits',[-1 1])
% colormap('jet')
% grid off
% 
% figure;
% heatmap(selected_chann_fearfull-selected_chann_neutral, 'ColorLimits',[-1 1])
% colormap('jet')
% grid off
% 
% 
% 
% 
% 
% _________________________________________________________________________________________________________
% all_events=[]
% for i=1:length(events)
%    
%     
%     curr_events = events{i}
%     
%     all_events = cat(2, all_events, curr_events)
%     
% end
% 
% 
% for i=1:length(all_events)
% 
% if isempty(all_events(i).pas)
% idx_remove(i) = 0;
% else 
% idx_remove(i) = 1;
% end
% end
% 
% all_events = all_events(logical(idx_remove));
% 
% idx_highpas = [all_events.pas] <=2
% idx_lowpas = [all_events.pas] >= 3
% idx_corr = [all_events.identification2] == 1
% idx_incorr = [all_events.identification2] == 0
% idx_meutral = [all_events.stimulus] == 103
% idx_fearful = [all_events.stimulus] == 104
% 
% 
% 
% idx_highpascorr = idx_highpas & idx_corr
% idx_lowpascorr = idx_lowpas & idx_corr
% idx_highpasinc = idx_highpas & idx_incorr
% idx_lowpasinc = idx_lowpas & idx_incorr
% 
% idx_fe_highpas = idx_highpas & idx_fearful
% idx_fe_lowpas = idx_lowpas & idx_fearful
% idx_ne_highpas = idx_highpas & idx_meutral
% idx_ne_lowpas = idx_lowpas & idx_meutral
% 
% bar([sum(idx_fe_highpas) sum(idx_fe_lowpas) sum(idx_ne_highpas) sum(idx_ne_lowpas)])
% 
% bar([sum(idx_highpas) sum(idx_lowpas)])