function EEG = events_scenes_debugging(EEG, current_behawior)

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




idx_206 = find([EEG.event.type] == 206);


%%
EEG.event(1:idx_206(1)) = [];
idx_10 = [EEG.event.type] == 10;
eventy = EEG.event([idx_10] == 1);

    for i = 1:length(eventy)
    
            if i >1
            timing.eeg(i, 1) = ((eventy(i).latency - eventy(i-1).latency) / EEG.srate);
            end
    
    end
    for i = 1:size(current_behawior,1)
        if i >1
            timing.beh(i, 1) = current_behawior.globalTime(i) - current_behawior.globalTime(i-1);
        end
    end
    
    timing.diff = [timing.eeg - timing.beh];


%%

s=1
for i=1:length(idx_10)
    if idx_10(i)==1
        EEG.event(i).trial = s;
        EEG.event(i).timing_eeg = timing.eeg(s);
        EEG.event(i).timing_beh = timing.beh(s);
        s=s+1;
    end

end

trials = max([EEG.event.trial]);
curr_behawior = table2struct(current_behawior);
start = 1;

try
    for i = 1:length(EEG.event)
        if i>1 & EEG.event(i-1).type == 10 & any(EEG.event(i).type== [ 20 21 120 121 40 41 140 141 80 81 180 181 30 31 130 131 50 51 150 151 90 91 190 191]) 
            %% START OF CONTDITIONS
            EEG.event(i).trial = EEG.event(i-1).trial;
            beh_index = EEG.event(i).trial;
            EEG.event(i).timing_eeg = EEG.event(i-1).timing_eeg;
            EEG.event(i).timing_beh = EEG.event(i-1).timing_beh;
            EEG.event(i).pair = curr_behawior(beh_index).pair;
            EEG.event(i).object = curr_behawior(beh_index).object;
            EEG.event(i).background = curr_behawior(beh_index).background
            EEG.event(i).congruency = curr_behawior(beh_index).congruency
            EEG.event(i).timing = curr_behawior(beh_index).timing
            EEG.event(i).thisIndex = curr_behawior(beh_index).thisIndex
            EEG.event(i).version = curr_behawior(beh_index).version
            EEG.event(i).task_order = curr_behawior(beh_index).task_order
            EEG.event(i).globalTime = curr_behawior(beh_index).globalTime
            EEG.event(i).fixation_dur = curr_behawior(beh_index).fixation_dur
            EEG.event(i).stimulation_dur = curr_behawior(beh_index).stimulation_dur
            EEG.event(i).post_fixation = curr_behawior(beh_index).post_fixation
            EEG.event(i).opacity = curr_behawior(beh_index).opacity
            EEG.event(i).trigger = curr_behawior(beh_index).trigger
            EEG.event(i).locationResponse_pressKey = curr_behawior(beh_index).locationResponse_pressKey
            EEG.event(i).locationResponse_pressRT = curr_behawior(beh_index).locationResponse_pressRT
            EEG.event(i).locationResponse_releaseRT = curr_behawior(beh_index).locationResponse_releaseRT
            EEG.event(i).pasResponse_pressKey = curr_behawior(beh_index).pasResponse_pressKey
            EEG.event(i).pasResponse_pressRT = curr_behawior(beh_index).pasResponse_pressRT
            EEG.event(i).pasResponse_releaseRT = curr_behawior(beh_index).pasResponse_releaseRT
            EEG.event(i).image = curr_behawior(beh_index).image
            EEG.event(i).stimulus_duration_ms = curr_behawior(beh_index).stimulus_duration_ms
            EEG.event(i).stimulus_duration_frames = curr_behawior(beh_index).stimulus_duration_frames
            EEG.event(i).mask_duration_frames = curr_behawior(beh_index).mask_duration_frames
            EEG.event(i).task_type = curr_behawior(beh_index).task_type
            EEG.event(i).displayed_object = curr_behawior(beh_index).displayed_object
            EEG.event(i).displayed_background = curr_behawior(beh_index).displayed_background
            EEG.event(i).pair1 = curr_behawior(beh_index).pair1
            EEG.event(i).ID = curr_behawior(beh_index).ID
            EEG.event(i).frameRate = curr_behawior(beh_index).frameRate
            EEG.event(i).corrected_id = curr_behawior(beh_index).corrected_id
            
            if EEG.event(i).type == 20
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 8;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 21
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 8;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 120
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 8;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 121
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 8;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 40
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 16;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 41
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 16;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 140
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 16;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 141
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 16;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 80
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 32;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 81
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 32;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 180
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 32;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 181
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'background';
                EEG.event(i).duration = 32;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 30
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 8;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 31
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 8;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 130
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 8;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 131
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 8;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 50
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 16;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 51
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 16;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 150
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 16;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 151
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 16;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 90
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 32;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 91
                EEG.event(i).object = 'object';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 32;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 190
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 32;
                EEG.event(i).background = 'artificial';
                EEG.event(i).congruency = 0;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            elseif EEG.event(i).type == 191
                EEG.event(i).object = 'animal';
                EEG.event(i).task_type = 'object';
                EEG.event(i).duration = 32;
                EEG.event(i).background = 'natural';
                EEG.event(i).congruency = 1;
                if i+1 ~= length(EEG.event) & any(EEG.event(i+1).type == [41 46])
                    EEG.event(i).identification = EEG.event(i+1).type;
                end
                if i+2 ~= length(EEG.event) & any(EEG.event(i+2).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+2).type;
                elseif i+3 ~= length(EEG.event) & any(EEG.event(i+3).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+3).type;
                elseif i+4 ~= length(EEG.event) & any(EEG.event(i+4).type == [1 2 3 4])
                    EEG.event(i).pas = EEG.event(i+4).type;
                end
            end
            start = start+1;
        end

    end
end