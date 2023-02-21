settings.paradigm = 5;
settings.inverted = 0;
settings.intercept = 0;
settings.phase = 0;
settings.absolutePower = 1;

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
    mkdir(pathTFData, 'betas_odwrotne_intercept');
    pathBETAS = [root '\tfdata\betas_odwrotne_intercept\']
    if settings.phase == 1
        mkdir(pathTFData, 'betas_phase_odwrotne_intercept');
        pathBETAS_phase = [root '\tfdata\betas_phase_odwrotne_intercept\']
    end
elseif settings.inverted== 1 & settings.intercept== 0
    mkdir(pathTFData, 'betas_odwrotne_nozscore');
    pathBETAS = [root '\tfdata\betas_odwrotne_nozscore\']
    if settings.phase == 1
        mkdir(pathTFData, 'betas_phase_odwrotne');
        pathBETAS_phase = [root '\tfdata\betas_phase_odwrotne\']
    end
elseif settings.inverted == 0 & settings.intercept== 1
    mkdir(pathTFData, 'betas_intercept');
    pathBETAS = [root '\tfdata\betas_intercept\']
    if settings.phase == 1
        mkdir(pathTFData, 'betas_phase_intercept');
        pathBETAS_phase = [root '\tfdata\betas_phase_intercept\']
    end
elseif settings.inverted== 0 & settings.intercept== 0
    mkdir(pathTFData, 'betas_nozscore\');
    pathBETAS = [root '\tfdata\betas_nozscore\\']
    if settings.phase == 1
        mkdir(pathTFData, 'betas_phase');
        pathBETAS_phase = [root '\tfdata\betas_phase\']
    end
end


addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
eeglab nogui

listTFData=dir([pathTFData '*.mat'  ]);
listTFData(1) = []
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

        events{s} = EEG.event;
    end
    save([root 'events.mat'], 'events');
end

for s=1:length(listTFData)

    file=listTFData(s).name;
    B = regexp(file,'\d*','Match');
    listTFData(s).channel = str2num(B{1, 1})
    listTFData(s).participant = str2num(B{1, 2})
end


[~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);

clear temp data* y* x* idx* beta* empty* participant_event participantID channel id_to_drop to_include EEG B file s ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY fileEEGData
close all
for s=1:length(listTFData)
    participantID = listTFData(s).participant;
    if participantID ~= 33
    channel = listTFData(s).channel;
    participant_event = events{participantID};
    temp = load([pathTFData listTFData(s).name]);
    
    if settings.absolutePower == 1
    data = abs(temp.tfdata);
    end
    if settings.phase == 1
    temp2 = temp.tfdata(:,:, :); % phase at point 0
    data2 = sin(angle(temp2));
    end
    x = participant_event;
%     x = rmfield(x, 'type');
%     x = rmfield(x, 'latency');
%     x = rmfield(x, 'urevent');
%     x = rmfield(x, 'epoch');
%     x = rmfield(x, 'stimulus');
    x = rmfield(x, {'task_order','version','timing_beh','timing_eeg','latency', ...
        'urevent', 'stimulus', 'identification', 'trial', 'pair', 'timing', ...
        'thisIndex', 'globalTime', 'fixation_dur', 'stimulation_dur', ...
        'post_fixation', 'opacity', 'trigger', 'pasResponse_pressKey', 'image', ...
        'stimulus_duration_ms', 'stimulus_duration_frames', 'mask_duration_frames', ...
        'pair1', 'ID', 'frameRate', 'corrected_id', 'locationResponse_pressKey', ...
        'locationResponse_releaseRT', 'pasResponse_releaseRT', 'displayed_object', ...
        'displayed_background', 'epoch', 'type',});



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
% 
%     x = rmfield(x, 'identification');
%     x = rmfield(x, 'version');
%     x = rmfield(x, 'task_order');
%     x = rmfield(x, 'participant');
%     x = rmfield(x, 'trial');


%     empty_event = cellfun(@isempty, struct2cell(x));
%     empty_events(s) = sum(sum(empty_event));

%     if sum(sum(empty_event)) > 0
%         empty_event = squeeze(empty_event)';
%         [empty_event_r, empty_event_c] = find(empty_event==1);
%         %         if length(unique(empty_event_r)) == 1
%         %             x([unique(empty_event_r)]).pas = 1;
%         %             x([unique(empty_event_r)]).detection2 = 0;
%         %             x([unique(empty_event_r)]).identification2 = 0;
%         %
%         %         end
%         id_to_drop = unique(empty_event_r)
%     else
%         id_to_drop = [];
%     end
% 
%     x([id_to_drop]) = [];

    idx_tt_object = [x.task_type] == 1;
    idx_tt_background = [x.task_type] == 0;

    x_tt_object = x(idx_tt_object);
    x_tt_background = x(idx_tt_background);

    if settings.absolutePower == 1
    data_tt_object = data(:,:,idx_tt_object);
    data_tt_background = data(:,:,idx_tt_background);
    end
    if settings.phase == 1
    data2_tt_object = data2(:,:,idx_tt_object);
    data2_tt_background = data2(:,:,idx_tt_background);
    end

    x_tt_object = rmfield(x_tt_object, 'task_type');
    x_tt_background = rmfield(x_tt_background, 'task_type');

    x_tt_object = single(transpose(cell2mat(squeeze(struct2cell(x_tt_object)))));
    x_tt_background = single(transpose(cell2mat(squeeze(struct2cell(x_tt_background)))));





    if settings.intercept == 1

        addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'

        x_standarized_object = ones(length(x_tt_object), 1); % intercept
        x_standarized_object(:, 2) = zscore(x_tt_object(:, 5)); % PAS
        x_standarized_object(:, 3) = zscore(x_tt_object(:, 8)); % identifiction / accuracy
        x_standarized_object(:, 4) = zscore(x_tt_object(:, 1)); % object animal / object
        x_standarized_object(:, 5) = zscore(x_tt_object(:, 3)); % background artificial / natural
        x_standarized_object(:, 6) = zscore(x_tt_object(:, 2)); % duration
        x_standarized_object(:, 7) = zscore(x_tt_object(:, 4)); % congruency
        x_standarized_object(:, 8) = x_standarized_object(:, 2) .* x_standarized_object(:, 6); % PAS x DURATION
        x_standarized_object(:, 9) = x_standarized_object(:, 3) .* x_standarized_object(:, 6); % ID x DURATION
        x_standarized_object(:, 10) = x_standarized_object(:, 2) .* x_standarized_object(:, 3); % ID x pas
        x_standarized_object(:, 11) = zscore(x_tt_object(:, 6)) ; % obj/bgr response RT
        x_standarized_object(:, 12) = zscore(x_tt_object(:, 7)) ; % pas response RT


        x_standarized_background = ones(length(x_tt_background), 1); % intercept
        x_standarized_background(:, 2) = zscore(x_tt_background(:, 5)); % PAS
        x_standarized_background(:, 3) = zscore(x_tt_background(:, 8)); % identifiction / accuracy
        x_standarized_background(:, 4) = zscore(x_tt_background(:, 1)); % object animal / object
        x_standarized_background(:, 5) = zscore(x_tt_background(:, 3)); % background artificial / natural
        x_standarized_background(:, 6) = zscore(x_tt_background(:, 2)); % duration
        x_standarized_background(:, 7) = zscore(x_tt_background(:, 4)); % congruency
        x_standarized_background(:, 8) = x_standarized_background(:, 2) .* x_standarized_background(:, 6); % PAS x DURATION
        x_standarized_background(:, 9) = x_standarized_background(:, 3) .* x_standarized_background(:, 6); % ID x DURATION
        x_standarized_background(:, 10) = x_standarized_background(:, 2) .* x_standarized_background(:, 3); % ID x pas
        x_standarized_background(:, 11) = zscore(x_tt_background(:, 6)); % obj/bgr response RT
        x_standarized_background(:, 12) = zscore(x_tt_background(:, 7)); % pas response RT



        for (k=1:length(settings.times))
            for(j=1:length(settings.freqs))
                clear y* ;

                    if settings.absolutePower == 1
                        y_object = squeeze(data_tt_object(j,k,:));
                        y_background = squeeze(data_tt_background(j,k,:));
                        y_standarized_object = zscore(y_object);
                        y_standarized_background = zscore(y_background);
                    end
                    if settings.phase == 1
                        y2_object = squeeze(data2_tt_object(j,k,:));
                        y2_background = squeeze(data2_tt_background(j,k,:));
                        y2_standarized_object = zscore(y2_object);
                        y2_standarized_background = zscore(y2_background);
                    end

                %beta= mvregress( x_standarized,y_standarized); % mvregress(X, Y)
                if settings.inverted == 0
                    if settings.absolutePower == 1
                        beta_object= x_standarized_object\y_standarized_object; % mvregress(X, Y)
                        beta_background = x_standarized_background\y_standarized_background;
                    end
                    if settings.phase == 1
                        beta_phase_object= x_standarized_object\y2_standarized_object; % mvregress(X, Y)
                        beta_phase_background = x_standarized_background\y2_standarized_background;
                    end
                elseif settings.inverted == 1
                    if settings.absolutePower == 1
                        beta_object= y_standarized_object\x_standarized_object; % mvregress(X, Y)
                        beta_background= y_standarized_background\x_standarized_background; % mvregress(X, Y)
    
                        % betas needs to be transposed
                        beta_object = beta_object';
                        beta_background = beta_background';
                    end
                    if settings.phase == 1
                        beta_phase_object= y2_standarized_object\x_standarized_object; % mvregress(X, Y)
                        beta_phase_background= y2_standarized_background\x_standarized_background; % mvregress(X, Y)
    
                        % betas needs to be transposed
                        beta_phase_object = beta_phase_object';
                        beta_phase_background = beta_phase_background';
                    end
                   
                end
                if settings.absolutePower == 1
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
                    beta_background_taskRT(j,k) = beta_background(11,1);
                    beta_background_pasRT(j,k) = beta_background(12,1);

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
                    beta_object_taskRT(j,k) = beta_object(11,1);
                    beta_object_pasRT(j,k) = beta_object(12,1);
                end
                if settings.phase == 1
                    beta_phase_phase_background_intercept(j,k) = beta_phase_background(1,1);
                    beta_phase_background_pas(j,k) = beta_phase_background(2,1);
                    beta_phase_background_identification(j,k) = beta_phase_background(3,1);
                    beta_phase_background_object(j,k) = beta_phase_background(4,1);
                    beta_phase_background_background(j,k) = beta_phase_background(5,1);
                    beta_phase_background_duration(j,k) = beta_phase_background(6,1);
                    beta_phase_background_congruency(j,k) = beta_phase_background(7,1);
                    beta_phase_background_PASxDUR(j,k) = beta_phase_background(8,1);
                    beta_phase_background_IDxDUR(j,k) = beta_phase_background(9,1);
                    beta_phase_background_PASxID(j,k) = beta_phase_background(10,1);
                    beta_phase_background_taskRT(j,k) = beta_phase_background(11,1);
                    beta_phase_background_pasRT(j,k) = beta_phase_background(12,1);

                    beta_phase_object_intercept(j,k) = beta_phase_object(1,1);
                    beta_phase_object_pas(j,k) = beta_phase_object(2,1);
                    beta_phase_object_identification(j,k) = beta_phase_object(3,1);
                    beta_phase_object_object(j,k) = beta_phase_object(4,1);
                    beta_phase_object_background(j,k) = beta_phase_object(5,1);
                    beta_phase_object_duration(j,k) = beta_phase_object(6,1);
                    beta_phase_object_congruency(j,k) = beta_phase_object(7,1);
                    beta_phase_object_PASxDUR(j,k) = beta_phase_object(8,1);
                    beta_phase_object_IDxDUR(j,k) = beta_phase_object(9,1);
                    beta_phase_object_PASxID(j,k) = beta_phase_object(10,1);
                    beta_phase_object_taskRT(j,k) = beta_phase_object(11,1);
                    beta_phase_object_pasRT(j,k) = beta_phase_object(12,1);

                end
            end
        end
        display(['procesuję: ' num2str(s) ' z ' num2str(length(listTFData)) ]);

        if settings.absolutePower == 1
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
            save([pathBETAS num2str(participantID) '_Betas_background_taskRT_chann_' num2str(channel)], 'beta_background_taskRT');
            save([pathBETAS num2str(participantID) '_Betas_background_pasRT_chann_' num2str(channel)], 'beta_background_pasRT');

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
            save([pathBETAS num2str(participantID) '_Betas_object_taskRT_chann_' num2str(channel)], 'beta_object_taskRT');
            save([pathBETAS num2str(participantID) '_Betas_object_pasRT_chann_' num2str(channel)], 'beta_object_pasRT');
        end
        if settings.phase == 1
            save([pathBETAS_phase num2str(participantID) '_Betas_background_intercept_chann_' num2str(channel)], 'beta_phase_background_intercept');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_pas_chann_' num2str(channel)], 'beta_phase_background_pas');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_identification_chann_' num2str(channel)], 'beta_phase_background_identification');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_object_chann_' num2str(channel)], 'beta_phase_background_object');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_background_chann_' num2str(channel)], 'beta_phase_background_background');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_duration_chann_' num2str(channel)], 'beta_phase_background_duration');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_congruency_chann_' num2str(channel)], 'beta_phase_background_congruency');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_PASxDUR_chann_' num2str(channel)], 'beta_phase_background_PASxDUR');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_IDxDUR_chann_' num2str(channel)], 'beta_phase_background_IDxDUR');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_PASxID_chann_' num2str(channel)], 'beta_phase_background_PASxID');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_taskRT_chann_' num2str(channel)], 'beta_phase_background_taskRT');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_pasRT_chann_' num2str(channel)], 'beta_phase_background_pasRT');

            save([pathBETAS_phase num2str(participantID) '_Betas_object_intercept_chann_' num2str(channel)], 'beta_phase_object_intercept');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_pas_chann_' num2str(channel)], 'beta_phase_object_pas');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_identification_chann_' num2str(channel)], 'beta_phase_object_identification');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_object_chann_' num2str(channel)], 'beta_phase_object_object');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_background_chann_' num2str(channel)], 'beta_phase_object_background');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_duration_chann_' num2str(channel)], 'beta_phase_object_duration');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_congruency_chann_' num2str(channel)], 'beta_phase_object_congruency');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_PASxDUR_chann_' num2str(channel)], 'beta_phase_object_PASxDUR');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_IDxDUR_chann_' num2str(channel)], 'beta_phase_object_IDxDUR');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_PASxID_chann_' num2str(channel)], 'beta_phase_object_PASxID');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_taskRT_chann_' num2str(channel)], 'beta_phase_object_taskRT');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_pasRTchann_' num2str(channel)], 'beta_phase_object_pasRT');
        end

    elseif settings.intercept == 0

        addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'

