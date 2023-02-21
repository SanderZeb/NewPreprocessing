 
for curr_paradigm = [2:4]
    if curr_paradigm == 1
        settings.paradigm = 1;
        settings.timewindow = [-400 0];
    elseif curr_paradigm == 2
        settings.paradigm = 3;
        settings.timewindow = [-800 0]
    elseif curr_paradigm == 3
        settings.paradigm = 4;
        settings.timewindow = [-800 -100]
    elseif curr_paradigm == 4
        settings.paradigm = 5;
        settings.timewindow = [-800 -350]
    end
    addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
    addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
    cd('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats')
    eeglab nogui
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
    pathLoadData= [root '\MARA\'];
    list=dir([pathLoadData '*.set'  ]);
    mkdir(root, 'pwelch_adjusted_timewindow');
    parthSaveData = [root '\pwelch_adjusted_timewindow\'];
    
if settings.paradigm ==3
    start = 59;
else
    start = 1;
end

    for s=[start:length(list)]

        file=list(s).name;
        EEG = pop_loadset('filename',file,'filepath',pathLoadData);

        clear tfdata data_psds



        chanlocs =  EEG.chanlocs;
        channels(1).M1 = find(strcmp({chanlocs.labels}, 'M1')==1);  			%INDEX CHANNEL
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
        channels.P1 = find(strcmp({chanlocs.labels}, 'P1')==1);
        channels.P2 = find(strcmp({chanlocs.labels}, 'P2')==1);
        channels.P3 = find(strcmp({chanlocs.labels}, 'P3')==1);
        channels.P4 = find(strcmp({chanlocs.labels}, 'P4')==1);
        channels.P5 = find(strcmp({chanlocs.labels}, 'P5')==1);
        channels.P6 = find(strcmp({chanlocs.labels}, 'P6')==1);
        channels.P7 = find(strcmp({chanlocs.labels}, 'P7')==1);
        channels.P8 = find(strcmp({chanlocs.labels}, 'P8')==1);
        channels.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1);
        channels.Iz = find(strcmp({chanlocs.labels}, 'Iz')==1);
        channels.VEOG = find(strcmp({chanlocs.labels}, 'VEOG')==1);									%INDEX CHANNEL
        channels.HEOG = find(strcmp({chanlocs.labels}, 'HEOG')==1);									%INDEX CHANNEL

        settings.selected_channels = [channels.O1 channels.Oz channels.O2 channels.PO7 channels.PO8 channels.PO3 channels.PO4 channels.POz channels.Iz channels.P1 channels.Pz channels.P2 channels.P3 channels.P5 channels.P7];
        idx_timewindow = settings.timewindow(1) < EEG.times & settings.timewindow(2) > EEG.times;
        %sum(idx_timewindow)
        %times = EEG.times(idx_timewindow)
        indices_timewindow = find(idx_timewindow == 1);
        times_start = indices_timewindow(1);
        times_end = indices_timewindow(length(indices_timewindow));


        tic
        for(i=1:length(settings.selected_channels))
            for(n=1:size(EEG.data, 3))
                addpath('C:\Program Files\MATLAB\R2022b\toolbox\signal\signal');
                [psds, freqs] = pwelch(EEG.data(settings.selected_channels(i),times_start:times_end,n), [], [], [], EEG.srate);

                % Transpose, to make inputs row vectors
                %freqs = freqs';
                psds = psds';

                data_psds(settings.selected_channels(i), n, :) = psds;
                %data_freqs(i, n, :) = freqs;

                clear freqs psds
            end
        end
        toc
        save([  parthSaveData '/pwelch_participant_' num2str(s)], 'data_psds', '-v7.3')  ;

        close all


        display(['processing: ' num2str(s) ' out of ' num2str(length(list))]);

    end
end