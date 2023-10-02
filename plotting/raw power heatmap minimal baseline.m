for paradigm = 3:3

    if paradigm == 1
        settings.paradigm = 1; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes
    elseif paradigm == 2
        settings.paradigm = 3;
    elseif paradigm == 3
        settings.paradigm = 4;
    elseif paradigm == 4
        settings.paradigm = 5;
    end
    settings.oldway = 0; % 0 for 4 topoplots [-800 -600; -600 -400; -400 -200; -200 0]; 1 for multiple topoplots with averaged timewindow (specified by settings.step)
    settings.log10 = 0;


    if settings.paradigm == 1
        root = 'D:\Drive\1 - Threshold\';
        %participants_to_drop = [5 6 7 15 27 42 43 85 114 122 123];
         participants_to_drop = [5 6 7 18 27 42 43 85 114 122 123];

    elseif settings.paradigm == 2
        root = 'D:\Drive\2 - Cue\';
    elseif settings.paradigm == 3
        root = 'D:\Drive\3 - Mask\';
        participants_to_drop = [82 128 129  161]; % due to the poor ICA decoposition

    elseif settings.paradigm == 4
        root = 'D:\Drive\4 - Faces\';
        participants_to_drop = [61 62 63 82]; % due to the poor ICA decoposition
        %participants_to_drop = [17 30 50 54 67 69]; % due to the poor ICA decoposition
        settings.baseline = [1:10];
    elseif settings.paradigm == 5
        root = 'D:\Drive\5 - Scenes\';
        settings.baseline = [1:10];
    end


    pathTFData = [root '\tfdata\']
    pathEEGData = [root '\MARA\']


    desktoppath = 'C:\Users\user\Desktop\alfa\';
    %mkdir(pathTFData, 'plots_mean_baseline_whole_epoch');
    mkdir(desktoppath, 'test8');
    newpath = 'C:\Users\user\Desktop\alfa\test8\'
    mkdir(newpath, num2str(settings.paradigm));
    mkdir(newpath, 'topo');
    loadpath = [pathTFData '\plots\'];
    %savepath = [newpath num2str(settings.paradigm) '\'];
    savepath = [newpath '\'];

    addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'

    eeglab nogui

    listTFData=dir([pathTFData '*mat' ]);
    listEEGData=dir([pathEEGData '*.set'  ]);
    participants = length(listEEGData);

    %load([root 'events_new2.mat']);
    fileEEGData=listEEGData(1).name;
    EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
    clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY

    clear idx
    for s=1:length(listTFData)
        if contains(listTFData(s).name, 'tfdata')
            file=listTFData(s).name;

            B = regexp(file,'\d*','Match');
            listTFData(s).channel = str2num(B{1, 1});
            listTFData(s).participant = str2num(B{1, 2});
            idx(s) = 0;
        else
            idx(s) = 1;
        end
    end
    listTFData(logical(idx)) = [];
    clear idx

    [~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
    chanlocs = EEG.chanlocs;
    clear temp data y* x* beta* EEG B file s idx
    close all
    %fileEEGData=listEEGData(1).name;
    %EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);

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
    channels_to_drop = chanlocs(1:64);
    channels_to_drop(settings.selected_channels) = [];
    clear data_all*
    if any(settings.paradigm == [1 2 3 4])
        load([loadpath 'tfdata_before_avg_highpas.mat']);
        load([loadpath 'tfdata_before_avg_lowpas.mat']);
        load([loadpath 'tfdata_before_avg_corr.mat']);
        load([loadpath 'tfdata_before_avg_inc.mat']);
    elseif settings.paradigm == 5
        load([loadpath 'data_all_highpas_background.mat']);
        load([loadpath 'data_all_lowpas_background.mat']);
        load([loadpath 'data_all_corr_id_background.mat']);
        load([loadpath 'data_all_inc_id_background.mat']);
        load([loadpath 'data_all_highpas_object.mat']);
        load([loadpath 'data_all_lowpas_object.mat']);
        load([loadpath 'data_all_corr_id_object.mat']);
        load([loadpath 'data_all_inc_id_object.mat']);
    end
    if any(settings.paradigm == [1 2 3 4])

         data_all_corr_id([participants_to_drop],:,:,:) = [];
         data_all_inc_id([participants_to_drop],:,:,:) = [];
         data_all_highpas([participants_to_drop],:,:,:) = [];
         data_all_lowpas([participants_to_drop],:,:,:) = [];

        topo_data_all_corr_id = squeeze(mean(data_all_corr_id(:,:,1:9, :), 3));
        topo_data_all_inc_id = squeeze(mean(data_all_inc_id(:,:,1:9, :), 3));
        topo_data_all_highpas = squeeze(mean(data_all_highpas(:,:,1:9, :), 3));
        topo_data_all_lowpas = squeeze(mean(data_all_lowpas(:,:,1:9, :), 3));

        data_all_corr_id(:, [channels_to_drop.urchan],:,:) = [];
        %         data_all_corr_id(:, :,:,101:end) = [];

        data_all_inc_id(:, [channels_to_drop.urchan],:,:) = [];
        %         data_all_inc_id(:, :,:,101:end) = [];

        data_all_highpas(:, [channels_to_drop.urchan],:,:) = [];
        %         data_all_highpas(:, :,:,101:end) = [];

        data_all_lowpas(:, [channels_to_drop.urchan],:,:) = [];
        %         data_all_lowpas(:, :,:,101:end) = [];

    elseif settings.paradigm == 5
        topo_data_all_corr_id_background = squeeze(mean(data_all_corr_id_background(:,:,1:9, :), 3));
        topo_data_all_inc_id_background = squeeze(mean(data_all_inc_id_background(:,:,1:9, :), 3));
        topo_data_all_highpas_background = squeeze(mean(data_all_highpas_background(:,:,1:9, :), 3));
        topo_data_all_lowpas_background = squeeze(mean(data_all_lowpas_background(:,:,1:9, :), 3));

        topo_data_all_corr_id_object = squeeze(mean(data_all_corr_id_object(:,:,1:9, :), 3));
        topo_data_all_inc_id_object = squeeze(mean(data_all_inc_id_object(:,:,1:9, :), 3));
        topo_data_all_highpas_object = squeeze(mean(data_all_highpas_object(:,:,1:9, :), 3));
        topo_data_all_lowpas_object = squeeze(mean(data_all_lowpas_object(:,:,1:9, :), 3));

        data_all_corr_id_background(:, [channels_to_drop.urchan],:,:) = [];
        data_all_corr_id_object(:, [channels_to_drop.urchan],:,:) = [];
        data_all_highpas_background(:, [channels_to_drop.urchan],:,:) = [];
        data_all_highpas_object(:, [channels_to_drop.urchan],:,:) = [];
        data_all_inc_id_background(:, [channels_to_drop.urchan],:,:) = [];
        data_all_inc_id_object(:, [channels_to_drop.urchan],:,:) = [];
        data_all_lowpas_background(:, [channels_to_drop.urchan],:,:) = [];
        data_all_lowpas_object(:, [channels_to_drop.urchan],:,:) = [];

        %         data_all_corr_id_background(:, :,:,101:end) = [];
        %         data_all_corr_id_object(:, :,:,101:end) = [];
        %         data_all_highpas_background(:, :,:,101:end) = [];
        %         data_all_highpas_object(:, :,:,101:end) = [];
        %         data_all_inc_id_background(:, :,:,101:end) = [];
        %         data_all_inc_id_object(:, :,:,101:end) = [];
        %         data_all_lowpas_background(:, :,:,101:end) = [];
        %         data_all_lowpas_object(:, :,:,101:end) = [];
    end


    if any(settings.paradigm == [1 2 3 4])
        for p=1:size(topo_data_all_corr_id, 1)
            for c = 1:size(topo_data_all_corr_id, 2)
                %baseline = (mean(topo_data_all_corr_id(p, c, 1:10), 'omitnan') + mean(topo_data_all_inc_id(p, c, 1:10), 'omitnan') + mean(topo_data_all_highpas(p, c, 1:10), 'omitnan') +  mean(topo_data_all_lowpas(p, c, 1:10), 'omitnan') ) / 4;
                baseline = mean(topo_data_all_corr_id(p, c, 1:10));
                topo_data_all_corr_id2(p, c, :) = topo_data_all_corr_id(p, c, :) - baseline;
                %clear baseline
                baseline = mean(topo_data_all_inc_id(p, c, 1:10));
                topo_data_all_inc_id2(p, c, :) = topo_data_all_inc_id(p, c, :) - baseline;
                %clear baseline
                baseline = mean(topo_data_all_highpas(p, c, 1:10));
                topo_data_all_highpas2(p, c, :) = topo_data_all_highpas(p, c, :) - baseline;
                %clear baseline
                baseline = mean(topo_data_all_lowpas(p, c, 1:10));
                topo_data_all_lowpas2(p, c, :) = topo_data_all_lowpas(p, c, :) - baseline;
                %clear baseline
            end
        end


        for p=1:size(data_all_corr_id, 1)
            for c = 1:size(data_all_corr_id, 2)
                for f = 1:size(data_all_corr_id, 3)
                    clear baseline
                    baseline = (mean(data_all_corr_id(p, c, f,1:10), 'omitnan') + mean(data_all_inc_id(p, c, f,1:10), 'omitnan') + mean(data_all_lowpas(p, c, f,1:10), 'omitnan') + mean(data_all_highpas(p, c, f,1:10), 'omitnan')) /4;



                    %baseline = min(data_all_corr_id(p, c, f,:));
                    %baseline = mean(data_all_corr_id(p, c, f,1:10));
                    %baseline = mean(data_all_corr_id(p, c, f,:));
                    data_all_corr_id_new(p, c, f, :) = data_all_corr_id(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_inc_id(p, c, f,:));
                    %baseline = mean(data_all_inc_id(p, c, f,1:10));
                    %baseline = mean(data_all_inc_id(p, c, f,:));
                    data_all_inc_id_new(p, c, f, :) = data_all_inc_id(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_lowpas(p, c, f,:));
                    %baseline = mean(data_all_lowpas(p, c, f,1:10));
                    %baseline = mean(data_all_lowpas(p, c, f,:));
                    data_all_lowpas_new(p, c, f, :) = data_all_lowpas(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_highpas(p, c, f,:));
                    %baseline = mean(data_all_highpas(p, c, f,1:10));
                    %baseline = mean(data_all_highpas(p, c, f,:));
                    data_all_highpas_new(p, c, f, :) = data_all_highpas(p, c, f, :) - baseline;
                    %clear baseline
                end
            end
        end
        for i = 1:size(data_all_lowpas_new, 4)
            empty_x{i} = '';
        end
        for i = 1:size(data_all_lowpas_new, 3)
            empty_y{i} = '';
        end
    elseif settings.paradigm == 5
        for p=1:size(data_all_corr_id_background, 1)
            for c = 1:size(data_all_corr_id_background, 2)
                for f = 1:size(data_all_corr_id_background, 3)
                    clear baseline
                    baseline = (mean(data_all_corr_id_background(p, c, f,1:10), 'omitnan') + mean(data_all_corr_id_object(p, c, f,1:10), 'omitnan') + mean(data_all_highpas_background(p, c, f,1:10), 'omitnan') +  mean(data_all_highpas_object(p, c, f,1:10), 'omitnan') + mean(data_all_inc_id_background(p, c, f,1:10), 'omitnan') + mean(data_all_inc_id_object(p, c, f,1:10), 'omitnan') + mean(data_all_lowpas_background(p, c, f,1:10), 'omitnan') + mean(data_all_lowpas_object(p, c, f,1:10), 'omitnan') ) / 8




                    %baseline = min(data_all_corr_id_background(p, c, f,:));
                    %baseline = mean(data_all_corr_id_background(p, c, f,1:10));
                    %baseline = mean(data_all_corr_id_background(p, c, f,:));
                    data_all_corr_id_background_new(p, c, f, :) = data_all_corr_id_background(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_corr_id_object(p, c, f,:));
                    %baseline = mean(data_all_corr_id_object(p, c, f,1:10));
                    %baseline = mean(data_all_corr_id_object(p, c, f,:));
                    data_all_corr_id_object_new(p, c, f, :) = data_all_corr_id_object(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_highpas_background(p, c, f,:));
                    %baseline = mean(data_all_highpas_background(p, c, f,1:10));
                    %baseline = mean(data_all_highpas_background(p, c, f,:));
                    data_all_highpas_background_new(p, c, f, :) = data_all_highpas_background(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_highpas_object(p, c, f,:));
                    %baseline = mean(data_all_highpas_object(p, c, f,1:10));
                    %baseline = mean(data_all_highpas_object(p, c, f,:));
                    data_all_highpas_object_new(p, c, f, :) = data_all_highpas_object(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_inc_id_background(p, c, f,:));
                    %baseline = mean(data_all_inc_id_background(p, c, f,1:10));
                    %baseline = mean(data_all_inc_id_background(p, c, f,:));
                    data_all_inc_id_background_new(p, c, f, :) = data_all_inc_id_background(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_inc_id_object(p, c, f,:));
                    %baseline = mean(data_all_inc_id_object(p, c, f,1:10));
                    %baseline = mean(data_all_inc_id_object(p, c, f,:));
                    data_all_inc_id_object_new(p, c, f, :) = data_all_inc_id_object(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_lowpas_background(p, c, f,:));
                    %baseline = mean(data_all_lowpas_background(p, c, f,1:10));
                    %baseline = mean(data_all_lowpas_background(p, c, f,:));
                    data_all_lowpas_background_new(p, c, f, :) = data_all_lowpas_background(p, c, f, :) - baseline;
                    %clear baseline

                    %baseline = min(data_all_lowpas_object(p, c, f,:));
                    %baseline = mean(data_all_lowpas_object(p, c, f,1:10));
                    %baseline = mean(data_all_lowpas_object(p, c, f,:));
                    data_all_lowpas_object_new(p, c, f, :) = data_all_lowpas_object(p, c, f, :) - baseline;
                    %clear baseline
                end
            end
        end
        for p=1:size(topo_data_all_corr_id_object, 1)
            for c = 1:size(topo_data_all_corr_id_object, 2)

                baseline = (mean(topo_data_all_corr_id_object(p, c, 1:10), 'omitnan') + mean(topo_data_all_inc_id_object(p, c, 1:10), 'omitnan') + mean(topo_data_all_highpas_object(p, c, 1:10), 'omitnan') + mean(topo_data_all_lowpas_object(p, c, 1:10), 'omitnan') +  mean(topo_data_all_corr_id_background(p, c, 1:10), 'omitnan') + mean(topo_data_all_inc_id_background(p, c, 1:10), 'omitnan') + mean(topo_data_all_highpas_background(p, c, 1:10), 'omitnan') + mean(topo_data_all_lowpas_background(p, c, 1:10), 'omitnan')) /8;
                topo_data_all_corr_id_object2(p, c, :) = topo_data_all_corr_id_object(p, c, :) - baseline;
                %clear baseline
                %baseline = mean(topo_data_all_inc_id_object(p, c, 1:10));
                topo_data_all_inc_id_object2(p, c, :) = topo_data_all_inc_id_object(p, c, :) - baseline;
                %clear baseline
                %baseline = mean(topo_data_all_highpas_object(p, c, 1:10));
                topo_data_all_highpas_object2(p, c, :) = topo_data_all_highpas_object(p, c, :) - baseline;
                %clear baseline
                %baseline = mean(topo_data_all_lowpas_object(p, c, 1:10));
                topo_data_all_lowpas_object2(p, c, :) = topo_data_all_lowpas_object(p, c, :) - baseline;
                %clear baseline
                
                %baseline = mean(topo_data_all_corr_id_background(p, c, 1:10));
                topo_data_all_corr_id_background2(p, c, :) = topo_data_all_corr_id_background(p, c, :) - baseline;
                %clear baseline
                %baseline = mean(topo_data_all_inc_id_background(p, c, 1:10));
                topo_data_all_inc_id_background2(p, c, :) = topo_data_all_inc_id_background(p, c, :) - baseline;
                %clear baseline
                %baseline = mean(topo_data_all_highpas_background(p, c, 1:10));
                topo_data_all_highpas_background2(p, c, :) = topo_data_all_highpas_background(p, c, :) - baseline;
                %clear baseline
                %baseline = mean(topo_data_all_lowpas_background(p, c, 1:10));
                topo_data_all_lowpas_background2(p, c, :) = topo_data_all_lowpas_background(p, c, :) - baseline;
                %clear baseline
            end
        end

        for i = 1:size(data_all_corr_id_background, 4)
            empty_x{i} = '';
        end
        for i = 1:size(data_all_corr_id_background, 3)
            empty_y{i} = '';
        end
    end


    ss=get(0, 'ScreenSize');
    lim = [-6 6]
    clear to_plot
    if any(settings.paradigm == [1 2 3 4])

        %helper_manual_inspectionHeatmaps(savepath, data_all_inc_id, data_all_corr_id, data_all_lowpas, data_all_highpas)

        temp = 20:10:180;
        for i = 1:length(temp)
            fig = figure("Visible", 'off');
            topoplot(squeeze(mean(topo_data_all_inc_id(:, :, temp(i)), 1, 'omitnan')) - squeeze(mean(topo_data_all_corr_id(:, :, temp(i)), 1, 'omitnan')), chanlocs);
            clim([-2 2]);
            saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'acc_diff.png']);
            close all
            fig = figure("Visible", 'off');
            topoplot(squeeze(mean(topo_data_all_lowpas(:, :, temp(i)), 1, 'omitnan')) - squeeze(mean(topo_data_all_highpas(:, :, temp(i)), 1, 'omitnan')), chanlocs);
            clim([-2 2]);
            saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'pas_diff.png']);
            close all

%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_corr_id2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'corr_id.png']);
%             close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_inc_id2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'inc_id.png']);
%             close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_highpas2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'highpas.png']);
%             close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_lowpas2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'lowpas.png']);
%             close all
        end

        %         to_plot.raw_highpas = 10 * log10(flip(squeeze(mean(mean(data_all_highpas_new, 1), 2))));
        %         to_plot.raw_lowpas = 10 * log10(flip(squeeze(mean(mean(data_all_lowpas_new, 1, 'omitnan'), 2, 'omitnan'))));
        %         to_plot.raw_correct = 10 * log10(flip(squeeze(mean(mean(data_all_corr_id_new, 1), 2))));
        %         to_plot.raw_incorrect =  10 * log10(flip(squeeze(mean(mean(data_all_inc_id_new, 1), 2))));
        to_plot.raw_highpas = flip(squeeze(mean(mean(data_all_highpas_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.raw_lowpas = flip(squeeze(mean(mean(data_all_lowpas_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.raw_correct = flip(squeeze(mean(mean(data_all_corr_id_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.raw_incorrect =  flip(squeeze(mean(mean(data_all_inc_id_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.difference_acc = flip(squeeze(mean(mean(data_all_inc_id, 1, 'omitnan'), 2, 'omitnan'))) - flip(squeeze(mean(mean(data_all_corr_id, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.difference_pas = flip(squeeze(mean(mean(data_all_lowpas, 1, 'omitnan'), 2, 'omitnan'))) - flip(squeeze(mean(mean(data_all_highpas, 1, 'omitnan'), 2, 'omitnan')));
        clear data_all* mean_all* selected_chann_*


        fig = figure('Position', [0 0 ss(3) ss(4)], 'Visible', 'off');
        subplot(2,2, 1);
        heatmap(to_plot.raw_correct, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Correct');
        subplot(2,2,2);
        heatmap(to_plot.raw_incorrect, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Incorrect');
        subplot(2,2,3)
        heatmap(to_plot.raw_highpas, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Highpas');
        subplot(2,2,4)
        heatmap(to_plot.raw_lowpas, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Lowpas');
        saveas(fig,[savepath num2str(settings.paradigm) '_' 'Combination.png']);
        saveas(fig,[savepath num2str(settings.paradigm) '_' 'Combination.fig']);
        save([savepath 'plotting_data.mat'], 'to_plot');
        close all
    elseif settings.paradigm == 5
        temp = 20:10:180;
        for i = 1:length(temp)
            fig = figure("Visible", 'off');
            topoplot(squeeze(mean(topo_data_all_inc_id_object(:, :, temp(i)), 1, 'omitnan')) - squeeze(mean(topo_data_all_corr_id_object(:, :, temp(i)), 1, 'omitnan')), chanlocs);
            clim([-2 2]);
            saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'obj_acc_diff.png']);
            close all
            fig = figure("Visible", 'off');
            topoplot(squeeze(mean(topo_data_all_lowpas_object(:, :, temp(i)), 1, 'omitnan')) - squeeze(mean(topo_data_all_highpas_object(:, :, temp(i)), 1, 'omitnan')), chanlocs);
            clim([-2 2]);
            saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'obj_pas_diff.png']);
            close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_corr_id_object2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'corr_id_object.png']);
%             close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_inc_id_object2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'inc_id_object.png']);
%             close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_highpas_object2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'highpas_object.png']);
%             close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_lowpas_object2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'lowpas_object.png']);
%             close all
        end
        temp = 20:10:180;
        for i = 1:length(temp)
            fig = figure("Visible", 'off');
            topoplot(squeeze(mean(topo_data_all_inc_id_background(:, :, temp(i)), 1, 'omitnan')) - squeeze(mean(topo_data_all_corr_id_background(:, :, temp(i)), 1, 'omitnan')), chanlocs);
            clim([-2 2]);
            saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'bgr_acc_diff.png']);
            close all
            fig = figure("Visible", 'off');
            topoplot(squeeze(mean(topo_data_all_lowpas_background(:, :, temp(i)), 1, 'omitnan')) - squeeze(mean(topo_data_all_highpas_background(:, :, temp(i)), 1, 'omitnan')), chanlocs);
            clim([-2 2]);
            saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'bgr_pas_diff.png']);
            close all

%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_corr_id_background2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'corr_id_background.png']);
%             close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_inc_id_background2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'inc_id_background.png']);
%             close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_highpas_background2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'highpas_background.png']);
%             close all
%             fig = figure("Visible", 'off');
%             topoplot(mean(topo_data_all_lowpas_background2(:, :, temp(i)), 1, 'omitnan'), chanlocs);
%             clim([-5 5]);
%             saveas(fig,[savepath '\topo\' num2str(settings.paradigm) '_' num2str(i) 'lowpas_background.png']);
%             close all
        end



        to_plot.raw_highpas_object = flip(squeeze(mean(mean(data_all_highpas_object_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.raw_lowpas_object = flip(squeeze(mean(mean(data_all_lowpas_object_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.raw_correct_object = flip(squeeze(mean(mean(data_all_corr_id_object_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.raw_incorrect_object =  flip(squeeze(mean(mean(data_all_inc_id_object_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.difference_acc_obj = flip(squeeze(mean(mean(data_all_inc_id_object, 1, 'omitnan'), 2, 'omitnan'))) - flip(squeeze(mean(mean(data_all_corr_id_object, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.difference_pas_obj = flip(squeeze(mean(mean(data_all_lowpas_object, 1, 'omitnan'), 2, 'omitnan'))) - flip(squeeze(mean(mean(data_all_highpas_object, 1, 'omitnan'), 2, 'omitnan')));
        %         to_plot.raw_highpas_object = 10 * log10(flip(squeeze(mean(mean(data_all_highpas_object_new, 1), 2))));
        %         to_plot.raw_lowpas_object = 10 * log10(flip(squeeze(mean(mean(data_all_lowpas_object_new, 1, 'omitnan'), 2, 'omitnan'))));
        %         to_plot.raw_correct_object = 10 * log10(flip(squeeze(mean(mean(data_all_corr_id_object_new, 1), 2))));
        %         to_plot.raw_incorrect_object =  10 * log10(flip(squeeze(mean(mean(data_all_inc_id_object_new, 1), 2))));

        fig = figure('Position', [0 0 ss(3) ss(4)], 'Visible', 'off');
        subplot(2,2, 1);
        heatmap(to_plot.raw_correct_object, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Correct');
        subplot(2,2,2);
        heatmap(to_plot.raw_incorrect_object, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Incorrect');
        subplot(2,2,3)
        heatmap(to_plot.raw_highpas_object, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Highpas');
        subplot(2,2,4)
        heatmap(to_plot.raw_lowpas_object, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Lowpas');
        saveas(fig,[savepath num2str(settings.paradigm) '_' 'Combination_obj.png']);
        saveas(fig,[savepath num2str(settings.paradigm) '_' 'Combination_obj.fig']);
        close all

        %         to_plot.raw_highpas_background = 10 * log10(flip(squeeze(mean(mean(data_all_highpas_background_new, 1), 2))));
        %         to_plot.raw_lowpas_background = 10 * log10(flip(squeeze(mean(mean(data_all_lowpas_background_new, 1, 'omitnan'), 2, 'omitnan'))));
        %         to_plot.raw_correct_background = 10 * log10(flip(squeeze(mean(mean(data_all_corr_id_background_new, 1), 2))));
        %         to_plot.raw_incorrect_background =  10 * log10(flip(squeeze(mean(mean(data_all_inc_id_background_new, 1), 2))));
        to_plot.raw_highpas_background = flip(squeeze(mean(mean(data_all_highpas_background_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.raw_lowpas_background = flip(squeeze(mean(mean(data_all_lowpas_background_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.raw_correct_background = flip(squeeze(mean(mean(data_all_corr_id_background_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.raw_incorrect_background =  flip(squeeze(mean(mean(data_all_inc_id_background_new, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.difference_acc_bgr = flip(squeeze(mean(mean(data_all_inc_id_background, 1, 'omitnan'), 2, 'omitnan'))) - flip(squeeze(mean(mean(data_all_corr_id_background, 1, 'omitnan'), 2, 'omitnan')));
        to_plot.difference_pas_bgr = flip(squeeze(mean(mean(data_all_lowpas_background, 1, 'omitnan'), 2, 'omitnan'))) - flip(squeeze(mean(mean(data_all_highpas_background, 1, 'omitnan'), 2, 'omitnan')));



        fig = figure('Position', [0 0 ss(3) ss(4)], 'Visible', 'off');
        subplot(2,2, 1);
        heatmap(to_plot.raw_correct_background, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Correct');
        subplot(2,2,2);
        heatmap(to_plot.raw_incorrect_background, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Incorrect');
        subplot(2,2,3)
        heatmap(to_plot.raw_highpas_background, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Highpas');
        subplot(2,2,4)
        heatmap(to_plot.raw_lowpas_background, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet; clim(lim)
        title('Lowpas');
        saveas(fig,[savepath num2str(settings.paradigm) '_' 'Combination_bgr.png']);
        saveas(fig,[savepath num2str(settings.paradigm) '_' 'Combination_bgr.fig']);
        save([savepath 'plotting_data.mat'], 'to_plot');
        close all
        clear data_all* mean_all* selected_chann_*
    end

    clear fnames
    fnames = fieldnames(to_plot);
    settings.prefix = 'minimalbaseline';
    for i=1:length(fnames)
        clear temp* mean_data
        temp_data = to_plot.(fnames{i,1});
        settings.prefix = 'baseline';
        fig = figure('Position', [0 0 ss(3) ss(4)], 'Visible', 'off');
        heatmap(temp_data, 'YDisplayLabels', empty_y, 'XDisplayLabels', empty_x); grid off; colormap jet;
        if ~contains(fnames{i} , 'difference')
            clim(lim);
        else
            clim([-1.5 1.5]);
        end



        saveas(fig,[savepath num2str(settings.paradigm) '_' fnames{i,1} '.png']);
        saveas(fig,[savepath num2str(settings.paradigm) '_' fnames{i,1} '.fig']);
        close all
        clear temp_data
    end
end



