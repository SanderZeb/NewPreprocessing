clear all
% general settings
settings.paradigm = 5; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes
settings.inverted = 0; % 1 for regression equation with X as magnitude and Y as responses; 0 for reg. eq. with X as responses and Y as magnitude
settings.intercept = 1; % 1 for equation with intercept included; 0 for equation without intercept & interactions
settings.confirmatory = 0;

% topoplot cluster permutation test settings
settings.n_perm = 1000;
settings.fwer = .05;
settings.tail = 0;

% cluster permutation test settings
settings.perm = 10000;
settings.p_val = 0.05;

% general plotting settings
settings.limits.up = 0.06;
settings.limits.down = -0.06;


settings.onlyClusters = 0;
settings.TopoWithMask = 0;
settings.oldway = -2; % 0 for 4 topoplots [-800 -600; -600 -400; -400 -200; -200 0]; 1 for multiple topoplots with averaged timewindow (specified by settings.step); -1 for multiple topoplots with timewindow from single timepoint
settings.prestimulusOnly = 0;


settings.prefix = 'supp_'; % additional prefix for naming plots

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
if settings.confirmatory == 0
    pathTFData = [root '\tfdata\']
elseif settings.confirmatory == 1
    pathTFData = [root '\tfdata_confirmatory\']
end
pathEEGData = [root '\MARA\']
% if settings.inverted== 1 & settings.intercept== 1
%     mkdir(pathTFData, 'betas_odwrotne_intercept');
%     pathBETAS = [pathTFData '\betas_odwrotne_intercept\']
%     mkdir(pathBETAS, '\plots_odwrotne_intercept\');
%     savepath = [pathBETAS '\plots_odwrotne_intercept\']
% elseif settings.inverted== 1 & settings.intercept== 0
%     mkdir(pathTFData, 'betas_odwrotne');
%     pathBETAS = [pathTFData '\betas_odwrotne\']
%     mkdir(pathBETAS, '\plots_odwrotne\');
%     savepath = [pathBETAS '\plots_odwrotne\']
% elseif settings.inverted == 0 & settings.intercept== 1
%     mkdir(pathTFData, 'betas_intercept');
%     pathBETAS = [pathTFData '\betas_intercept\']
%     mkdir(pathBETAS, '\plots_intercept\');
%     savepath = [pathBETAS '\plots_intercept\']
% elseif settings.inverted== 0 & settings.intercept== 0
%     mkdir(pathTFData, 'betas');
%     pathBETAS = [pathTFData '\\betas\']
%     mkdir(pathBETAS, '\plots\');
%     savepath = [pathBETAS '\plots\']
% end


    mkdir(pathTFData, 'betas_interaction_regress2');
    pathBETAS = [pathTFData '\betas_interaction_regress2\']
    mkdir(pathBETAS, '\plots2_nomask\');
    savepath = [pathBETAS '\plots2_nomask\']


addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'

eeglab nogui

listBetas=dir([pathBETAS '*.mat'  ]);
listTFData=dir([pathTFData '*mat' ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData);


% 
% 
% try
%     
%     load([root 'events.mat']);
%     
% catch
%     for s=[1:participants]
%         fileEEGData=listEEGData(s).name;
%         EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
%         if settings.paradigm ==1
%             EEG = pop_selectevent( EEG, 'type',[120 121 126 127 130 131 136 137 140 141 146 147 150 151 156 157] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
%         elseif settings.paradigm == 2
%             EEG = pop_selectevent( EEG, 'type',[61 62 63 64] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
%         elseif settings.paradigm == 3
%             EEG = pop_selectevent( EEG, 'type',[101 100 106 107] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
%         elseif settings.paradigm == 4
%             EEG = pop_selectevent( EEG, 'type',[103 104] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
%         elseif settings.paradigm == 5
%             
%         end
%         chanlocs_all{s} = EEG.chanlocs;
%         events{s} = EEG.event;
%     end
%     save([root 'events.mat'], 'events');
% end
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY


for s=1:length(listBetas)
    
    file=listBetas(s).name;
    if  ~strcmp(file, 'betas')
        B = regexp(file,'\d*','Match');
        if length(B) == 2
            participantID = str2num(B{1, 1});
            channel =  str2num(B{1, 2});
        elseif length(B) == 3
            participantID = str2num(B{1, 1});
            channel =  str2num(B{1, 3});
        end
        
        listBetas(s).participant = participantID;
        listBetas(s).channel = channel;
        
        if ~isempty(strfind(file, 'bgr'))
            listBetas(s).tt = 1;
        elseif ~isempty(strfind(file, 'obj'))
            listBetas(s).tt = 0;
        end

%         C = regexp(file,'s_\w*_chann','Match');
%         currentFile = C{1,1}(3:end-6);
%         
%         
%         
%         listBetas(s).(currentFile) = 1;
    end
end

%fnames = ['intercept' 'acc' 'pas' 'interaction'];
% fnames(1:8) = []


EEG = pop_loadset('filename',listEEGData(1).name,'filepath',pathEEGData);
chanlocs = EEG.chanlocs;
if settings.confirmatory == 0
    [~,~,~,times,freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
end
if settings.confirmatory == 1
    EEG = pop_select(EEG, 'channel', [1:64]);
    EEG2 = pop_select(EEG, 'time', [EEG.xmin 0])
    EEG_flipped = flip(EEG2.data, 2);
    
    
    EEG_combined= EEG;
    EEG_combined.data(:, 1:512, :) = EEG2.data;
    EEG_combined.data(:, 513:1024, :) = EEG_flipped;
    
    EEG = pop_select(EEG_combined, 'time', [EEG.xmin 0.500]);
    [~,~,~,times,freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
end
clear EEG ALLCOM ALLEEG LASTCOM CURRENTSET CURRENTSTUDY STUDY PLUGINLIST currentFile channel B C participantID s
close all

if settings.paradigm == 1
    % 16942_1; 19520_1; 19933_1; 37104_1; 41820_1; 45997_1; 82170_1;
    % 87808_1; 96269_1
    %participants_to_drop = [5 6 7 37 40 46 88 101 117]; % due to the poor ICA decoposition
    participants_to_drop = [5 6 7 10 42 43]; % due to the poor ICA decoposition
end
if settings.paradigm == 3
    %
    participants_to_drop = [128 129]; % due to the poor ICA decoposition
end
if settings.paradigm == 4
    % 35464_4; 52235_4; 72692_4; 79587_4; 91259_4; 95229_4;
    participants_to_drop = [17 30 50 54 67 69]; % due to the poor ICA decoposition
end
if settings.paradigm == 5
    % 35464_4; 52235_4; 72692_4; 79587_4; 91259_4; 95229_4;
    participants_to_drop = [33]; % due to the poor ICA decoposition
end
% events(participants_to_drop) = [];
to_reject = any([listBetas.participant] == participants_to_drop');
listBetas(to_reject) = []

% try
%     
%     load([pathBETAS 'betas.mat']); % this process (loading beta results [Participants X electrodes]) may take a while, so we will try to load all beta files
% catch


for tt = 2:2


betas.intercept_obj = zeros(length(unique([listBetas.participant])), 64, 35, 200);
betas.acc_obj = zeros(length(unique([listBetas.participant])), 64, 35, 200);
betas.pas_obj= zeros(length(unique([listBetas.participant])), 64, 35, 200);
betas.interaction_obj= zeros(length(unique([listBetas.participant])), 64, 35, 200);

fnames = fields(betas);


if tt == 1
    listBetas([listBetas.tt] == 0) = [];
    pathBETAS = [pathTFData '\betas_interaction_regress2\']
    mkdir(pathBETAS, '\plots_bgr\');
    savepath = [pathBETAS '\plots_bgr_whitespaces\']
elseif tt == 2 
    listBetas([listBetas.tt] == 1) = [];
    pathBETAS = [pathTFData '\betas_interaction_regress2\']
    mkdir(pathBETAS, '\plots_obj\');
    savepath = [pathBETAS '\plots_obj_whitespaces\']
end



for s=1:length(listBetas)
        
        clear temp;
        participantID = listBetas(s).participant;
        channel = listBetas(s).channel;
        for i =1:length(fnames)
                temp = struct2cell(load([pathBETAS listBetas(s).name]));
                betas.(fnames{i,1})(participantID, channel, :,:) = temp{1,1}(:,:,i);
        end
        clear temp;
        display(['Processing ' num2str(s) ' out of: ' num2str(length(listBetas))]);
        
    end
%     save([pathBETAS 'betas.mat'], 'betas','-v7.3');
% end

% 
% for i = 1:length(fnames)
%     if size(betas.(fnames{i, 1}), 1) < participants_to_drop(end)
%         betas.(fnames{i, 1})(participants_to_drop(1:end-1), :,:,:) = []
%     else
%         betas.(fnames{i, 1})(participants_to_drop, :,:,:) = []
%     end
% end

channels.O1 = find(strcmp({chanlocs.labels}, 'O1')==1);
channels.Oz = find(strcmp({chanlocs.labels}, 'Oz')==1);
channels.O2 = find(strcmp({chanlocs.labels}, 'O2')==1);
channels.PO7 = find(strcmp({chanlocs.labels}, 'PO7')==1);
channels.PO8 = find(strcmp({chanlocs.labels}, 'PO8')==1);
channels.PO3 = find(strcmp({chanlocs.labels}, 'PO3')==1);
channels.PO4 = find(strcmp({chanlocs.labels}, 'PO4')==1);
channels.POz = find(strcmp({chanlocs.labels}, 'POz')==1);
channels.P1 = find(strcmp({chanlocs.labels}, 'P1')==1);
channels.P2 = find(strcmp({chanlocs.labels}, 'P2')==1);
channels.P3 = find(strcmp({chanlocs.labels}, 'P3')==1);
channels.P4 = find(strcmp({chanlocs.labels}, 'P4')==1);
channels.P5 = find(strcmp({chanlocs.labels}, 'P5')==1);
channels.P6 = find(strcmp({chanlocs.labels}, 'P6')==1);
channels.P7 = find(strcmp({chanlocs.labels}, 'P7')==1);
channels.P8 = find(strcmp({chanlocs.labels}, 'P8')==1);
channels.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1);
channels.Iz = find(strcmp({chanlocs.labels}, 'Iz')==1);
settings.selected_channels = [channels.O1 channels.Oz channels.O2 channels.PO7 channels.PO3 channels.POz channels.PO4 channels.PO8 channels.Iz channels.P7 channels.P5 channels.P3 channels.P1 channels.Pz channels.P2 channels.P4 channels.P6 channels.P8];
electrodes = settings.selected_channels;

for n = 1:length(fnames)
    for i=1:size(betas.(fnames{n,1}), 1)
        if any((find(betas.(fnames{n,1})( i, :, :,:) == -Inf)))
            error(i) = 1;
            warning(['found -Inf in ' num2str(i)]); % there was a case, where 1 participant had error in TimeFrequency decomposition resulting in -Inf values
        else
            error(i) = 0;
        end; end
    betas.(fnames{n,1})(logical(error), :, :,:) = [];
end




% 
% addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal');
% addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats');
% addpath('C:\Program Files\MATLAB\R2019b\toolbox\images\images');
% addpath 'C:\Users\user\Documents\GitHub\permutation calculation'; % folder with permutest.m

addpath('C:\Program Files\MATLAB\R2022b\toolbox\signal\signal');
addpath('C:\Program Files\MATLAB\R2022b\toolbox\stats\stats');
addpath('C:\Program Files\MATLAB\R2022b\toolbox\images\images');
addpath 'C:\Users\user\Documents\GitHub\permutation calculation'; % folder with permutest.m


settings.clean_participants = 1:(length(listEEGData)-length(participants_to_drop));

chan_hood = spatial_neighbors(chanlocs(1:64), 40); % 40 mm distance between electrodes seems to be working with EEGLAB headset.
settings.freqs_roi = freqs>=8 & freqs<=14; % we are picking up our frequencies of intrest
settings.times_roi_topo = times>= - 800 & times <= 0; % we are picking up our times (ms) of interest // this is used only if settings.old_way == 1;


for n=1:length(fnames)
    
    betas.selected_electrodes.(fnames{n,1})(:, :, :) = permute(squeeze(mean(betas.(fnames{n,1})(settings.clean_participants, electrodes, :,:), 2, 'omitnan')), [2 3 1]);
    %betas.topoplot_all.(fnames{n,1}) = permute(squeeze(mean(betas.(fnames{n,1})(settings.clean_participants,:,settings.freqs_roi, settings.times_roi_topo), 3, 'omitnan')), [2, 3, 1]);
    if settings.oldway == 0 | settings.oldway == 2 | settings.oldway == -1 | settings.oldway == -2
        betas.topoplot_all.(fnames{n,1}) = permute(squeeze(mean(betas.(fnames{n,1})(settings.clean_participants,:,settings.freqs_roi, :), 3, 'omitnan')), [2, 3, 1]);
    elseif settings.oldway == 1
        betas.topoplot_all.(fnames{n,1}) = permute(squeeze(mean(betas.(fnames{n,1})(settings.clean_participants,:,settings.freqs_roi, settings.times_roi_topo), 3, 'omitnan')), [2, 3, 1]);
    end
end

m = size(betas.selected_electrodes.(fnames{1,1}), 1);
n = size(times, 2);
b = size(betas.selected_electrodes.(fnames{1,1}), 3);
zero = zeros(m, n, b); % matrix of zeros, same size as data times, freqs, participants - used in permutation test


for n=1:length(fnames)
    tic
    display(['processing: ' (fnames{n,1})]);
    display(['permutations: ' num2str(settings.perm)]);
    display(['p_val: ' num2str(settings.p_val)]);
    display(['electrodes: ' num2str(electrodes)]);
    [cluster.(fnames{n,1}).cluster, cluster.(fnames{n,1}).p_values, cluster.(fnames{n,1}).t_sums, cluster.(fnames{n,1}).permutation_distribution ] = permutest(betas.selected_electrodes.(fnames{n,1})(:, :, :), zero, false, settings.p_val, settings.perm, true, inf);
    
    display(['done: ' (fnames{n,1})]);
    display(['found ' num2str(sum(cluster.(fnames{n,1}).p_values<0.05)) ' significant clusters in ' (fnames{n,1}) ' condition']);
    toc
end


if settings.oldway == 1
    for n=1:length(fnames)
        n1=1;
        last_val = 1;
        settings.step = 7; % step used in
        for k=1:settings.step:size(betas.topoplot_all.(fnames{n,1}), 2)
            
            betas.topoplot.(fnames{n,1})(:, n1, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, last_val:k, :), 2, 'omitnan'));
            display(['k ' num2str(k) ' n1 ' num2str(n1) '  lastval ' num2str(last_val)]);
            
            n1=n1+1;
            last_val = k;
            
            betas.topoplot2.(fnames{n,1})(:, n1, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, last_val:k, :), 2, 'omitnan'));
            
            
        end
        endclear n1 last_val k
    end
    % permutation test for topoplot
    for n=1:length(fnames)
        settings.final_topo_times = times(settings.times_roi);
        
        
        [pval, t_orig, clust_info, seed_state, est_alpha]=clust_perm1(betas.topoplot.(fnames{n,1}),chan_hood,settings.n_perm,settings.fwer,settings.tail);
        data_topo.(fnames{n,1}).clust_info = clust_info;
        data_topo.(fnames{n,1}).pval = pval;
        data_topo.(fnames{n,1}).t_orig = t_orig;
        clear pval t_orig clust_info seed_state est_alpha;
        
    end
end


if settings.oldway == 0
    settings.timewindow.minus800to600 = times>= - 800 & times <= - 600;
    settings.timewindow.minus600to400 = times>= - 600 & times <= - 400;
    settings.timewindow.minus400to200 = times>= - 400 & times <= - 200;
    settings.timewindow.minus200to0   = times>= - 200 & times <= 0;
    
    settings.final_topo_times = ["-800 -600" "-600 -400" "-400 -200" "-200 0"];
    for n=1:length(fnames)
        for i = 1:length(settings.final_topo_times) %length of timewindow
            if i == 1
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus800to600, :), 2, 'omitnan'));
            elseif i == 2
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus600to400, :), 2, 'omitnan'));
            elseif i == 3
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus400to200, :), 2, 'omitnan'));
            elseif i == 4
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus200to0, :), 2, 'omitnan'));
            end
        end
    end
    % permutation test for topoplot
    for n=1:length(fnames)
        
        [pval, t_orig, clust_info, seed_state, est_alpha]=clust_perm1(betas.topoplot.(fnames{n,1}),chan_hood,settings.n_perm,settings.fwer,settings.tail);
        data_topo.(fnames{n,1}).clust_info = clust_info;
        data_topo.(fnames{n,1}).pval = pval;
        data_topo.(fnames{n,1}).t_orig = t_orig;
        clear pval t_orig clust_info seed_state est_alpha;
        
    end
end
if settings.oldway == -1
    settings.timewindow.minus800to600 = int32(times)== -805;
    settings.timewindow.minus600to400 = int32(times)== - 598;
    settings.timewindow.minus400to200 = int32(times)== - 391;
    settings.timewindow.minus200to0   = int32(times)== -199;
    
    settings.final_topo_times = ["-800" "-600" "-400" "-200"];
    for n=1:length(fnames)
        for i = 1:length(settings.final_topo_times) %length of timewindow
            if i == 1
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus800to600, :), 2, 'omitnan'));
            elseif i == 2
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus600to400, :), 2, 'omitnan'));
            elseif i == 3
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus400to200, :), 2, 'omitnan'));
            elseif i == 4
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus200to0, :), 2, 'omitnan'));
            end
        end
    end
    % permutation test for topoplot
    for n=1:length(fnames)
        
        [pval, t_orig, clust_info, seed_state, est_alpha]=clust_perm1(betas.topoplot.(fnames{n,1}),chan_hood,settings.n_perm,settings.fwer,settings.tail);
        data_topo.(fnames{n,1}).clust_info = clust_info;
        data_topo.(fnames{n,1}).pval = pval;
        data_topo.(fnames{n,1}).t_orig = t_orig;
        clear pval t_orig clust_info seed_state est_alpha;
        
    end
end
if settings.oldway == -2
    temp = int32(times);
    settings.tw = temp(:, 20:10:180);
    settings.final_topo_times = ["-1391" "-1219" "-1047"  "-875"  "-703"  "-527"  "-355"  "-184"   "-12"   "164"   "336"   "508"   "680"   "852"  "1027"  "1199"  "1371"];
    for n=1:length(fnames)
        for i = 1:length(settings.tw) %length of timewindow
                currTw = int32(times) == settings.tw(i);
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(betas.topoplot_all.(fnames{n,1})(:, currTw, :));
                   
        end
    end
    % permutation test for topoplot
    for n=1:length(fnames)
        
        [pval, t_orig, clust_info, seed_state, est_alpha]=clust_perm1(betas.topoplot.(fnames{n,1}),chan_hood,settings.n_perm,settings.fwer,settings.tail);
        data_topo.(fnames{n,1}).clust_info = clust_info;
        data_topo.(fnames{n,1}).pval = pval;
        data_topo.(fnames{n,1}).t_orig = t_orig;
        clear pval t_orig clust_info seed_state est_alpha;
        
    end
end
if settings.oldway == 2
    settings.timewindow.minus800 = times>= - 810 & times <= - 790;
    settings.timewindow.minus700 = times>= - 710 & times <= - 690;
    settings.timewindow.minus600 = times>= - 610 & times <= - 590;
    settings.timewindow.minus500 = times>= - 510 & times <= - 490;
    settings.timewindow.minus400 = times>= - 410 & times <= - 390;
    settings.timewindow.minus300 = times>= - 310 & times <= - 290;
    settings.timewindow.minus200 = times>= - 210 & times <= - 190;
    settings.timewindow.minus100 = times>= - 110 & times <= - 90;
    settings.timewindow.minus0   = length(times)/2;

    settings.final_topo_times = ["-800"  "-700" "-600" "-500" "-400" "-300" "-200" "-100" "0"];
    for n=1:length(fnames)
        for i = 1:length(settings.final_topo_times) %length of timewindow
            if i == 1
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus800, :), 2, 'omitnan'));
            elseif i == 2
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus700, :), 2, 'omitnan'));
            elseif i == 3
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus600, :), 2, 'omitnan'));
            elseif i == 4
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus500, :), 2, 'omitnan'));
            elseif i == 5
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus400, :), 2, 'omitnan'));
            elseif i == 6
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus300, :), 2, 'omitnan'));
            elseif i == 7
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus200, :), 2, 'omitnan'));
            elseif i == 8
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus100, :), 2, 'omitnan'));
            elseif i == 9
                betas.topoplot.(fnames{n,1})(:, i, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, settings.timewindow.minus0, :), 2, 'omitnan'));
            end
        end
    end
    % permutation test for topoplot
    for n=1:length(fnames)

        [pval, t_orig, clust_info, seed_state, est_alpha]=clust_perm1(betas.topoplot.(fnames{n,1}),chan_hood,settings.n_perm,settings.fwer,settings.tail);
        data_topo.(fnames{n,1}).clust_info = clust_info;
        data_topo.(fnames{n,1}).pval = pval;
        data_topo.(fnames{n,1}).t_orig = t_orig;
        clear pval t_orig clust_info seed_state est_alpha;

    end
