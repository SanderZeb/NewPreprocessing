load('D:\Drive\1 - Threshold\events_new.mat')

for n = 1:length(events_new)
    current = [];
    if isempty(events_new{1, n})
        events_new2{n} = [];
    else
    current = events_new{1, n};
    for i = 1:size(current, 1)
            if current.orientation(i) == -45
                current.ori_stim(i) = 101;
            elseif current.orientation(i) == 45
                current.ori_stim(i) = 107;
            elseif current.orientation(i) == 0
                current.ori_stim(i) = 100;
            elseif current.orientation(i) == 90
                current.ori_stim(i) = 106;
            end
            if current.x(i) > 0 & current.y(i) > 0
                current.loc_stim(i) = 50;
            elseif current.x(i) < 0 & current.y(i) > 0
                current.loc_stim(i) = 20;
            elseif current.x(i) < 0 & current.y(i) < 0
                current.loc_stim(i) = 30;
            elseif current.x(i) > 0 & current.y(i) < 0
                current.loc_stim(i) = 40;
            end
            if current.locationResponse_pressKey(i) == 2
                current.stim_loc_resp(i) = 20;
            elseif current.locationResponse_pressKey(i) == 3
                current.stim_loc_resp(i) = 30;
            elseif current.locationResponse_pressKey(i) == 4
                current.stim_loc_resp(i) = 40;
            elseif current.locationResponse_pressKey(i) == 5
                current.stim_loc_resp(i) = 50;
            end
            if current.orientationResponse_pressKey(i) == 0
                current.stim_ori_resp_angles(i) = 0;
                current.stim_ori_resp(i) = 100;
            elseif current.orientationResponse_pressKey(i) == 1
                current.stim_ori_resp_angles(i) = -45;
                current.stim_ori_resp(i) = 101;
            elseif current.orientationResponse_pressKey(i) == 6
                current.stim_ori_resp_angles(i) = 90;
                current.stim_ori_resp(i) = 106;
            elseif current.orientationResponse_pressKey(i) == 7
                current.stim_ori_resp_angles(i) = 45;
                current.stim_ori_resp(i) = 107;
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
            if current.stim_ori_resp_angles(i) == current.orientation(i)
                current.accuracy(i) = 1;
            elseif current.stim_ori_resp_angles(i) ~= current.orientation(i)
                current.accuracy(i) = 0;
            end

            if current.loc_stim(i) == current.stim_loc_resp(i)
                current.accuracy_location(i) = 1;
            elseif current.loc_stim(i) ~= current.stim_loc_resp(i)
                current.accuracy_location(i) = 0;
            end
            if current.accuracy(i) == 1 & current.accuracy_location(i) == 1
                current.accuracy_corrcorr(i) = 1;
            else
                current.accuracy_corrcorr(i) = 0;
            end

    end
    events_new2{n} = table2struct(current);
    end
end
