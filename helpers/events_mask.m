function EEG = events_mask(EEG)

for(n=1: length(EEG.event))
    EEG.event(n).type = EEG.event(n).type - 65280;
end

i = 1;
while ( EEG.event(i).type~=206)						%marking staircase values
    EEG.event(i).type = EEG.event(i).type+300;
    i=i+1;
end

%EEG.event(1).detection = [];
EEG.event(1).identification = [];

EEG.event(1).pas = [];
EEG.event(1).corr_corr = [];
try
    for i = 1:length(EEG.event)
        
        EEG.event(i).type = str2num(EEG.event(i).type);
        
    end
    
end
for i=1:length(EEG.event)
    if ((i+2<=length(EEG.event)) &(EEG.event(i).type>99 & EEG.event(i).type < 108))
        EEG.event(i).detection = EEG.event(i+1).type;
        if((i+3<=length(EEG.event)) &(EEG.event(i+3).type<5))
            EEG.event(i).identification = EEG.event(i+2).type;
            EEG.event(i).pas=EEG.event(i+3).type;
        elseif ((i+4<=length(EEG.event)) & (EEG.event(i+4).type<5))
            EEG.event(i).identification = EEG.event(i+3).type;
            EEG.event(i).pas=EEG.event(i+4).type ;
        elseif ((i+5<=length(EEG.event)) & (EEG.event(i+5).type<5) )
            EEG.event(i).identification = EEG.event(i+4).type;
            EEG.event(i).pas=EEG.event(i+5).type;
        elseif((i+6<=length(EEG.event)) & (EEG.event(i+6).type<5))
            EEG.event(i).identification = EEG.event(i+5).type;
            EEG.event(i).pas=EEG.event(i+6).type;
        end
        if (EEG.event(i).type==(EEG.event(i).detection+EEG.event(i).identification))
            EEG.event(i).corr_corr=1;
        else
            EEG.event(i).corr_corr=0;
        end
    end
end

end