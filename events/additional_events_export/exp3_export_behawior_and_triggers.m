load('D:\Drive\3 - Mask\events_new.mat')

for n = 1:length(events_new)
    current = [];
    if isempty(events_new{1, n})
        events_new2{n} = [];
    else
        current = events_new{1, n};
        for i = 1:size(current, 1)
            if current.orientation(i) == -45
                current.stim(i) = 101;
            elseif current.orientation(i) == 45
                current.stim(i) = 107;
            elseif current.orientation(i) == 0
                current.stim(i) = 100;
            elseif current.orientation(i) == 90
                current.stim(i) = 106;
            end
            if current.orientationResponse_pressKey(i) == 0
                current.stim_resp_angles(i) = 0;
                current.stim_resp(i) = 100;
            elseif current.orientationResponse_pressKey(i) == 1
                current.stim_resp_angles(i) = -45;
                current.stim_resp(i) = 101;
            elseif current.orientationResponse_pressKey(i) == 6
                current.stim_resp_angles(i) = 90;
                current.stim_resp(i) = 106;
            elseif current.orientationResponse_pressKey(i) == 7
                current.stim_resp_angles(i) = 45;
                current.stim_resp(i) = 107;
            end
            if current.pasResponse_pressKey(i) == 0
                current.pas_resp(i) = 1;
            elseif current.pasResponse_pressKey(i) == 1
                current.pas_resp(i) = 2;
            elseif current.pasResponse_pressKey(i) == 6
                current.pas_resp(i) = 3;
            elseif current.pasResponse_pressKey(i) == 7
                current.pas_resp(i) = 4;
            end
            if current.stim_resp(i) == current.stim(i)
                current.accuracy(i) = 1;
            elseif current.stim_resp(i) ~= current.stim(i)
                current.accuracy(i) = 0;
            end
        end
        events_new2{n} = table2struct(current);
    end
end

save('D:\Drive\3 - Mask\events_new2.mat', 'events_new2')