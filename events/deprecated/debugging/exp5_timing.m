
close all
clear all
load('D:\Drive\5 - Scenes\behawior.mat')

 fileType = 1; % 1 - raw (bdf); 0 - .set file
 paradigm = 5; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes; 6 - Kinga



addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2022b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2022b\toolbox\stats\stats\')



if  paradigm == 1
    root = 'D:\Drive\1 - Threshold\';
elseif  paradigm == 2
    root = 'D:\Drive\2 - Cue\';
elseif  paradigm == 3
    root = 'D:\Drive\3 - Mask\';
elseif  paradigm == 4
    root = 'D:\Drive\4 - Faces\';
elseif  paradigm == 5
    root = 'D:\Drive\5 - Scenes\';
elseif  paradigm == 6
    root='D:\Drive\6 - Kinga\';
end

if  fileType == 0
    pathLoadData = [root '\Preprocessed\']
    list=dir([pathLoadData '\*.set'  ])
elseif  fileType == 1
    pathLoadData = [root '\raw\']
    list=dir([pathLoadData '\*.bdf'  ])
end
participants = length(list)


mkdir([root, '\Preprocessed_new_pipeline'])
pathSaveData=[root '\Preprocessed_new_pipeline\'];
mkdir([pathSaveData, '\additional_info'])
eeglab nogui


    current_alpha = alpha(alpha.participant == current_participant, :);

    for i = 1:length(EEG.event)
        if EEG.event(i).type == 10
            idx(i) = 1;
        else
            idx(i) = 0;
        end
    end
    
    eventy = EEG.event([idx] == 1);
    
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
    
    
    for i = 1:length(timing.diff)
        if timing.diff(i) > 1
            display(['wrooooong ' num2str(i)])
        end
    end