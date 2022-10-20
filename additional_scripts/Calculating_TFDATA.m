addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
cd('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats')
eeglab nogui
root = 'D:\Drive\4 - Faces';
pathLoadData= [root '\MARA\'];
list=dir([pathLoadData '*.set'  ]);
mkdir(root, 'tfdata');
parthSaveData = [root '\tfdata\'];
betas_all_participants = []

for s=[88:length(list)]
    file=list(s).name;
    EEG = pop_loadset('filename',file,'filepath',pathLoadData);

        clear tfdata
        tic
        for(i=1:64)
            [~, ~, ~, ~, ~, ~, ~, tfdata(:,:,:)] = newtimef(EEG.data(i,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
            save([  parthSaveData '/tfdata_chan_' num2str(i) '_participant_' num2str(s)], 'tfdata', '-v7.3')  ;
            close all
        end
        toc
        display(['processing: ' num2str(s) ' out of ' num2str(length(list))]);
end