%         x_standarized_object(:, 1) = zscore(x_tt_object(:, 5)); % PAS
%         x_standarized_object(:, 2) = zscore(x_tt_object(:, 8)); % identifiction / accuracy
%         x_standarized_object(:, 3) = zscore(x_tt_object(:, 1)); % object animal / object
%         x_standarized_object(:, 4) = zscore(x_tt_object(:, 3)); % background artificial / natural
%         x_standarized_object(:, 5) = zscore(x_tt_object(:, 2)); % duration
%         x_standarized_object(:, 6) = zscore(x_tt_object(:, 4)); % congruency
%         x_standarized_object(:, 7) = x_standarized_object(:, 1) .* x_standarized_object(:, 5); % PAS x DURATION
%         x_standarized_object(:, 8) = x_standarized_object(:, 2) .* x_standarized_object(:, 5); % ID x DURATION
%         x_standarized_object(:, 9) = x_standarized_object(:, 1) .* x_standarized_object(:, 2); % ID x pas
%         x_standarized_object(:, 10) = zscore(x_tt_object(:, 6)) ; % obj/bgr response RT
%         x_standarized_object(:, 11) = zscore(x_tt_object(:, 7)) ; % pas response RT
% 
% 
%         x_standarized_background(:, 1) = zscore(x_tt_background(:, 5)); % PAS
%         x_standarized_background(:, 2) = zscore(x_tt_background(:, 8)); % identifiction / accuracy
%         x_standarized_background(:, 3) = zscore(x_tt_background(:, 1)); % object animal / object
%         x_standarized_background(:, 4) = zscore(x_tt_background(:, 3)); % background artificial / natural
%         x_standarized_background(:, 5) = zscore(x_tt_background(:, 2)); % duration
%         x_standarized_background(:, 6) = zscore(x_tt_background(:, 4)); % congruency
%         x_standarized_background(:, 7) = x_standarized_background(:, 1) .* x_standarized_background(:, 5); % PAS x DURATION
%         x_standarized_background(:, 8) = x_standarized_background(:, 2) .* x_standarized_background(:, 5); % ID x DURATION
%         x_standarized_background(:, 9) = x_standarized_background(:, 1) .* x_standarized_background(:, 2); % ID x pas
%         x_standarized_background(:, 10) = zscore(x_tt_background(:, 6)) ; % obj/bgr response RT
%         x_standarized_background(:, 11) = zscore(x_tt_background(:, 7)) ; % pas response RT
        x_standarized_object(:, 1) = (x_tt_object(:, 5)); % PAS
        x_standarized_object(:, 2) = (x_tt_object(:, 8)); % identifiction / accuracy
        x_standarized_object(:, 3) = (x_tt_object(:, 1)); % object animal / object
        x_standarized_object(:, 4) = (x_tt_object(:, 3)); % background artificial / natural
        x_standarized_object(:, 5) = (x_tt_object(:, 2)); % duration
        x_standarized_object(:, 6) = (x_tt_object(:, 4)); % congruency
        x_standarized_object(:, 7) = x_standarized_object(:, 1) .* x_standarized_object(:, 5); % PAS x DURATION
        x_standarized_object(:, 8) = x_standarized_object(:, 2) .* x_standarized_object(:, 5); % ID x DURATION
        x_standarized_object(:, 9) = x_standarized_object(:, 1) .* x_standarized_object(:, 2); % ID x pas
        x_standarized_object(:, 10) = (x_tt_object(:, 6)) ; % obj/bgr response RT
        x_standarized_object(:, 11) = (x_tt_object(:, 7)) ; % pas response RT


        x_standarized_background(:, 1) = (x_tt_background(:, 5)); % PAS
        x_standarized_background(:, 2) = (x_tt_background(:, 8)); % identifiction / accuracy
        x_standarized_background(:, 3) = (x_tt_background(:, 1)); % object animal / object
        x_standarized_background(:, 4) = (x_tt_background(:, 3)); % background artificial / natural
        x_standarized_background(:, 5) = (x_tt_background(:, 2)); % duration
        x_standarized_background(:, 6) = (x_tt_background(:, 4)); % congruency
        x_standarized_background(:, 7) = x_standarized_background(:, 1) .* x_standarized_background(:, 5); % PAS x DURATION
        x_standarized_background(:, 8) = x_standarized_background(:, 2) .* x_standarized_background(:, 5); % ID x DURATION
        x_standarized_background(:, 9) = x_standarized_background(:, 1) .* x_standarized_background(:, 2); % ID x pas
        x_standarized_background(:, 10) = (x_tt_background(:, 6)) ; % obj/bgr response RT
        x_standarized_background(:, 11) = (x_tt_background(:, 7)) ; % pas response RT


        for (k=1:length(settings.times))
            for(j=1:length(settings.freqs))
                clear y* ;

                    if settings.absolutePower == 1
                        y_object = squeeze(data_tt_object(j,k,:));
                        y_background = squeeze(data_tt_background(j,k,:));
                        y_standarized_object = zscore(y_object);
                        y_standarized_background = zscore(y_background);
                    end
                    if settings.phase == 1
                        y2_object = squeeze(data2_tt_object(j,k,:));
                        y2_background = squeeze(data2_tt_background(j,k,:));
                        y2_standarized_object = zscore(y2_object);
                        y2_standarized_background = zscore(y2_background);
                    end

                %beta= mvregress( x_standarized,y_standarized); % mvregress(X, Y)
                if settings.inverted == 0
                    if settings.absolutePower == 1
                        beta_object= x_standarized_object\y_standarized_object; % mvregress(X, Y)
                        beta_background = x_standarized_background\y_standarized_background;
                    end
                    if settings.phase == 1
                        beta_phase_object= x_standarized_object\y2_standarized_object; % mvregress(X, Y)
                        beta_phase_background = x_standarized_background\y2_standarized_background;
                    end
                elseif settings.inverted == 1
                    if settings.absolutePower == 1
                        beta_object= y_standarized_object\x_standarized_object; % mvregress(X, Y)
                        beta_background= y_standarized_background\x_standarized_background; % mvregress(X, Y)
    
                        % betas needs to be transposed
                        beta_object = beta_object';
                        beta_background = beta_background';
                    end
                    if settings.phase == 1
                        beta_phase_object= y2_standarized_object\x_standarized_object; % mvregress(X, Y)
                        beta_phase_background= y2_standarized_background\x_standarized_background; % mvregress(X, Y)
    
                        % betas needs to be transposed
                        beta_phase_object = beta_phase_object';
                        beta_phase_background = beta_phase_background';
                    end
                   
                end

                if settings.absolutePower == 1
                    beta_background_pas(j,k) = beta_background(1,1);
                    beta_background_identification(j,k) = beta_background(2,1);
                    beta_background_object(j,k) = beta_background(3,1);
                    beta_background_background(j,k) = beta_background(4,1);
                    beta_background_duration(j,k) = beta_background(5,1);
                    beta_background_congruency(j,k) = beta_background(6,1);
                    beta_background_PASxDUR(j,k) = beta_background(7,1);
                    beta_background_IDxDUR(j,k) = beta_background(8,1);
                    beta_background_PASxID(j,k) = beta_background(9,1);
                    beta_background_taskRT(j,k) = beta_background(10,1);
                    beta_background_pasRT(j,k) = beta_background(11,1);

                    beta_object_pas(j,k) = beta_object(1,1);
                    beta_object_identification(j,k) = beta_object(2,1);
                    beta_object_object(j,k) = beta_object(3,1);
                    beta_object_background(j,k) = beta_object(4,1);
                    beta_object_duration(j,k) = beta_object(5,1);
                    beta_object_congruency(j,k) = beta_object(6,1);
                    beta_object_PASxDUR(j,k) = beta_object(7,1);
                    beta_object_IDxDUR(j,k) = beta_object(8,1);
                    beta_object_PASxID(j,k) = beta_object(9,1);
                    beta_object_taskRT(j,k) = beta_object(10,1);
                    beta_object_pasRT(j,k) = beta_object(11,1);
                end
                if settings.phase == 1
                    beta_phase_background_pas(j,k) = beta_phase_background(1,1);
                    beta_phase_background_identification(j,k) = beta_phase_background(2,1);
                    beta_phase_background_object(j,k) = beta_phase_background(3,1);
                    beta_phase_background_background(j,k) = beta_phase_background(4,1);
                    beta_phase_background_duration(j,k) = beta_phase_background(5,1);
                    beta_phase_background_congruency(j,k) = beta_phase_background(6,1);
                    beta_phase_background_PASxDUR(j,k) = beta_phase_background(7,1);
                    beta_phase_background_IDxDUR(j,k) = beta_phase_background(8,1);
                    beta_phase_background_PASxID(j,k) = beta_phase_background(9,1);
                    beta_phase_background_taskRT(j,k) = beta_phase_background(10,1);
                    beta_phase_background_pasRT(j,k) = beta_phase_background(11,1);

                    beta_phase_object_pas(j,k) = beta_phase_object(1,1);
                    beta_phase_object_identification(j,k) = beta_phase_object(2,1);
                    beta_phase_object_object(j,k) = beta_phase_object(3,1);
                    beta_phase_object_background(j,k) = beta_phase_object(4,1);
                    beta_phase_object_duration(j,k) = beta_phase_object(5,1);
                    beta_phase_object_congruency(j,k) = beta_phase_object(6,1);
                    beta_phase_object_PASxDUR(j,k) = beta_phase_object(7,1);
                    beta_phase_object_IDxDUR(j,k) = beta_phase_object(8,1);
                    beta_phase_object_PASxID(j,k) = beta_phase_object(9,1);
                    beta_phase_object_taskRT(j,k) = beta_phase_object(10,1);
                    beta_phase_object_pasRT(j,k) = beta_phase_object(11,1);
                end
            end
        end
        display(['procesuję: ' num2str(s) ' z ' num2str(length(listTFData)) ]);

        if settings.absolutePower == 1
            save([pathBETAS num2str(participantID) '_Betas_background_pas_chann_' num2str(channel)], 'beta_background_pas');
            save([pathBETAS num2str(participantID) '_Betas_background_identification_chann_' num2str(channel)], 'beta_background_identification');
            save([pathBETAS num2str(participantID) '_Betas_background_object_chann_' num2str(channel)], 'beta_background_object');
            save([pathBETAS num2str(participantID) '_Betas_background_background_chann_' num2str(channel)], 'beta_background_background');
            save([pathBETAS num2str(participantID) '_Betas_background_duration_chann_' num2str(channel)], 'beta_background_duration');
            save([pathBETAS num2str(participantID) '_Betas_background_congruency_chann_' num2str(channel)], 'beta_background_congruency');
            save([pathBETAS num2str(participantID) '_Betas_background_PASxDUR_chann_' num2str(channel)], 'beta_background_PASxDUR');
            save([pathBETAS num2str(participantID) '_Betas_background_IDxDUR_chann_' num2str(channel)], 'beta_background_IDxDUR');
            save([pathBETAS num2str(participantID) '_Betas_background_PASxID_chann_' num2str(channel)], 'beta_background_PASxID');
            save([pathBETAS num2str(participantID) '_Betas_background_taskRT_chann_' num2str(channel)], 'beta_background_taskRT');
            save([pathBETAS num2str(participantID) '_Betas_background_pasRT_chann_' num2str(channel)], 'beta_background_pasRT');

            save([pathBETAS num2str(participantID) '_Betas_object_pas_chann_' num2str(channel)], 'beta_object_pas');
            save([pathBETAS num2str(participantID) '_Betas_object_identification_chann_' num2str(channel)], 'beta_object_identification');
            save([pathBETAS num2str(participantID) '_Betas_object_object_chann_' num2str(channel)], 'beta_object_object');
            save([pathBETAS num2str(participantID) '_Betas_object_background_chann_' num2str(channel)], 'beta_object_background');
            save([pathBETAS num2str(participantID) '_Betas_object_duration_chann_' num2str(channel)], 'beta_object_duration');
            save([pathBETAS num2str(participantID) '_Betas_object_congruency_chann_' num2str(channel)], 'beta_object_congruency');
            save([pathBETAS num2str(participantID) '_Betas_object_PASxDUR_chann_' num2str(channel)], 'beta_object_PASxDUR');
            save([pathBETAS num2str(participantID) '_Betas_object_IDxDUR_chann_' num2str(channel)], 'beta_object_IDxDUR');
            save([pathBETAS num2str(participantID) '_Betas_object_PASxID_chann_' num2str(channel)], 'beta_object_PASxID');
            save([pathBETAS num2str(participantID) '_Betas_object_taskRT_chann_' num2str(channel)], 'beta_object_taskRT');
            save([pathBETAS num2str(participantID) '_Betas_object_pasRT_chann_' num2str(channel)], 'beta_object_pasRT');
        end
        if settings.phase == 1
            save([pathBETAS_phase num2str(participantID) '_Betas_background_pas_chann_' num2str(channel)], 'beta_phase_background_pas');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_identification_chann_' num2str(channel)], 'beta_phase_background_identification');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_object_chann_' num2str(channel)], 'beta_phase_background_object');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_background_chann_' num2str(channel)], 'beta_phase_background_background');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_duration_chann_' num2str(channel)], 'beta_phase_background_duration');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_congruency_chann_' num2str(channel)], 'beta_phase_background_congruency');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_PASxDUR_chann_' num2str(channel)], 'beta_phase_background_PASxDUR');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_IDxDUR_chann_' num2str(channel)], 'beta_phase_background_IDxDUR');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_PASxID_chann_' num2str(channel)], 'beta_phase_background_PASxID');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_taskRT_chann_' num2str(channel)], 'beta_phase_background_taskRT');
            save([pathBETAS_phase num2str(participantID) '_Betas_background_pasRT_chann_' num2str(channel)], 'beta_phase_background_pasRT');

            save([pathBETAS_phase num2str(participantID) '_Betas_object_pas_chann_' num2str(channel)], 'beta_phase_object_pas');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_identification_chann_' num2str(channel)], 'beta_phase_object_identification');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_object_chann_' num2str(channel)], 'beta_phase_object_object');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_background_chann_' num2str(channel)], 'beta_phase_object_background');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_duration_chann_' num2str(channel)], 'beta_phase_object_duration');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_congruency_chann_' num2str(channel)], 'beta_phase_object_congruency');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_PASxDUR_chann_' num2str(channel)], 'beta_phase_object_PASxDUR');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_IDxDUR_chann_' num2str(channel)], 'beta_phase_object_IDxDUR');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_PASxID_chann_' num2str(channel)], 'beta_phase_object_PASxID');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_taskRT_chann_' num2str(channel)], 'beta_phase_object_taskRT');
            save([pathBETAS_phase num2str(participantID) '_Betas_object_pasRTchann_' num2str(channel)], 'beta_phase_object_pasRT');
        end
    clear temp data* y* x* idx* beta* empty* participant_event participantID channel id_to_drop to_include

    end
    end
end

