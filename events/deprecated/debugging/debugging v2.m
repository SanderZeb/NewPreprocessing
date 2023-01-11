root = 'D:\Drive\5 - Scenes\';
load([root 'events.mat'])
for i = 1:length(events)

    curr_events = events{1,i};

    for n = 1:length(curr_events)
        if strcmp(curr_events(n).task_type, 'object')
            if strcmp(curr_events(n).object, 'object')
                if curr_events(n).identification == 41
                    curr_events(n).corrected_id = 1;
                elseif curr_events(n).identification == 46
                    curr_events(n).corrected_id = 0;
                end
            elseif strcmp(curr_events(n).object, 'animal')
                if curr_events(n).identification == 41
                    curr_events(n).corrected_id = 0;
                elseif curr_events(n).identification == 46
                    curr_events(n).corrected_id = 1;
                end
            end
        elseif strcmp(curr_events(n).task_type, 'background')
            if strcmp(curr_events(n).background, 'artificial')
                if curr_events(n).identification == 41
                    curr_events(n).corrected_id = 1;
                elseif curr_events(n).identification == 46
                    curr_events(n).corrected_id = 0;
                end
            elseif strcmp(curr_events(n).background, 'natural')
                if curr_events(n).identification == 41
                    curr_events(n).corrected_id = 0;
                elseif curr_events(n).identification == 46
                    curr_events(n).corrected_id = 1;
                end
            end
        end
    end
    events{1,i} = curr_events;
    clear curr_events
end

temp_all = []
for i = 1:length(events2)
    if i ~=34 | i~= 51
        curr_events = events2{1,i};

        for n = 1:length(curr_events)
            tempev(n,1) = curr_events(n).corrected_id - curr_events(n).corrected_id;
            tempev(n,2) = i;
            tempev(n,3) = n;
        end
        temp_all = cat(1,temp_all, tempev);
        clear tempev curr_events
    end
end
length(unique(temp_all(find(temp_all(:,1) ~=0), 2)))