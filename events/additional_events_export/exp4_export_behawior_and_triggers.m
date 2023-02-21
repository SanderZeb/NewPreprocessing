load('D:\Drive\4 - Faces\events_new.mat')

events = events_new;
for i = 1:size(events,2)
    if ~any(i==[82 61 62 63])
        if strcmp(events{1, i}.VarName41(1), "60")
            %events{1, 8} = removevars(events{1, 8}, "name");
            events{1, i}.Properties.VariableNames(26) = "error";
            events{1, i}.Properties.VariableNames(27) = "globalTime";
            events{1, i}.Properties.VariableNames(28) = "fixation_dur";
            events{1, i}.Properties.VariableNames(29) = "stimulation_dur";
            events{1, i}.Properties.VariableNames(30) = "post_fixation";
            events{1, i}.Properties.VariableNames(31) = "opacity";
            events{1, i}.Properties.VariableNames(32) = "orientationResponse_pressKey";
            events{1, i}.Properties.VariableNames(33) = "orientationResponse_pressRT";
            events{1, i}.Properties.VariableNames(34) = "orientationResponse_releaseRT";
            events{1, i}.Properties.VariableNames(35) = "pasResponse_pressKey";
            events{1, i}.Properties.VariableNames(36) = "pasResponse_pressRT";
            events{1, i}.Properties.VariableNames(37) = "pasResponse_releaseRT";
            events{1, i}.Properties.VariableNames(38) = "image";
            events{1, i}.Properties.VariableNames(39) = "mask";
            events{1, i}.Properties.VariableNames(40) = "orientation1";
            events{1, i}.Properties.VariableNames(41) = "response";
            events{1, i}.Properties.VariableNames(42) = "finalOpacity";
            events{1, i}.Properties.VariableNames(43) = "postOri";
            events{1, i}.Properties.VariableNames(44) = "ID";
            events{1, i}.Properties.VariableNames(45) = "frameRate";
            events{1, i} = removevars(events{1, i}, "error");
            events{1, i}.Var45(1,1) = "";
            events{1, i}.Properties.VariableNames(45) = "VarName41";

            display(i);
        end
    end

end
events_new = events;

for n = 1:length(events_new)
    current = [];
    if isempty(events_new{1, n})
        events_new2{n} = [];
    else
        current = events_new{1, n};
        for i = 1:size(current, 1)
            if current.x(i) == 1
                current.sex(i) = 1; % female
            elseif current.x(i) == 2
                current.sex(i) = 2; % male
            end

            if current.orientation(i) == -45
                current.stim(i) = 103; % fearful
            elseif current.orientation(i) == 45
                current.stim(i) = 104; % neutral
            end
            if current.orientation1(i) == -45
                current.possibleresp(i) = 103; % fearful
            elseif current.orientation1(i) == 45
                current.possibleresp(i) = 104; % neutral
            end

            if current.orientationResponse_pressKey(i) == 3
                current.stim_resp_angles(i) = -45;
                current.stim_resp(i) = 103;
            elseif current.orientationResponse_pressKey(i) == 4
                current.stim_resp_angles(i) = 45;
                current.stim_resp(i) = 104;
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

save('D:\Drive\4 - Faces\events_new2.mat', 'events_new2')