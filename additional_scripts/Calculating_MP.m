% select ROI channels
% cropp data to prestimulus part
% iterate over epochs and channels and calculate MP
% save results to a file



addpath('C:\Program Files\MATLAB\R2022b\toolbox\signal\signal');
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
cd('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats')
addpath('C:\Users\user\Desktop\eeglab-eeglab2021.0\plugins\mp-eeglab-plugin-master');
settings.paradigm = 1;
eeglab nogui
clear ALLCOM ALLEEG betas_all_participants CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY
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
pathLoadData= [root '\MARA\'];
list=dir([pathLoadData '*.set'  ]);

mkdir(root, 'MP_results');
pathSaveData = [root '\MP_results\'];


for s=[1:length(list)]
    file=list(s).name;
    EEG = pop_loadset('filename',file,'filepath',pathLoadData);
    clear tfdata chanlocs
        
    EEG = pop_select(EEG, 'time', [EEG.xmin 0]);

    chanlocs = EEG.chanlocs;
    elec.CP1 = find(strcmp({chanlocs.labels}, 'CP1')==1)	;
    elec.CPz = find(strcmp({chanlocs.labels}, 'CPz')==1)	;
    elec.CP2 = find(strcmp({chanlocs.labels}, 'CP2')==1)	;
    elec.P1 = find(strcmp({chanlocs.labels}, 'P1')==1)		;
    elec.P2 = find(strcmp({chanlocs.labels}, 'P2')==1)		;
    elec.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1)		;
    elec.O1 = find(strcmp({chanlocs.labels}, 'O1')==1)		;
    elec.Oz = find(strcmp({chanlocs.labels}, 'Oz')==1)		;
    elec.O2 = find(strcmp({chanlocs.labels}, 'O2')==1)		;
    elec.PO7 = find(strcmp({chanlocs.labels}, 'PO7')==1)	;
    elec.PO8 = find(strcmp({chanlocs.labels}, 'PO8')==1)	;
    elec.PO3 = find(strcmp({chanlocs.labels}, 'PO3')==1)	;
    elec.PO4 = find(strcmp({chanlocs.labels}, 'PO4')==1)	;

    electrodes = [elec.CP1 elec.CPz elec.CP2 elec.P1 elec.P2 elec.Pz elec.O1 elec.Oz elec.O2 elec.PO7 elec.PO8 elec.PO3 elec.PO4];
    EEG = pop_select(EEG, 'channel', electrodes);
    
    tic
    % [ersp,itc,powbase,times,freqs,erspboot,itcboot, tfdata(:,:,:)] = newtimef(EEG.data(i,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
%     rec_array= zeros(length(electrodes), size(EEG.data, 3));
%     param_array = zeros(length(electrodes), size(EEG.data, 3));
%     %data = struct();
%     %data = zeros(length(electrodes), size(EEG.data, 3));
%     tic
%     for(i=1:length(electrodes)) % iterate over electrodes
%         for (n=1:size(EEG.data, 3)) % iterate over epochs 
%             % default values for all of the input params
%             electrode_nr = electrodes(i);
%             epoch_nr = n;
%             minS = floor(EEG.srate/4);
%             maxS = size(EEG.data,2);
%             dE = 0.01;
%             energy = 0.99;
%             iter = 15;
%             nfft = 2*EEG.srate;
%             asym = 0;
%             rect = 0;
% 
% 
%             %[reconstructing_array, parameters_array] = mp_calc(EEG,electrode_nr,epoch_nr,minS,maxS,dE,energy,iter,nfft,asym,rect);
%             %[BOOK , LASTCOM] = pop_mp_calc(EEG , electrode_nr, epoch_nr, 64 , 1024 , 0.01 , 0.99 , 15 , 512 , 0 , 0);
%             [BOOK , LASTCOM] = pop_mp_calc(EEG , electrode_nr,epoch_nr,minS,maxS,dE,energy,iter,nfft,asym,rect);
%             data(i, n) = BOOK;
%         end
%     end
%     toc
%     tic
        for n = 1:4
            % default values for all of the input params
            %electrode_nr = electrodes;
            electrode_nr = 1: length(electrodes);
            if n == 1
                epoch_nr = [EEG.event([EEG.event.corr_corr] == 1).epoch];
            elseif n==2
                epoch_nr = [EEG.event([EEG.event.corr_corr] == 0).epoch];
            elseif n==3
                epoch_nr = [EEG.event([EEG.event.pas] > 1).epoch];
            elseif n==4
                epoch_nr = [EEG.event([EEG.event.pas] == 1).epoch];
            end

            minS = floor(EEG.srate/4);
            maxS = size(EEG.data,2);
            dE = 0.01;
            energy = 0.99;
            iter = 15;
            nfft = 2*EEG.srate;
            asym = 0;
            rect = 0;


            %[reconstructing_array, parameters_array] = mp_calc(EEG,electrode_nr,epoch_nr,minS,maxS,dE,energy,iter,nfft,asym,rect);
            %[BOOK , LASTCOM] = pop_mp_calc(EEG , electrode_nr, epoch_nr, 64 , 1024 , 0.01 , 0.99 , 15 , 512 , 0 , 0);
            [BOOK , LASTCOM] = pop_mp_calc(EEG , electrode_nr,epoch_nr,minS,maxS,dE,energy,iter,nfft,asym,rect);
            MP_result(n, :) = BOOK;
        end
        %end
    %end
    toc

    save([  pathSaveData '/MP_results_participant_' num2str(s)], 'MP_result', '-v7.3')  ;
    close all
    display(['processing: ' num2str(s) ' out of ' num2str(length(list))]);
end
