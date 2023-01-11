for paradigm = 2:3

    if paradigm == 1
        settings.paradigm = 1; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes
    elseif paradigm == 2
        settings.paradigm = 3; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes
    elseif paradigm == 3
        settings.paradigm = 4; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes
    end


    settings.baseline = [1:10];

    settings.oldway = 0; % 0 for 4 topoplots [-800 -600; -600 -400; -400 -200; -200 0]; 1 for multiple topoplots with averaged timewindow (specified by settings.step)


    settings.log10 = 0;

    % general plotting settings
    settings.limits.up = 0.06;
    settings.limits.down = -0.06;
    settings.prefix = 'phase_'; % additional prefix for naming plots


    if settings.paradigm == 1
        root = 'D:\Drive\1 - Threshold\';
        % 16942_1; 19520_1; 19933_1; 37104_1; 41820_1; 45997_1; 82170_1;
        % 87808_1; 96269_1
        participants_to_drop = [5 6 7 37 40 46 88 101 117]; % due to the poor ICA decoposition
    elseif settings.paradigm == 2
        root = 'D:\Drive\2 - Cue\';
    elseif settings.paradigm == 3
        root = 'D:\Drive\3 - Mask\';
        participants_to_drop = [128 129]; % due to the poor ICA decoposition
    elseif settings.paradigm == 4
        root = 'D:\Drive\4 - Faces\';
        % 35464_4; 52235_4; 72692_4; 79587_4; 91259_4; 95229_4;
        participants_to_drop = [17 30 50 54 67 69]; % due to the poor ICA decoposition
    elseif settings.paradigm == 5
        root = 'D:\Drive\5 - Scenes\';
    end


    pathTFData = [root '\tfdata\']
    pathEEGData = [root '\MARA\']

    mkdir(pathTFData, 'plots');
    savepath = [pathTFData '\plots\']

    addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'

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

            end
            chanlocs_all{s} = EEG.chanlocs;
            events{s} = EEG.event;
        end
        save([root 'events.mat'], 'events');
    end
    clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY






    clear idx
    for s=1:length(listTFData)
        if contains(listTFData(s).name, 'tfdata')
            file=listTFData(s).name;

            B = regexp(file,'\d*','Match');
            listTFData(s).channel = str2num(B{1, 1})
            listTFData(s).participant = str2num(B{1, 2})
            idx(s) = 0;
        else
            idx(s) = 1;
        end
    end
    listTFData(logical(idx)) = [];
    clear idx





    [~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
    clear temp data y* x* beta* EEG B file s
    close all


    for s=1:length(listTFData)
        participantID = listTFData(s).participant;
        if all(participantID ~= [participants_to_drop])
            channel = listTFData(s).channel;
            participant_event = events{participantID};



            temp = load([pathTFData listTFData(s).name]);
            temp2 = temp.tfdata(:,:, [participant_event.epoch]);
            data = sin(angle(temp2));
            data = data(:,:,:);

            idx_highpas = [participant_event.pas] >= 2;
            idx_lowpas = [participant_event.pas] == 1;

            if settings.paradigm==1 | settings.paradigm == 4
                idx_corr = [participant_event.identification2] ==1;
                idx_inc = [participant_event.identification2] == 0;
            elseif settings.paradigm == 3
                idx_corr = [participant_event.corr_corr] == 1
                idx_inc = [participant_event.corr_corr] == 0
            end

            phase_all_lowpas(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_lowpas), 3));
            phase_all_highpas(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_highpas), 3));
            phase_all_corr_id(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_corr), 3));
            phase_all_inc_id(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_inc), 3));


            if settings.paradigm == 4
                idx_neutral = [participant_event.stimulus] == 103
                idx_fearful = [participant_event.stimulus] == 104
                phase_all_fearful(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_fearful), 3));
                phase_all_neutral(participantID, channel, :, :) = squeeze(mean(data(:,:, idx_neutral), 3));
            end

            display(['currently processing: ' num2str(s) ' of ' num2str(length(listTFData)) ]);
        end
    end


    save([savepath 'phase_before_avg_highpas.mat'], 'phase_all_lowpas');
    save([savepath 'phase_before_avg_lowpas.mat'], 'phase_all_highpas');
    save([savepath 'phase_before_avg_corr.mat'], 'phase_all_corr_id');
    save([savepath 'phase_before_avg_inc.mat'], 'phase_all_inc_id');
    if settings.paradigm == 4
        save([savepath 'phase_before_avg_fearfull.mat'], 'phase_all_fearful');
        save([savepath 'phase_before_avg_neutral.mat'], 'phase_all_neutral');
    end




    %% TEST Z BASELINEM
    clear data_all*
    load([savepath 'phase_before_avg_highpas.mat']);
    load([savepath 'phase_before_avg_lowpas.mat']);
    load([savepath 'phase_before_avg_corr.mat']);
    load([savepath 'phase_before_avg_inc.mat']);
    if settings.paradigm == 4
        load([savepath 'phase_before_avg_fearfull.mat']);
        load([savepath 'phase_before_avg_neutral.mat']);
    end


    for i = 1:size(phase_all_lowpas, 1)
        for n = 1:size(phase_all_lowpas, 2)
            for m = 1:size(phase_all_lowpas, 3)

                data_all_corr_id_log = squeeze(phase_all_corr_id(i,:,:,:));
                baseline(n, m) = mean(data_all_corr_id_log(n,m, settings.baseline), 'omitnan');
                phase_all_corr_id_new(i,n,m, :) = data_all_corr_id_log (n,m, :) - baseline( n, m);
                clear baseline;

                data_all_inc_id_log = squeeze(phase_all_inc_id(i,:,:,:));
                baseline(n, m) = mean(data_all_inc_id_log(n,m, settings.baseline), 'omitnan');
                phase_all_inc_id_new(i,n,m, :) = data_all_inc_id_log (n,m, :) - baseline( n, m);
                clear baseline;

                data_all_highpas_log = squeeze(phase_all_highpas(i,:,:,:));
                baseline(n, m) = mean(data_all_highpas_log(n,m, settings.baseline), 'omitnan');
                phase_all_highpas_new(i,n,m, :) = data_all_highpas_log (n,m, :) - baseline(n, m);
                clear baseline;

                data_all_lowpas_log = squeeze(phase_all_lowpas(i,:,:,:));
                baseline(n, m) = mean(data_all_lowpas_log(n,m, settings.baseline), 'omitnan');
                phase_all_lowpas_new(i,n,m, :) = data_all_lowpas_log (n,m, :) - baseline(n, m);
                clear baseline;

            end
        end
        display(['currently participant: ' num2str(i) ' out of: ' num2str(size(phase_all_lowpas_new, 1)) ]);

    end
    save([savepath 'phase_highpas.mat'], 'phase_all_highpas_new');
    save([savepath 'phase_lowpas.mat'], 'phase_all_lowpas_new');
    save([savepath 'phase_corrid.mat'], 'phase_all_corr_id_new');
    save([savepath 'phase_incid.mat'], 'phase_all_inc_id_new');




