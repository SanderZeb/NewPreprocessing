settings.paradigm = 5;
if settings.paradigm == 1
    root = 'D:\Drive\1 - Threshold\';
elseif settings.paradigm == 2
    root = 'D:\Drive\2 - Cue\';
elseif settings.paradigm == 3
    root = 'D:\Drive\3 - Mask\';
elseif settings.paradigm == 4
    root = 'D:\Drive\4 - Faces\';
elseif settings.paradigm == 5
    root = 'D:\Drive\5 - Scenes\';
end
pathEEGData = [root '\MARA\'];

addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
eeglab nogui
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData);
pathSaveData=[root '\MARA\'];

for s=[1:participants]
    fileEEGData=listEEGData(s).name;
    EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
    for n =1 : length(EEG.event)
        if EEG.event(n).version == 1
            if strcmp(EEG.event(n).task_type, 'object')
                if EEG.event(n).displayed_object == 0
                    if EEG.event(n).locationResponse_pressKey == 1
                        EEG.event(n).accuracy = 1;
                    elseif EEG.event(n).locationResponse_pressKey == 6
                        EEG.event(n).accuracy = 0;
                    end
                elseif EEG.event(n).displayed_object == 1
                    if EEG.event(n).locationResponse_pressKey == 1
                        EEG.event(n).accuracy = 0;
                    elseif EEG.event(n).locationResponse_pressKey == 6
                        EEG.event(n).accuracy = 1;
                    end
                end
            elseif strcmp(EEG.event(n).task_type, 'background')
                if EEG.event(n).displayed_background == 0
                    if EEG.event(n).locationResponse_pressKey == 1
                        EEG.event(n).accuracy = 1;
                    elseif EEG.event(n).locationResponse_pressKey == 6
                        EEG.event(n).accuracy = 0;
                    end
                elseif EEG.event(n).displayed_background == 1
                    if EEG.event(n).locationResponse_pressKey == 1
                        EEG.event(n).accuracy = 0;
                    elseif EEG.event(n).locationResponse_pressKey == 6
                        EEG.event(n).accuracy = 1;
                    end
                end
            end
        elseif EEG.event(n).version == 2
            if strcmp(EEG.event(n).task_type, 'object')
                if EEG.event(n).displayed_object == 0
                    if EEG.event(n).locationResponse_pressKey == 1
                        EEG.event(n).accuracy = 0;
                    elseif EEG.event(n).locationResponse_pressKey == 6
                        EEG.event(n).accuracy = 1;
                    end
                elseif EEG.event(n).displayed_object == 1
                    if EEG.event(n).locationResponse_pressKey == 1
                        EEG.event(n).accuracy = 1;
                    elseif EEG.event(n).locationResponse_pressKey == 6
                        EEG.event(n).accuracy = 0;
                    end
                end
            elseif strcmp(EEG.event(n).task_type, 'background')
                if EEG.event(n).displayed_background == 0
                    if EEG.event(n).locationResponse_pressKey == 1
                        EEG.event(n).accuracy = 0;
                    elseif EEG.event(n).locationResponse_pressKey == 6
                        EEG.event(n).accuracy = 1;
                    end
                elseif EEG.event(n).displayed_background == 1
                    if EEG.event(n).locationResponse_pressKey == 1
                        EEG.event(n).accuracy = 1;
                    elseif EEG.event(n).locationResponse_pressKey == 6
                        EEG.event(n).accuracy = 0;
                    end
                end
            end
        end
    end

    EEG = pop_saveset( EEG, 'filename', fileEEGData ,'filepath', pathSaveData);
    events{s} = EEG.event;
end
save([root 'events.mat'], 'events');