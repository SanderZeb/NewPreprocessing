settings.paradigm = 5;
settings.inverted = 0;
settings.intercept = 0;
settings.epochsToAdjust = 0; % legacy; previous batch had extra triggers in events
settings.firstHalf = 0;
%
% if n ==1
%     settings.inverted = 1;
%     settings.intercept = 0;
% elseif n==2
%     settings.inverted = 1;
%     settings.intercept = 1;
% elseif n==3
%     settings.inverted = 0;
%     settings.intercept = 1;
% elseif n==4
%     settings.inverted = 0;
%     settings.intercept = 0;
% end

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
if settings.firstHalf == 0
    if settings.inverted== 1 & settings.intercept== 1
        mkdir(pathTFData, 'betas_odwrotne_intercept');
        pathBETAS = [root '\tfdata\betas_odwrotne_intercept\']
    elseif settings.inverted== 1 & settings.intercept== 0
        mkdir(pathTFData, 'betas_odwrotne');
        pathBETAS = [root '\tfdata\betas_odwrotne\']
    elseif settings.inverted == 0 & settings.intercept== 1
        mkdir(pathTFData, 'betas_intercept');
        pathBETAS = [root '\tfdata\betas_intercept\']
    elseif settings.inverted== 0 & settings.intercept== 0
        mkdir(pathTFData, 'betas');
        pathBETAS = [root '\tfdata\betas\']
    end
elseif settings.firstHalf ==1
    mkdir(pathTFData, 'fromFirstHalf');
    pathTFData2 = [pathTFData '\fromFirstHalf'];
    if settings.inverted== 1 & settings.intercept== 1
        mkdir(pathTFData2, 'betas_odwrotne_intercept');
        pathBETAS = [root '\tfdata\fromFirstHalf\betas_odwrotne_intercept\']
    elseif settings.inverted== 1 & settings.intercept== 0
        mkdir(pathTFData2, 'betas_odwrotne');
        pathBETAS = [root '\tfdata\fromFirstHalf\betas_odwrotne\']
    elseif settings.inverted == 0 & settings.intercept== 1
        mkdir(pathTFData2, 'betas_intercept');
        pathBETAS = [root '\tfdata\fromFirstHalf\betas_intercept\']
    elseif settings.inverted== 0 & settings.intercept== 0
        mkdir(pathTFData2, 'betas');
        pathBETAS = [root '\tfdata\fromFirstHalf\betas\']
    end
end


addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
eeglab nogui

listTFData=dir([pathTFData '*.mat'  ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData)

try
    load([root 'events.mat'])
    fileEEGData=listEEGData(1).name;
    EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
catch
    for s=[1:participants]
        fileEEGData=listEEGData(s).name;
        EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
        if settings.paradigm == 5

            %EEG = pop_selectevent( EEG, 'type',[20 21 120 121 40 41 140 141 80 81 180 181 30 31 130 131 50 51 150 151 90 91 190 191] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
            display('KONIECZNY DEBUGGING MARKERÓW IDENTIFICATION!');
        end
        events{s} = EEG.event;
    end
    save([root 'events.mat'], 'events');
end
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY fileEEGData

for s=1:length(listTFData)

    file=listTFData(s).name;

    B = regexp(file,'\d*','Match');
    listTFData(s).channel = str2num(B{1, 1})
    listTFData(s).participant = str2num(B{1, 2})
end

[~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
clear temp data y* x* beta* EEG B file s
clear temp data* y* x* idx* beta* empty* participant_event participantID channel id_to_drop to_include
close all
for s=1:length(listTFData)
    participantID = listTFData(s).participant;
    if participantID~=34
        channel = listTFData(s).channel;
        participant_event = events{participantID};
        temp = load([pathTFData listTFData(s).name]);
        if settings.firstHalf == 0
            data = abs(temp.tfdata);

            if settings.epochsToAdjust == 1
                data = data(:,  :, [participant_event.epoch]);
            end

        elseif settings.firstHalf == 1
            task_type = participant_event(1).task_type;

            for i=1:length(participant_event)
                if strcmp(participant_event(i).task_type, task_type)
                    idx_first_half(i) = 1;
                    idx_second_half(i) = 0;
                else
                    idx_first_half(i) = 0;
                    idx_second_half(i) = 1;
                end
            end

            data = abs(temp.tfdata);
            data_1sthalf = data(:,:, idx_first_half);
            data_2ndhalf = data(:,:, idx_second_half);
        end



        
        for i=1:length(participant_event)
            if isempty(participant_event(i).task_type)
                idx(i) = 0;
            else
                idx(i) = 1;
            end
        end


        %     participant_event2 = participant_event(boolean(idx));
        %     for i =1:length(participant_event2)
        %         to_include(i) = i;
        %     end
        %     %     to_include = [participant_event2.epoch];
        %
        %     data = data(:,:,to_include);
        %

        x = participant_event;
        x = rmfield(x, 'type');
        x = rmfield(x, 'latency');
        x = rmfield(x, 'urevent');
        x = rmfield(x, 'epoch');
        x = rmfield(x, 'stimulus');


    if settings.firstHalf == 0
        if settings.paradigm == 5
            for i=1:length(x)
                if strcmp(x(i).background, 'artificial')
                    x(i).background = 1;
                elseif strcmp(x(i).background, 'natural' )
                    x(i).background = 0;
                end

                if strcmp(x(i).object,'object')
                    x(i).object = 1;
                elseif strcmp(x(i).object, 'animal' )
                    x(i).object = 0;
                end

                if strcmp(x(i).task_type,'object')
                    x(i).task_type = 1;
                elseif strcmp(x(i).task_type, 'background')
                    x(i).task_type = 0;
                end

            end

        end
    
        x = rmfield(x, 'identification');
        x = rmfield(x, 'version');
        x = rmfield(x, 'task_order');
        x = rmfield(x, 'participant');
        x = rmfield(x, 'trial');


        empty_event = cellfun(@isempty, struct2cell(x));
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

        x([id_to_drop]) = [];

        idx_tt_object = [x.task_type] == 1;
        idx_tt_background = [x.task_type] == 0;

        x_tt_object = x(idx_tt_object);
        x_tt_background = x(idx_tt_background);

        data_tt_object = data(:,:,idx_tt_object);
        data_tt_background = data(:,:,idx_tt_background);


        x_tt_object = rmfield(x_tt_object, 'task_type');
        x_tt_background = rmfield(x_tt_background, 'task_type');

        x_tt_object = single(transpose(cell2mat(squeeze(struct2cell(x_tt_object)))));
        x_tt_background = single(transpose(cell2mat(squeeze(struct2cell(x_tt_background)))));


    elseif settings.firstHalf == 1
        if settings.paradigm == 5
            empty_event = cellfun(@isempty, struct2cell(x));
            empty_events(s) = sum(sum(empty_event));

            if sum(sum(empty_event)) > 0
                empty_event = squeeze(empty_event)';
                [empty_event_r, empty_event_c] = find(empty_event==1);
                id_to_drop = unique(empty_event_r)
            else
                id_to_drop = [];
            end

            x([id_to_drop]) = [];

            
            x_first_half = x(idx_first_half);
            x_second_half = x(idx_first_half);
            for i=1:length(x)
                if strcmp(x(i).background, 'artificial')
                    x_first_half(i).background = 1;
                    x_second_half(i).background = 1;
                elseif strcmp(x(i).background, 'natural' )
                    x_first_half(i).background = 0;
                    x_second_half(i).background = 0;
                end

                if strcmp(x(i).object,'object')
                    x_first_half(i).object = 1;
                    x_second_half(i).object = 1;
                elseif strcmp(x(i).object, 'animal' )
                    x_first_half(i).object = 0;
                    x_second_half(i).object = 0;
                end

                if strcmp(x(i).task_type,'object')
                    x_first_half(i).task_type = 1;
                    x_second_half(i).task_type = 1;
                elseif strcmp(x(i).task_type, 'background')
                    x_first_half(i).task_type = 0;
                    x_second_half(i).task_type = 0;
                end

            end

        end

        x_first_half = rmfield(x_first_half, 'identification');
        x_first_half = rmfield(x_first_half, 'version');
        x_first_half = rmfield(x_first_half, 'task_order');
        x_first_half = rmfield(x_first_half, 'participant');
        x_first_half = rmfield(x_first_half, 'trial');
        x_second_half = rmfield(x_second_half, 'identification');
        x_second_half = rmfield(x_second_half, 'version');
        x_second_half = rmfield(x_second_half, 'task_order');
        x_second_half = rmfield(x_second_half, 'participant');
        x_second_half = rmfield(x_second_half, 'trial');



        if x_first_half(1).task_type == 1 

            data_tt_object_1st_half = data_1sthalf;
            data_tt_background_2nd_half = data_2ndhalf;

            x_first_half = rmfield(x_first_half, 'task_type');
            x_second_half = rmfield(x_second_half, 'task_type');

            x_first_half = single(transpose(cell2mat(squeeze(struct2cell(x_first_half)))));
            x_second_half = single(transpose(cell2mat(squeeze(struct2cell(x_second_half)))));
        else
            
            data_tt_background_1st_half = data_1sthalf;
            data_tt_object_2nd_half = data_2ndhalf;

            x_first_half = rmfield(x_first_half, 'task_type');
            x_second_half = rmfield(x_second_half, 'task_type');

            x_first_half = single(transpose(cell2mat(squeeze(struct2cell(x_first_half)))));
            x_second_half = single(transpose(cell2mat(squeeze(struct2cell(x_second_half)))));
        end
    end



        if settings.intercept == 1

            addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'

            x_standarized_object = ones(length(x_tt_object), 1); % intercept
            x_standarized_object(:, 2) = zscore(x_tt_object(:, 5)); % PAS
            x_standarized_object(:, 3) = zscore(x_tt_object(:, 6)); % identifiction
            x_standarized_object(:, 4) = zscore(x_tt_object(:, 1)); % object animal / object
            x_standarized_object(:, 5) = zscore(x_tt_object(:, 3)); % background artificial / natural
            x_standarized_object(:, 6) = zscore(x_tt_object(:, 2)); % duration
            x_standarized_object(:, 7) = zscore(x_tt_object(:, 4)); % congruency
            x_standarized_object(:, 8) = x_standarized_object(:, 2) .* x_standarized_object(:, 6); % PAS x DURATION
            x_standarized_object(:, 9) = x_standarized_object(:, 3) .* x_standarized_object(:, 6); % ID x DURATION
            x_standarized_object(:, 10) = x_standarized_object(:, 2) .* x_standarized_object(:, 3); % ID x pas

            x_standarized_background = ones(length(x_tt_background), 1); % intercept
            x_standarized_background(:, 2) = zscore(x_tt_background(:, 5)); % PAS
            x_standarized_background(:, 3) = zscore(x_tt_background(:, 6)); % identifiction
            x_standarized_background(:, 4) = zscore(x_tt_background(:, 1)); % object animal / object
            x_standarized_background(:, 5) = zscore(x_tt_background(:, 3)); % background artificial / natural
            x_standarized_background(:, 6) = zscore(x_tt_background(:, 2)); % duration
            x_standarized_background(:, 7) = zscore(x_tt_background(:, 4)); % congruency
            x_standarized_background(:, 8) = x_standarized_background(:, 2) .* x_standarized_background(:, 6); % PAS x DURATION
            x_standarized_background(:, 9) = x_standarized_background(:, 3) .* x_standarized_background(:, 6); % ID x DURATION
            x_standarized_background(:, 10) = x_standarized_background(:, 2) .* x_standarized_background(:, 3); % ID x pas


            for (k=1:length(settings.times))
                for(j=1:length(settings.freqs))
                    clear y* ;
                    y_object = squeeze(data_tt_object(j,k,:));
                    y_background = squeeze(data_tt_background(j,k,:));
                    y_standarized_object = zscore(y_object);
                    y_standarized_background = zscore(y_background);
                    %beta= mvregress( x_standarized,y_standarized); % mvregress(X, Y)
                    if settings.inverted == 0
                        beta_object= x_standarized_object\y_standarized_object; % mvregress(X, Y)
                        beta_background = x_standarized_background\y_standarized_background;
                    elseif settings.inverted == 1
                        beta_object= y_standarized_object\x_standarized_object; % mvregress(X, Y)
                        beta_background= y_standarized_background\x_standarized_background; % mvregress(X, Y)

                        % betas needs to be transposed
                        beta_object = beta_object';
                        beta_background = beta_background';
                    end

                    beta_background_intercept(j,k) = beta_background(1,1);
                    beta_background_pas(j,k) = beta_background(2,1);
                    beta_background_identification(j,k) = beta_background(3,1);
                    beta_background_object(j,k) = beta_background(4,1);
                    beta_background_background(j,k) = beta_background(5,1);
                    beta_background_duration(j,k) = beta_background(6,1);
                    beta_background_congruency(j,k) = beta_background(7,1);
                    beta_background_PASxDUR(j,k) = beta_background(8,1);
                    beta_background_IDxDUR(j,k) = beta_background(9,1);
                    beta_background_PASxID(j,k) = beta_background(10,1);

                    beta_object_intercept(j,k) = beta_object(1,1);
                    beta_object_pas(j,k) = beta_object(2,1);
                    beta_object_identification(j,k) = beta_object(3,1);
                    beta_object_object(j,k) = beta_object(4,1);
                    beta_object_background(j,k) = beta_object(5,1);
                    beta_object_duration(j,k) = beta_object(6,1);
                    beta_object_congruency(j,k) = beta_object(7,1);
                    beta_object_PASxDUR(j,k) = beta_object(8,1);
                    beta_object_IDxDUR(j,k) = beta_object(9,1);
                    beta_object_PASxID(j,k) = beta_object(10,1);

                end
            end
            display(['procesujê: ' num2str(s) ' z ' num2str(length(listTFData)) ]);

            save([pathBETAS num2str(participantID) '_Betas_background_intercept_chann_' num2str(channel)], 'beta_background_intercept');
            save([pathBETAS num2str(participantID) '_Betas_background_pas_chann_' num2str(channel)], 'beta_background_pas');
            save([pathBETAS num2str(participantID) '_Betas_background_identification_chann_' num2str(channel)], 'beta_background_identification');
            save([pathBETAS num2str(participantID) '_Betas_background_object_chann_' num2str(channel)], 'beta_background_object');
            save([pathBETAS num2str(participantID) '_Betas_background_background_chann_' num2str(channel)], 'beta_background_background');
            save([pathBETAS num2str(participantID) '_Betas_background_duration_chann_' num2str(channel)], 'beta_background_duration');
            save([pathBETAS num2str(participantID) '_Betas_background_congruency_chann_' num2str(channel)], 'beta_background_congruency');
            save([pathBETAS num2str(participantID) '_Betas_background_PASxDUR_chann_' num2str(channel)], 'beta_background_PASxDUR');
            save([pathBETAS num2str(participantID) '_Betas_background_IDxDUR_chann_' num2str(channel)], 'beta_background_IDxDUR');
            save([pathBETAS num2str(participantID) '_Betas_background_PASxID_chann_' num2str(channel)], 'beta_background_PASxID');

            save([pathBETAS num2str(participantID) '_Betas_object_intercept_chann_' num2str(channel)], 'beta_object_intercept');
            save([pathBETAS num2str(participantID) '_Betas_object_pas_chann_' num2str(channel)], 'beta_object_pas');
            save([pathBETAS num2str(participantID) '_Betas_object_identification_chann_' num2str(channel)], 'beta_object_identification');
            save([pathBETAS num2str(participantID) '_Betas_object_object_chann_' num2str(channel)], 'beta_object_object');
            save([pathBETAS num2str(participantID) '_Betas_object_background_chann_' num2str(channel)], 'beta_object_background');
            save([pathBETAS num2str(participantID) '_Betas_object_duration_chann_' num2str(channel)], 'beta_object_duration');
            save([pathBETAS num2str(participantID) '_Betas_object_congruency_chann_' num2str(channel)], 'beta_object_congruency');
            save([pathBETAS num2str(participantID) '_Betas_object_PASxDUR_chann_' num2str(channel)], 'beta_object_PASxDUR');
            save([pathBETAS num2str(participantID) '_Betas_object_IDxDUR_chann_' num2str(channel)], 'beta_object_IDxDUR');
            save([pathBETAS num2str(participantID) '_Betas_object_PASxID_chann_' num2str(channel)], 'beta_object_PASxID');


        elseif settings.intercept == 0

            addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
            x_standarized_object(:, 1) = zscore(x_tt_object(:, 5)); % PAS
            x_standarized_object(:, 2) = zscore(x_tt_object(:, 6)); % identifiction
            x_standarized_object(:, 3) = zscore(x_tt_object(:, 1)); % object animal / object
            x_standarized_object(:, 4) = zscore(x_tt_object(:, 3)); % background artificial / natural
            x_standarized_object(:, 5) = zscore(x_tt_object(:, 2)); % duration
            x_standarized_object(:, 6) = zscore(x_tt_object(:, 4)); % congruency
            x_standarized_object(:, 8) = x_standarized_object(:, 1) .* x_standarized_object(:, 5); % PAS x DURATION
            x_standarized_object(:, 9) = x_standarized_object(:, 2) .* x_standarized_object(:, 5); % ID x DURATION
            x_standarized_object(:, 10) = x_standarized_object(:, 2) .* x_standarized_object(:, 1); % ID x pas


            x_standarized_background(:, 1) = zscore(x_tt_background(:, 5)); % PAS
            x_standarized_background(:, 2) = zscore(x_tt_background(:, 6)); % identifiction
            x_standarized_background(:, 3) = zscore(x_tt_background(:, 1)); % object animal / object
            x_standarized_background(:, 4) = zscore(x_tt_background(:, 3)); % background artificial / natural
            x_standarized_background(:, 5) = zscore(x_tt_background(:, 2)); % duration
            x_standarized_background(:, 6) = zscore(x_tt_background(:, 4)); % congruency
            x_standarized_background(:, 8) = x_standarized_background(:, 1) .* x_standarized_background(:, 5); % PAS x DURATION
            x_standarized_background(:, 9) = x_standarized_background(:, 2) .* x_standarized_background(:, 5); % ID x DURATION
            x_standarized_background(:, 10) = x_standarized_background(:, 2) .* x_standarized_background(:, 1); % ID x pas



            for (k=1:length(settings.times))
                for(j=1:length(settings.freqs))
                    clear y* ;
                    y_object = squeeze(data_tt_object(j,k,:));
                    y_background = squeeze(data_tt_background(j,k,:));
                    y_standarized_object = zscore(y_object);
                    y_standarized_background = zscore(y_background);
                    %beta= mvregress( x_standarized,y_standarized); % mvregress(X, Y)
                    if settings.inverted == 0
                        beta_object= x_standarized_object\y_standarized_object; % mvregress(X, Y)
                        beta_background = x_standarized_background\y_standarized_background;
                    elseif settings.inverted == 1
                        beta_object= y_standarized_object\x_standarized_object; % mvregress(X, Y)
                        beta_background= y_standarized_background\x_standarized_background; % mvregress(X, Y)

                        % betas needs to be transposed
                        beta_object = beta_object';
                        beta_background = beta_background';
                    end


                    beta_background_pas(j,k) = beta_background(1,1);
                    beta_background_identification(j,k) = beta_background(2,1);
                    beta_background_object(j,k) = beta_background(3,1);
                    beta_background_background(j,k) = beta_background(4,1);
                    beta_background_duration(j,k) = beta_background(5,1);
                    beta_background_congruency(j,k) = beta_background(6,1);
                    beta_background_PASxDUR(j,k) = beta_background(7,1);
                    beta_background_IDxDUR(j,k) = beta_background(8,1);
                    beta_background_PASxID(j,k) = beta_background(9,1);

                    beta_object_pas(j,k) = beta_object(1,1);
                    beta_object_identification(j,k) = beta_object(2,1);
                    beta_object_object(j,k) = beta_object(3,1);
                    beta_object_background(j,k) = beta_object(4,1);
                    beta_object_duration(j,k) = beta_object(5,1);
                    beta_object_congruency(j,k) = beta_object(6,1);
                    beta_object_PASxDUR(j,k) = beta_object(7,1);
                    beta_object_IDxDUR(j,k) = beta_object(8,1);
                    beta_object_PASxID(j,k) = beta_object(9,1);

                end
            end
            display(['procesujê: ' num2str(s) ' z ' num2str(length(listTFData)) ]);

            save([pathBETAS num2str(participantID) '_Betas_background_pas_chann_' num2str(channel)], 'beta_background_pas');
            save([pathBETAS num2str(participantID) '_Betas_background_identification_chann_' num2str(channel)], 'beta_background_identification');
            save([pathBETAS num2str(participantID) '_Betas_background_object_chann_' num2str(channel)], 'beta_background_object');
            save([pathBETAS num2str(participantID) '_Betas_background_background_chann_' num2str(channel)], 'beta_background_background');
            save([pathBETAS num2str(participantID) '_Betas_background_duration_chann_' num2str(channel)], 'beta_background_duration');
            save([pathBETAS num2str(participantID) '_Betas_background_congruency_chann_' num2str(channel)], 'beta_background_congruency');
            save([pathBETAS num2str(participantID) '_Betas_background_PASxDUR_chann_' num2str(channel)], 'beta_background_PASxDUR');
            save([pathBETAS num2str(participantID) '_Betas_background_IDxDUR_chann_' num2str(channel)], 'beta_background_IDxDUR');
            save([pathBETAS num2str(participantID) '_Betas_background_PASxID_chann_' num2str(channel)], 'beta_background_PASxID');

            save([pathBETAS num2str(participantID) '_Betas_object_pas_chann_' num2str(channel)], 'beta_object_pas');
            save([pathBETAS num2str(participantID) '_Betas_object_identification_chann_' num2str(channel)], 'beta_object_identification');
            save([pathBETAS num2str(participantID) '_Betas_object_object_chann_' num2str(channel)], 'beta_object_object');
            save([pathBETAS num2str(participantID) '_Betas_object_background_chann_' num2str(channel)], 'beta_object_background');
            save([pathBETAS num2str(participantID) '_Betas_object_duration_chann_' num2str(channel)], 'beta_object_duration');
            save([pathBETAS num2str(participantID) '_Betas_object_congruency_chann_' num2str(channel)], 'beta_object_congruency');
            save([pathBETAS num2str(participantID) '_Betas_object_PASxDUR_chann_' num2str(channel)], 'beta_object_PASxDUR');
            save([pathBETAS num2str(participantID) '_Betas_object_IDxDUR_chann_' num2str(channel)], 'beta_object_IDxDUR');
            save([pathBETAS num2str(participantID) '_Betas_object_PASxID_chann_' num2str(channel)], 'beta_object_PASxID');
        end
        clear temp data* y* x* idx* beta* empty* participant_event participantID channel id_to_drop to_include
    end
end
