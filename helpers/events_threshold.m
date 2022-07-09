function EEG = events_threshold(EEG)

for(n=1: length(EEG.event))
    EEG.event(n).type = EEG.event(n).type - 65280;
end

i = 1
while ( EEG.event(i).type~=206)						%marking staircase values
    EEG.event(i).type = EEG.event(i).type+300
    i=i+1;
end

EEG.event(1).detection = []
EEG.event(1).identification = []
EEG.event(1).pas = []
EEG.event(1).corr_corr = []
EEG.event(1).detection2 = []
EEG.event(1).identification2 = []
for i=1:length(EEG.event)
    if (EEG.event(i).type>108 & EEG.event(i).type < 159)
        EEG.event(i).detection = EEG.event(i+1).type
        if(EEG.event(i+3).type<5)
            EEG.event(i).identification = EEG.event(i+2).type
            EEG.event(i).pas=EEG.event(i+3).type
        elseif (EEG.event(i+4).type<5)
            EEG.event(i).identification = EEG.event(i+3).type
            EEG.event(i).pas=EEG.event(i+4).type
        elseif (EEG.event(i+5).type<5)
            EEG.event(i).identification = EEG.event(i+4).type
            EEG.event(i).pas=EEG.event(i+5).type
        elseif(EEG.event(i+6).type<5)
            EEG.event(i).identification = EEG.event(i+5).type
            EEG.event(i).pas=EEG.event(i+6).type
        end
        if (EEG.event(i).type==(EEG.event(i).detection+EEG.event(i).identification))
            EEG.event(i).corr_corr=1
        else
            EEG.event(i).corr_corr=0
        end
    end
end

for i=1:length(EEG.event)
    if (~isempty(EEG.event(i).detection))
        temp =  (EEG.event(i).type) - EEG.event(i).detection
        temp2 = (EEG.event(i).type) - EEG.event(i).identification
        temp3 = num2str(temp2)
        
        if(temp>=100 & temp <108)
            EEG.event(i).detection2=1
        else
            EEG.event(i).detection2=0
        end
        
        if( str2num(temp3(2))==0)
            EEG.event(i).identification2=1
        else
            EEG.event(i).identification2=0
        end
    end
end


end
