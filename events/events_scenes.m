function EEG = events_scenes(EEG)

for(n=1: length(EEG.event))
    EEG.event(n).type = EEG.event(n).type - 65280;
end

EEG.event(1).object = [];
EEG.event(1).task_type = [];
EEG.event(1).duration = [];
EEG.event(1).background = [];
EEG.event(1).congruency = [];
EEG.event(1).identification = [];
EEG.event(1).pas = [];
EEG.event(1).stimulus = [];
try
    for i = 1:length(EEG.event)
        if i>1 & EEG.event(i-1).type == 10 & any(EEG.event(i).type== [ 20 21 120 121 40 41 140 141 80 81 180 181 30 31 130 131 50 51 150 151 90 91 190 191])
            %% START OF CONTDITIONS
            
            if EEG.event(i).type == 20
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 8
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            
            if EEG.event(i).type == 21
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 8
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            
            if EEG.event(i).type == 120
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 8
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 121
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 8
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 40
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 16
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            
            if EEG.event(i).type == 41
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 16
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 140
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 16
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 141
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 16
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 80
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 32
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 81
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 32
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 180
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 32
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 181
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'background'
                EEG.event(i).duration = 32
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 30
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 8
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 31
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 8
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 130
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 8
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 131
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 8
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 50
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 16
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 51
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 16
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 150
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 16
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 151
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 16
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 90
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 32
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 91
                EEG.event(i).object = 'object'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 32
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 190
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 32
                EEG.event(i).background = 'artificial'
                EEG.event(i).congruency = 0
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
            if EEG.event(i).type == 191
                EEG.event(i).object = 'animal'
                EEG.event(i).task_type = 'object'
                EEG.event(i).duration = 32
                EEG.event(i).background = 'natural'
                EEG.event(i).congruency = 1
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type
                end
            end
            
        end
        
    end
end