
fileType = 1; % 1 - raw (bdf); 0 - .set file
paradigm = 5; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes; 6 - Kinga
epochLim = [-2 2]; % epoch start; epoch end (in s)
sampling = 256;


addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
addpath('C:\Users\user\Documents\GitHub\NewPreprocessing\events')
addpath('C:\Users\user\Documents\GitHub\NewPreprocessing\events\debugging\')

root = 'D:\Drive\5 - Scenes\';


if  fileType == 0
    pathLoadData = [root '\Preprocessed\']
    list=dir([pathLoadData '\*.set'  ])
elseif  fileType == 1
    pathLoadData = [root '\raw\']
    list=dir([pathLoadData '\*.bdf'  ])
end
participants = length(list)


mkdir([root, '\debugging'])
pathSaveData=[root '\debugging\'];
eeglab nogui


for s=[1:participants]

    clear temp idx
    file=list(s).name;
    ID=str2num(file(1:5));

    if  fileType == 0
        EEG = pop_loadset('filename',file,'filepath',pathLoadData);
    elseif  fileType == 1
        EEG = pop_biosig([pathLoadData '\' file], 'importevent','on');
    end

    EEG = pop_resample(EEG, sampling);
    EEG = events_scenes_debugging(EEG);
    %         temp = EEG.event;
    %         for i = 1:length(temp)
    %             if isempty(temp(i).congruency)
    %                 idx(i)=1;
    %             else
    %                 idx(i)=0;
    %             end
    %         end
    %         EEG.event([idx]==1)=[];

    %        for n=1:length(EEG.event)
    %             EEG.event(n).old = EEG.event(n).latency;
    %             EEG.event(n).new_latency = (EEG.event(n).latency / EEG.srate) * sampling;
    %         end
    EEG = pop_epoch( EEG, {'20', '21', '120', '121', '40', '41', '140', '141', '80', '81', '180', '181', '30', '31', '130', '131', '50', '51', '150', '151', '90', '91', '190', '191'},  epochLim, 'epochinfo', 'yes');
    temp = EEG.event;
    save([pathSaveData '\events_' num2str(ID) '.mat'], 'temp');
    events{i} = EEG.event;

end
save([pathSaveData '\events_correct_epochs.mat'], 'events')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



epochLim = [-2 2]; % epoch start; epoch end (in s)

root = 'D:\Drive\5 - Scenes\';
pathLoadData1 = [root '\MARA\']
list1=dir([pathLoadData1 '\*.set'  ])
pathLoadData2 = [root '\debugging\']
mkdir([root '\debugging\eeg\'])
pathSaveData1 = [root '\debugging\eeg\']
mkdir([root '\debugging\proper_events\'])
pathSaveData2 = [root '\debugging\proper_events\']
list2=dir([pathLoadData2 '\*.mat'  ])

for i = 1:length(list1)
    clear file* EEG part* idx* temp
    file1 = list1(i).name;
    file2 = list2(i).name;
    EEG = pop_loadset('filename',file1,'filepath',pathLoadData1);
    load([pathLoadData2 file2]);
    part1 = EEG.event;
    part2 = temp;

    to_keep = unique([part2.urevent]);


    for i=1:length(part1)
        if any(find(part1(i).urevent == [to_keep]))
            idx(i) = 1;
        else
            idx(i) = 0;
        end
    end
    part3 = part1(idx==1);

    for i=1:length(part3)
        part3(i).epoch_old = part3(i).epoch;

        if i>1 & part3(i).urevent == part3(i-1).urevent
            idx_2(i) = 1;
        else
            idx_2(i) = 0;
        end

    end

    part4 = part3(idx_2 == 0)
    EEG.event = part4;
    EEG = pop_epoch( EEG, {'20', '21', '120', '121', '40', '41', '140', '141', '80', '81', '180', '181', '30', '31', '130', '131', '50', '51', '150', '151', '90', '91', '190', '191'},  epochLim, 'epochinfo', 'yes');
    temp = EEG.event;
    EEG = pop_saveset( EEG, 'filename', file1 ,'filepath', pathSaveData2);
    save([pathSaveData2  file2 '.mat'], 'temp')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

root = 'D:\Drive\5 - Scenes\';
load([root 'events.mat']);
pathLoadData2 = [root '\debugging\proper_events\'];
list2=dir([pathLoadData2 '\*.mat'  ]);

for s = 1:length(events)
    clear file* EEG part* idx* temp
    file2 = list2(s).name;
    load([pathLoadData2 file2]);
    temp2 = events{s};

    for i=1:length(temp2)
        idx(i) = any(find(temp2(i).epoch == [temp.epoch_old]));
    end
    temp3 = temp2([idx] == 1);
    for i=1:length(temp3)
        if temp3(i).type == temp(i).type
            checksum(i) = 1;
        else
            checksum(i) = 0;
        
        end
    end
    

    events2{s} = temp3;
end

save([pathLoadData2   'events.mat'], 'events2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%



