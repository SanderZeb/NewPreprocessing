settings.paradigm = 5;
settings.fromEEG = 0; 

% settings.fromEEG == 0 --> create histograms from exported events cell,
% that contains all of the participants 
%                  == 1 --> create histograms from events located in
%                  PreprocessedNewPipeline folder, where freshly filtered
%                  datasets are stored. 
%                  == 2 --> create histograms from events in datasets from
%                  MARA folder, after the rejections


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

pathEEGData = [root '\MARA\']
mkdir(pathEEGData, 'additional_info')
pathEEGData_addinfo = [pathEEGData '\additional_info\']

if settings.fromEEG == 2
    mkdir(pathEEGData_addinfo, 'Preprocessed_EEG_events_histogram');
    savepath = [pathEEGData_addinfo '\Preprocessed_EEG_events_histogram\']
elseif settings.fromEEG == 1
        mkdir(pathEEGData_addinfo, 'BeforeRejections_events_histogram');
        savepath = [pathEEGData_addinfo '\BeforeRejections_events_histogram\']
        pathEEGData = [root '\Preprocessed_new_pipeline\'] 
        
elseif settings.fromEEG == 0
        mkdir(pathEEGData_addinfo, 'exported_events_histogram');
        savepath = [pathEEGData_addinfo '\exported_events_histogram\']
end


addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
eeglab nogui



listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData)

if settings.fromEEG == 0
    load([root 'events.mat'])
end

for s=[1:participants]
    fileEEGData=listEEGData(s).name;
    if settings.fromEEG ~= 0
        EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
    end


    if settings.paradigm ==1

        figure(Visible="off"); hold on;
        t = tiledlayout(2, 2, 'TileSpacing','normal');

        if settings.fromEEG == 0
            temp_events = events{s};
            title(t, [fileEEGData ' events: ' num2str(length(temp_events))])
        else
            temp_events = EEG.event;
            title(t, [fileEEGData ' epochs: ' num2str(length(EEG.epoch)) ' events: ' num2str(length(EEG.event))])
        end

        nexttile;
        histogram([temp_events.type], "BinWidth", 0.5)
        title('type');
        nexttile;
        histogram([temp_events.pas], "BinWidth", 0.5)
        title('PAS');
        nexttile;
        histogram([temp_events.corr_corr], "BinWidth", 0.5)
        title('corr_corr');
        nexttile;
        histogram([temp_events.epoch], "BinWidth", 0.5)
        title('epoch');

    elseif settings.paradigm == 3

        figure(Visible="off"); hold on;
        t = tiledlayout(2, 3, 'TileSpacing','normal');
        if settings.fromEEG == 0
            temp_events = events{s};
            title(t, [fileEEGData ' events: ' num2str(length(temp_events))])
        else
            temp_events = EEG.event;
            title(t, [fileEEGData ' epochs: ' num2str(length(EEG.epoch)) ' events: ' num2str(length(EEG.event))])
        end
        nexttile;
        histogram([temp_events.type], "BinWidth", 0.5)
        title('type');
        nexttile;
        histogram([temp_events.pas], "BinWidth", 0.5)
        title('PAS');
        nexttile;
        histogram([temp_events.corr_corr], "BinWidth", 0.5)
        title('corr_corr');
        nexttile;
        histogram([temp_events.epoch], "BinWidth", 0.5)
        title('epoch');
        nexttile;
        histogram([temp_events.stimulus], "BinWidth", 0.5)
        title('stimulus');
        nexttile;
        histogram([temp_events.identification], "BinWidth", 0.5)
        title('response');
    elseif settings.paradigm == 4

        figure(Visible="off"); hold on;
        t = tiledlayout(2, 3, 'TileSpacing','normal');
        if settings.fromEEG == 0
            temp_events = events{s};
            title(t, [fileEEGData ' events: ' num2str(length(temp_events))])
        else
            temp_events = EEG.event;
            title(t, [fileEEGData ' epochs: ' num2str(length(EEG.epoch)) ' events: ' num2str(length(EEG.event))])
        end
        nexttile;
        histogram([temp_events.type], "BinWidth", 0.5)
        title('type');
        nexttile;
        histogram([temp_events.pas], "BinWidth", 0.5)
        title('PAS');
        nexttile;
        histogram([temp_events.identification2], "BinWidth", 0.5)
        title('corr_corr');
        nexttile;

        histogram([temp_events.stimulus], "BinWidth", 0.5)
        title('stimulus');
        nexttile;
        histogram([temp_events.identification], "BinWidth", 0.5)
        title('response');

    elseif settings.paradigm == 5

        figure(Visible="off"); hold on;
        t = tiledlayout(2, 5, 'TileSpacing','normal');

        if settings.fromEEG == 0
            temp_events = events{s};
            title(t, [fileEEGData ' events: ' num2str(length(temp_events))])
        else
            temp_events = EEG.event;
            title(t, [fileEEGData ' epochs: ' num2str(length(EEG.epoch)) ' events: ' num2str(length(EEG.event))])
        end

        temp_events = events{s};

        for i = 1:length(temp_events)
            if strcmp(temp_events(i).object, "object")
                temp_events(i).object2 = 1; %man made
            else
                temp_events(i).object2 = 0; %natural
            end
            if strcmp(temp_events(i).background, "artificial")
                temp_events(i).background2 = 1; %artificial
            else
                temp_events(i).background2 = 0; % natural
            end
            if strcmp(temp_events(i).task_type, "object")
                temp_events(i).task_type2 = 1; %object
            else
                temp_events(i).task_type2 = 0; %background
            end
        end

        nexttile;
        histogram([temp_events.type], "BinWidth", 0.5)
        title('type');
        nexttile;
        histogram([temp_events.pas], "BinWidth", 0.5)
        title('PAS');
        nexttile;
        histogram([temp_events.corrected_id], "BinWidth", 0.5)
        title('corr_corr');
        nexttile;
        histogram([temp_events.epoch], "BinWidth", 0.5)
        title('epoch');
        nexttile;
        histogram([temp_events.congruency], "BinWidth", 0.5)
        title('congruency');
        nexttile;
        histogram([temp_events.identification], "BinWidth", 0.5)
        title('response');
        nexttile;
        histogram([temp_events.object2], "BinWidth", 0.5)
        title('object');

        nexttile;
        histogram([temp_events.background2], "BinWidth", 0.5)
        title('background');

        nexttile;
        histogram([temp_events.duration], "BinWidth", 0.5)
        title('duration');

        nexttile;
        histogram([temp_events.task_type2], "BinWidth", 0.5)
        title('task type');

        clear temp_events;
    end

    saveas(t, [savepath fileEEGData '.png']);
    close all

end