function EEG = events_Kinga(EEG)

for(n=1: length(EEG.event))
    EEG.event(n).type = EEG.event(n).type - 65280;
end

EEG.event(1).PAS = [];
EEG.event(1).RESP = [];
EEG.event(1).trialType= [];
EEG.event(1).stair= [];
EEG.event(1).epoch = [];

% marking staircase trials
stair_idx = [EEG.event.type] == 206;
if sum(stair_idx) == 1
    i = 1;
    while stair_idx(i) ~=1
        stair_idx(i) = 1;
        i=i+1;
    end
end
clear i

markers = [0 1 2 4 10 30 33 40 44 55 200 202 203 204 205 206 207 208 209]; % triggers that should be in the EEG event file
bad_idx = ~ismember([EEG.event.type], markers); % search for triggers not corresponding to the selected ones

if sum(bad_idx) > 0
    display(['found ' sum(bad_idx) ' triggers.'])
    pause;
end
    

counter = 1;
for(n=1: length(EEG.event))
    if EEG.event(n).type == 10
        nn = n+1;
        while (EEG.event(nn).type ~= [10 205 209])
            last_element = nn;
            nn = nn+1;
        end
        
        slice = EEG.event(n:last_element);
        
        
        if length(slice) > 3
            id_stim = find(([slice.type] == 33) | ([slice.type] == 44) | ([slice.type] == 55));
            id_pas = find(([slice.type] == 1) | ([slice.type] == 2) | ([slice.type] == 3) | ([slice.type] == 4));
            id_resp = find(([slice.type] == 30) | ([slice.type] == 40));
            slice(id_stim).trialType = slice(id_stim).type;
            slice(id_stim).PAS = slice(id_pas).type;
            slice(id_stim).RESP = slice(id_resp).type;
            slice(id_stim).stair = 0;
            slice(id_stim).epoch = counter;
            counter = counter+1;
        else
            id_stim = find(([slice.type] == 33) | ([slice.type] == 44) | ([slice.type] == 55));
            id_resp = find(([slice.type] == 30) | ([slice.type] == 40));
            slice(id_stim).trialType = slice(id_stim).type;
            slice(id_stim).RESP = slice(id_resp).type;
            slice(id_stim).stair = 1;
            slice(id_stim).epoch = counter;
            counter = counter+1;
        end
        
        if EEG.event(n+1).type == 33 | EEG.event(n+1).type == 44 | EEG.event(n+1).type == 55
            EEG.event(n+1) = slice(id_stim);
        end
        
        
        
    end
end




end