mean_all_corr_id = squeeze(mean(phase_all_corr_id_new, 1, 'omitnan'));
mean_all_inc_id = squeeze(mean(phase_all_inc_id_new, 1, 'omitnan'));
mean_all_highpas = squeeze(mean(phase_all_highpas_new, 1, 'omitnan'));
mean_all_lowpas = squeeze(mean(phase_all_lowpas_new, 1, 'omitnan'));

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


selected_chann_corr_id = squeeze(mean(mean_all_corr_id(settings.selected_channels, :,:), 1));
selected_chann_inc_id =squeeze(mean(mean_all_inc_id(settings.selected_channels, :,:), 1));
selected_chann_highpas =squeeze(mean(mean_all_highpas(settings.selected_channels, :,:), 1, 'omitnan'));
selected_chann_lowpas =squeeze(mean(mean_all_lowpas(settings.selected_channels, :,:), 1));




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


to_plot.raw_highpas = selected_chann_highpas;
to_plot.raw_lowpas = selected_chann_lowpas;
to_plot.raw_correct = selected_chann_corr_id;
to_plot.raw_incorrect =  selected_chann_inc_id;


to_plot.difference_objective = [selected_chann_corr_id - selected_chann_inc_id ];
to_plot.difference_subjective = [selected_chann_highpas - selected_chann_lowpas ];

fnames = fieldnames(to_plot);


    %% new plot - using contour * imagesc
    for i=1:length(fnames)
        clear temp* mean_data n m
        % preparing data to plot

        m = length(settings.freqs);
        n = size(settings.times, 2);
        temp_data = to_plot.(fnames{i,1});
        % settings.prefix = 'baseline';
        %temp_data = to_plot.(fnames{i,1})(1:8, :);
        fig = figure('Position', [0 0 ss(3) ss(4)], 'Visible', 'off');
        %heatmap(temp_data, 'ColorLimits',[-1 1])
        %     if contains((fnames{i,1}), 'difference')
        %         heatmap(temp_data, 'ColorLimits',[-2 2])
        %     else
        %         heatmap(temp_data, 'ColorLimits',[-8 6])
        %     end
        heatmap(temp_data, 'ColorLimits',[-0.5 0.5])
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
end