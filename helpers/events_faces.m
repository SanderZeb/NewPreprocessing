function EEG = events_faces(EEG)
for(n=1: length(EEG.event))
    EEG.event(n).type = EEG.event(n).type - 65280;
end

i = 1;
while ( EEG.event(i).type~=206)						%marking staircase values
    EEG.event(i).type = EEG.event(i).type+300;
    i=i+1;
end

EEG.event(1).identification = [];
EEG.event(1).pas = [];
EEG.event(1).identification2 = [];
EEG.event(1).stimulus = [];
try
    for i = 1:length(EEG.event)
        
        EEG.event(i).type = str2num(EEG.event(i).type);
        
    end
    
end

for i=1:length(EEG.event)
    if ((i <= length(EEG.event)) & (EEG.event(i).type == 10) & (100 < EEG.event(i+1).type < 108) )
        
        EEG.event(i+1).stimulus = EEG.event(i+1).type   ;
        EEG.event(i+1).identification = EEG.event(i+2).type;
        if (i+3 <= length(EEG.event)&& 0 < EEG.event(i+3).type && EEG.event(i+3).type < 5)
            EEG.event(i+1).pas = EEG.event(i+3).type   ;
        elseif (i+4 <= length(EEG.event)&& 0 < EEG.event(i+4).type && EEG.event(i+4).type < 5)
            EEG.event(i+1).pas = EEG.event(i+4).type   ;
        elseif (i+5 <= length(EEG.event)&& 0 < EEG.event(i+5).type && EEG.event(i+5).type < 5)
            EEG.event(i+1).pas = EEG.event(i+5).type  ;
        elseif (i+6 <= length(EEG.event)&& 0 < EEG.event(i+6).type && EEG.event(i+6).type < 5)
            EEG.event(i+1).pas = EEG.event(i+6).type  ;
        else
            error(i) = i;
        end
        if (~isempty(EEG.event(i+1).stimulus))
            if (EEG.event(i+1).stimulus == EEG.event(i+1).identification)
                EEG.event(i+1).identification2 = 1;
            else
                EEG.event(i+1).identification2 = 0;
            end
        end
        
        
    else if ((i+1 <= length(EEG.event)) & (100 < EEG.event(i+1).type < 108))
            if isempty(EEG.event(i).stimulus)
                EEG.event(i).type = EEG.event(i).type + 300;
            end
        end
        
    end
end

idx = [EEG.event.type] < 100;
EEG.event(idx) = [];
clear idx;

idx2 = [EEG.event.type] > 110;
EEG.event(idx2) = [];
clear idx2;

idx = [EEG.event.type] < 100;
EEG.event(idx) = [];

clear idx

end