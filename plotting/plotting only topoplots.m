clear all
% general settings
settings.paradigm = 3; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes
settings.inverted = 0; % 1 for regression equation with X as magnitude and Y as responses; 0 for reg. eq. with X as responses and Y as magnitude
settings.intercept = 0; % 1 for equation with intercept included; 0 for equation without intercept & interactions
settings.confirmatory = 0;

% topoplot cluster permutation test settings
settings.n_perm = 1000;
settings.fwer = .01;
settings.tail = 0;

% cluster permutation test settings
settings.perm = 1000;
settings.p_val = 0.01;

% general plotting settings
settings.limits.up = 0.06;
settings.limits.down = -0.06;


settings.onlyClusters = 0;
settings.TopoWithMask = 1;
settings.oldway = 2; % 0 for 4 topoplots [-800 -600; -600 -400; -400 -200; -200 0]; 1 for multiple topoplots with averaged timewindow (specified by settings.step); -1 for multiple topoplots with timewindow from single timepoint
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

pathTFData = [root '\tfdata\']

pathEEGData = [root '\MARA\']
if settings.inverted== 1 & settings.intercept== 1
    mkdir(pathTFData, 'betas_odwrotne_intercept');
    pathBETAS = [pathTFData '\betas_odwrotne_intercept\']
    mkdir(pathBETAS, '\plots_odwrotne_intercept\');
    savepath = [pathBETAS '\plots_odwrotne_intercept\']
elseif settings.inverted== 1 & settings.intercept== 0
    mkdir(pathTFData, 'betas_odwrotne');
    pathBETAS = [pathTFData '\betas_odwrotne\']
    mkdir(pathBETAS, '\plots_odwrotne\');
    savepath = [pathBETAS '\plots_odwrotne\']
elseif settings.inverted == 0 & settings.intercept== 1
    mkdir(pathTFData, 'betas_intercept');
    pathBETAS = [pathTFData '\betas_intercept\']
    mkdir(pathBETAS, '\plots_intercept\');
    savepath = [pathBETAS '\plots_intercept\']
elseif settings.inverted== 0 & settings.intercept== 0
    mkdir(pathTFData, 'betas');
    pathBETAS = [pathTFData '\\betas\']
    mkdir(pathBETAS, '\plots\');
    savepath = [pathBETAS '\plots\']
end
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'

eeglab nogui

listBetas=dir([pathBETAS '*.mat'  ]);
listTFData=dir([pathTFData '*mat' ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData);




try

    load([root 'events.mat']);

catch
    for s=[1:participants]
        fileEEGData=listEEGData(s).name;
        EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
        if settings.paradigm ==1
            EEG = pop_selectevent( EEG, 'type',[120 121 126 127 130 131 136 137 140 141 146 147 150 151 156 157] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 2
            EEG = pop_selectevent( EEG, 'type',[61 62 63 64] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 3
            EEG = pop_selectevent( EEG, 'type',[101 100 106 107] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 4
            EEG = pop_selectevent( EEG, 'type',[103 104] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 5

        end
        chanlocs_all{s} = EEG.chanlocs;
        events{s} = EEG.event;
    end
    save([root 'events.mat'], 'events');
end
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY


for s=1:length(listBetas)

    file=listBetas(s).name;
    if  ~strcmp(file, 'betas.mat')
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

        C = regexp(file,'s_\w*_chann','Match');
        currentFile = C{1,1}(3:end-6);



        listBetas(s).(currentFile) = 1;
    end
end

fnames = fieldnames(listBetas)
fnames(1:8) = []


EEG = pop_loadset('filename',listEEGData(1).name,'filepath',pathEEGData);
chanlocs = EEG.chanlocs;
[~,~,~,times,freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);

clear EEG ALLCOM ALLEEG LASTCOM CURRENTSET CURRENTSTUDY STUDY PLUGINLIST currentFile channel B C participantID s
close all

if settings.paradigm == 1
    % 16942_1; 19520_1; 19933_1; 37104_1; 41820_1; 45997_1; 82170_1;
    % 87808_1; 96269_1
    participants_to_drop = [5 6 7 37 40 46 88 101 117]; % due to the poor ICA decoposition
end
if settings.paradigm == 3
    %
    participants_to_drop = [128 129]; % due to the poor ICA decoposition
end
if settings.paradigm == 4
    % 35464_4; 52235_4; 72692_4; 79587_4; 91259_4; 95229_4;
    participants_to_drop = [17 30 50 54 67 69]; % due to the poor ICA decoposition
end

events(participants_to_drop) = [];
to_reject = any([listBetas.participant] == participants_to_drop');
listBetas(to_reject) = []

try

    load([pathBETAS 'betas.mat']); % this process (loading beta results [Participants X electrodes]) may take a while, so we will try to load all beta files
catch
    for s=1:length(listBetas)

        clear temp;
        participantID = listBetas(s).participant;
        channel = listBetas(s).channel;
        for i =1:length(fnames)
            if    listBetas(s).(fnames{i,1}) == 1
                temp = struct2cell(load([pathBETAS listBetas(s).name]));
                betas.(fnames{i,1})(participantID, channel, :,:) = temp{1,1};
            end
        end



        clear temp;
        display(['Processing ' num2str(s) ' out of: ' num2str(length(listBetas))]);

    end
    save([pathBETAS 'betas.mat'], 'betas','-v7.3');
end


for i = 1:length(fnames)
    if size(betas.(fnames{i, 1}), 1) < participants_to_drop(end)
        betas.(fnames{i, 1})(participants_to_drop(1:end-1), :,:,:) = []
    else
        betas.(fnames{i, 1})(participants_to_drop, :,:,:) = []
    end
end

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

settings.clean_participants = 1:(length(listEEGData)-length(participants_to_drop));

addpath('C:\Program Files\MATLAB\R2022b\toolbox\signal\signal');
addpath('C:\Program Files\MATLAB\R2022b\toolbox\stats\stats');
addpath('C:\Program Files\MATLAB\R2022b\toolbox\images\images');
addpath 'C:\Users\user\Documents\GitHub\permutation calculation'; % folder with permutest.m

chan_hood = spatial_neighbors(chanlocs(1:64), 40); % 40 mm distance between electrodes seems to be working with EEGLAB headset.
settings.freqs_roi = freqs>=8 & freqs<=14; % we are picking up our frequencies of intrest
settings.times_roi_topo = times>= - 800 & times <= 0; % we are picking up our times (ms) of interest // this is used only if settings.old_way == 1;

for n=1:length(fnames)

    betas.selected_electrodes.(fnames{n,1})(:, :, :) = permute(squeeze(mean(betas.(fnames{n,1})(settings.clean_participants, electrodes, :,:), 2, 'omitnan')), [2 3 1]);
    betas.topoplot_all.(fnames{n,1}) = permute(squeeze(mean(betas.(fnames{n,1})(settings.clean_participants,:,settings.freqs_roi, :), 3, 'omitnan')), [2, 3, 1]);

end

for n=1:length(fnames)
    betas.topoplot.(fnames{n,1})(:, :, :) = betas.topoplot_all.(fnames{n,1})(:, :, :);
end
for n=1:length(fnames)

    [pval, t_orig, clust_info, seed_state, est_alpha]=clust_perm1(betas.topoplot.(fnames{n,1}),chan_hood,settings.n_perm,settings.fwer,settings.tail);
    data_topo.(fnames{n,1}).clust_info = clust_info;
    data_topo.(fnames{n,1}).pval = pval;
    data_topo.(fnames{n,1}).t_orig = t_orig;
    clear pval t_orig clust_info seed_state est_alpha;

end


    settings.timewindow.minus800to600 = int32(times)== -805;
    settings.timewindow.minus600to400 = int32(times)== - 598;
    settings.timewindow.minus400to200 = int32(times)== - 391;
    settings.timewindow.minus200to0   = int32(times)== -199;
    
    settings.final_topo_times = ["-800" "-600" "-400" "-200"];

timepoints = fields(settings.timewindow)
settings.timesx = settings.final_topo_times;

fnames_topo= fields(data_topo);

for i=1:length(fnames_topo)
    clear temp* mean_data mask_nonsignificant to_plot mean_scalp signif_el mask_significant
    mask_nonsignificant = data_topo.(fnames_topo{i, 1}).pval <0.05;
    to_plot = zeros(size(data_topo.(fnames_topo{i, 1}).pval  ));
    temp = squeeze(mean(betas.topoplot.(fnames_topo{i, 1}) , 3)); % mean across participants
    to_plot(mask_nonsignificant) = temp(mask_nonsignificant);
    settings.prefix = 'signif_mask_'; % additional prefix for naming plots
    heads_cols = 3  ;
    heads_rows = ceil(size(temp,2)/heads_cols);
    figure('Position', [0 0 ss(3) ss(4)], "Visible", "on"); hold on;
    %     figure('Position', [0 0 ss(3) ss(4)], "Visible", "on"); hold on;
       % t = tiledlayout(heads_cols, heads_rows, 'TileSpacing','normal');
    %  t = tiledlayout(heads_cols, heads_rows, 'TileSpacing','normal');
    
        %    t.Padding = "normal";
            %title(t,[ beta ' values - ' fnames_topo{i, 1}]);
            %t.Title.FontSize = 30;
            %t.Title.FontWeight = 'bold';
    
    for n=1:length(settings.timesx)
        nexttile;
        selected_timepoint = find(settings.timewindow.(timepoints{n, 1}) == 1);
        if sum(selected_timepoint) > 1
            selected_timepoint = selected_timepoint(1);
        end

        if any(to_plot(:, selected_timepoint))
            topoplot(to_plot(:, selected_timepoint), chanlocs(1:64));
        else
            topoplot(to_plot(:, selected_timepoint), chanlocs(1:64), 'style', 'blank');
        end
%         title([num2str(settings.timesx(n)) '  ms' ]);
    end
%             for n=1:length(t.Children)
%                 t.Children(n).FontSize = 18;
%                 t.Children(n).TitleFontWeight = 'normal';
%                 t.Children(n).CLim = [settings.limits.down settings.limits.up];
%             end
end