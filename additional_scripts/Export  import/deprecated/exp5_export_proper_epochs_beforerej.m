load('D:\Drive\5 - Scenes\tfdata\exp5_scenes_alpha.mat')

participants = unique([all.participant]);
removedList = dir(['D:\Drive\5 - Scenes\Epoching_EpochRejection\additional_info\*.mat']);
new_alpha = [];

root = 'D:\Drive\5 - Scenes\';
pathEEGData = ['D:\Drive\5 - Scenes\Preprocessed_new_pipeline']
list=dir([pathEEGData '\*.set'  ])

for i = i:length(participants)

if i ~= 34
    participant = participants(i);
    removedFile = removedList(i);

    removedTrials = load([ removedFile.folder '\' removedFile.name]);
    temp_data = all([all.participant] == participant);

    if 599 - length(removedTrials.to_reject) == length(temp_data)

        trials_old = [1:599];

        trials_old(removedTrials.to_reject) = [];
        trials_old = trials_old.';
        for s = 1:length(temp_data)
            temp_data(s).trials_old = trials_old(s);
        end


        for n = 1:length(temp_data)
            if temp_data(n).task_order == 1 % to=1 object first; to=2  background first;
                if strcmp(temp_data(n).task_type, 'object')
                    temp_data(n).trial_order = temp_data(n).trials_old - 300;
                elseif strcmp(temp_data(n).task_type, 'background')
                    temp_data(n).trial_order = temp_data(n).trials_old;
                end
            else
                if strcmp(temp_data(n).task_type, 'object')
                    temp_data(n).trial_order = temp_data(n).trials_old;
                elseif strcmp(temp_data(n).task_type, 'background')
                    temp_data(n).trial_order = temp_data(n).trials_old -300 ;
                end
            end
        end

        for n = 1:length(temp_data)
            temp_data(n).tertile = ceil(temp_data(n).trial_order / 100);
            temp_data(n).tertile2 = ceil(temp_data(n).trials_old / 100);

        end

        new_alpha = cat(2, new_alpha, temp_data);
        clear temp_data trials old
    else
        clear idx
        display(['error! wrong epoch number! ID: ' num2str(i)])
        file=list(i).name;
        EEG = pop_loadset('filename',file,'filepath',pathEEGData);
        for n = 1:length(EEG.event)
            if EEG.event(n).duration == 0
                idx(n) = 1;
            else
                idx(n) = 0;
            end
        end
        EEG.event([idx]==1) = [];
        

        error_rate = 0;
        participant_event = EEG.event;
        participant_event = rmfield(participant_event, {'stimulus', 'trial'});
    
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
            error_rate = error_rate +1;
        else
            id_to_drop = [];
        end
        EEG.event(id_to_drop) = [];
        epochs = length(EEG.event);
        display(['proper amount of epochs: ' num2str(epochs)])
        if epochs - length(removedTrials.to_reject) == length(temp_data)

            trials_old = [1:epochs];

            trials_old(removedTrials.to_reject) = [];
            trials_old = trials_old.';
            for s = 1:length(temp_data)
                temp_data(s).trials_old = trials_old(s);
            end


            for n = 1:length(temp_data)
                if temp_data(n).task_order == 1 % to=1 object first; to=2  background first;
                    if strcmp(temp_data(n).task_type, 'object')
                        temp_data(n).trial_order = temp_data(n).trials_old - 300;
                    elseif strcmp(temp_data(n).task_type, 'background')
                        temp_data(n).trial_order = temp_data(n).trials_old;
                    end
                else
                    if strcmp(temp_data(n).task_type, 'object')
                        temp_data(n).trial_order = temp_data(n).trials_old;
                    elseif strcmp(temp_data(n).task_type, 'background')
                        temp_data(n).trial_order = temp_data(n).trials_old -300 ;
                    end
                end
            end

            for n = 1:length(temp_data)
                temp_data(n).tertile = ceil(temp_data(n).trial_order / 100);
                temp_data(n).tertile2 = ceil(temp_data(n).trials_old / 100);

            end

            new_alpha = cat(2, new_alpha, temp_data);
            clear temp_data trials old idx
        else
            display(['something wrong..... again... id:' num2str(i)])
            break
        end
    end
end
end



pathTFData = [root '\tfdata\']
writetable(struct2table(new_alpha), ['D:\export\corrected_exp5_scenes_alpha.csv'])

save([pathTFData '\corrected_exp5_scenes_alpha.mat'],'new_alpha')