end
    
   
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%% TOPOPLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     ss=get(0, 'ScreenSize');
    settings.timesx = settings.final_topo_times;
    
    fnames_topo= fields(data_topo);
    
    beta = char(946);
    
    for i=1:length(fnames_topo)
            clear temp* mean_data mask_nonsignificant to_plot mean_scalp signif_el mask_significant
    
    
          
                mask_nonsignificant = data_topo.(fnames_topo{i, 1}).pval <0.05;
                notsignif_signal= nan(size(data_topo.(fnames_topo{i, 1}).pval  ));
                notsignif_channels = isnan([notsignif_signal]);
                temp = squeeze(mean(betas.topoplot.(fnames_topo{i, 1}) , 3)); % mean across participants
                %to_plot(mask_nonsignificant) = temp(mask_nonsignificant);
                to_plot = temp;
                settings.prefix = 'signif_mask_'; % additional prefix for naming plots

    
           
    
            for n=1:length(settings.timesx)
                t= figure('Position', [0 0 ss(3) ss(4)], "Visible", "off"); hold on;
                    
                %chans = find(notsignif_channels(:, n) == 1);
                test = topoplot(to_plot(:, n), chanlocs(1:64), 'style', 'both', 'pmask', mask_nonsignificant(:, n));
                test.Parent.Children(7).FaceColor = [1.0 1.0 1.0]

                clim([-0.06 0.06]);
                hold off
                settings.prefix = [num2str(n)]; % additional prefix for naming plots
                saveas(t,[savepath settings.prefix  fnames_topo{i, 1} '.png']);
                %saveas(t,[savepath  settings.prefix 'topo_betas' fnames_topo{i, 1} '.fig']);
                close all
                clear t
            end
    end

        close all
        clear t mask_nonsignificant to_plot
        

end