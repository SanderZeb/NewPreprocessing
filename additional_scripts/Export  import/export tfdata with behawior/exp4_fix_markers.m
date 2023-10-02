
load('D:\Drive\4 - Faces\events_new2.mat')
events_new4 = [];
for i = 1:length(events_new2)
if all(i~=[61 62 63 82])
    curr_events = events_new2{1, i};
    
    if (contains(curr_events(1).stimFile, 'FE') & curr_events(1).type == 103) || (contains(curr_events(1).stimFile, 'NE') & curr_events(1).type == 104)
        version = 1;
    elseif (contains(curr_events(1).stimFile, 'FE') & curr_events(1).type == 104) || (contains(curr_events(1).stimFile, 'NE') & curr_events(1).type == 103)
        version = 3;
    end

    for e=1:length(curr_events)
        if version == 1
            curr_events(e).version = 1;
        elseif version == 3
            curr_events(e).version = 3;
            if curr_events(e).type == 103
                curr_events(e).type = 104;
            elseif curr_events(e).type == 104
                curr_events(e).type = 103;
            end
%             if curr_events(e).accuracy == 1
%                 curr_events(e).accuracy = 0;
%             elseif curr_events(e).accuracy == 0
%                 curr_events(e).accuracy = 1;
%             end
        end

        if curr_events(e).type == 104 & (curr_events(e).orientation
            curr_events(e).accuracy_new = 1;
        else
            curr_events(e).accuracy_new = 0;
        end

    end
    events_new4{1, i} = curr_events;
else
    events_new4{1, i} = 0;
end

end