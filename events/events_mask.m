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

        for i=1:length(EEG.event)
            if strcmp(EEG.event(i).type, 'boundary')
                idx(i) = 1;
            else
                idx(i) = 0;
            end
            if strcmp(class(EEG.event(i).type), 'char')
                EEG.event(i).type = str2num(EEG.event(i).type);
            end
        end
        EEG.event(idx==1) = []
        clear idx;
        for i=1:length(EEG.event)
           

                
                if i>1 & EEG.event(i-1).type == 10 & i+1 <= length(EEG.event)
                    EEG.event(i).stimulus = EEG.event(i).type
                    EEG.event(i).identification = EEG.event(i+1).type
                    EEG.event(i).detection = []
                    if EEG.event(i).identification == EEG.event(i).stimulus
                        EEG.event(i).corr_corr = 1;
                    else
                        EEG.event(i).corr_corr = 0;
                    end
                end


                if i>1 & EEG.event(i-1).type == 10 & i+4 <= length(EEG.event)
                    if EEG.event(i+1).type > 0 & EEG.event(i+1).type < 5
                        EEG.event(i).pas = EEG.event(i+1).type;
                    end
                    if EEG.event(i+2).type > 0 & EEG.event(i+2).type < 5
                        EEG.event(i).pas = EEG.event(i+2).type;
                    end
                    if EEG.event(i+3).type > 0 & EEG.event(i+3).type < 5
                        EEG.event(i).pas = EEG.event(i+3).type;
                    end
                    if EEG.event(i+4).type > 0 & EEG.event(i+4).type < 5
                        EEG.event(i).pas = EEG.event(i+4).type;
                    end


                end
             
        end
        
        for i=1:length(EEG.event)

            if isempty(EEG.event(i).stimulus) | isempty(EEG.event(i).pas)
                idx(i) = 1;
            else
                idx(i) = 0;
            end
        end
        EEG.event(idx ==1) = [];
        EEG.event = rmfield(EEG.event, 'detection');




end