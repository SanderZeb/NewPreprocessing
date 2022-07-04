root = 'D:\Drive\1 - Threshold\'
pathEEGData = [root 'MARA\']
pathBETAS = [ root '\tfdata\betas_odwrotne\']
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
settings.paradigm = 1;

eeglab nogui

listBetas=dir([pathBETAS '*.mat'  ]);
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
if settings.paradigm == 4
    % 35464_4; 52235_4; 72692_4; 79587_4; 91259_4; 95229_4;
    participants_to_drop = [17 30 50 54 67 69]; % due to the poor ICA decoposition
end

events(participants_to_drop) = [] 
to_reject = any([listBetas.participant] == participants_to_drop');
listBetas(to_reject) = []
%clear to_reject

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

    


for i = 2:length(fnames)
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
            warning(['found -Inf in ' num2str(i)]);
        else
            error(i) = 0;
        end; end
    betas.(fnames{n,1})(logical(error), :, :,:) = [];
end





addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal');
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats');
addpath('C:\Program Files\MATLAB\R2019b\toolbox\images\images');
addpath 'C:\Users\user\Documents\GitHub\permutation calculation'; % folder with permutest.m
settings.perm = 10^4;
settings.times_roi = times;
settings.p_val = 0.05;

settings.clean_participants = 1:length(listEEGData)-length(participants_to_drop);

chan_hood = spatial_neighbors(chanlocs(1:64), 40);
settings.freqs_roi = freqs>=8 & freqs<=14;
settings.times_roi = times> - 700 & times < 1000;


for n=1:length(fnames)
    
    betas.selected_electrodes.(fnames{n,1})(:, :, :) = permute(squeeze(mean(betas.(fnames{n,1})(settings.clean_participants, electrodes, :,:), 2, 'omitnan')), [2 3 1]);
    betas.topoplot_all.(fnames{n,1}) = permute(squeeze(mean(betas.(fnames{n,1})(settings.clean_participants,:,settings.freqs_roi, settings.times_roi), 3, 'omitnan')), [2, 3, 1]);
    
    
end

m = size(betas.selected_electrodes.(fnames{1,1}), 1);
n = size(times, 2);
b = size(betas.selected_electrodes.(fnames{1,1}), 3);
zero = zeros(m, n, b); % matrix of zeros, same size as data times, freqs, participants


for n=1:length(fnames)
    tic
    display(['processing: ' (fnames{n,1})])
    display(['permutations: ' num2str(settings.perm)])
    display(['p_val: ' num2str(settings.p_val)])
    display(['electrodes: ' num2str(electrodes)])
    [cluster.(fnames{n,1}).cluster, cluster.(fnames{n,1}).p_values, cluster.(fnames{n,1}).t_sums, cluster.(fnames{n,1}).permutation_distribution ] = permutest(betas.selected_electrodes.(fnames{n,1})(:, :, :), zero, false, settings.p_val, settings.perm, true, inf);
    
    display(['done: ' (fnames{n,1})])
    display(['found ' num2str(sum(cluster.(fnames{n,1}).p_values<0.05)) ' significant clusters in ' (fnames{n,1}) ' condition']);
    toc
end

for n=1:length(fnames)
    n1=1
    last_val = 1
    settings.step = 7
    for k=1:settings.step:size(betas.topoplot_all.(fnames{n,1}), 2)
        
        betas.topoplot.(fnames{n,1})(:, n1, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, last_val:k, :), 2, 'omitnan'));
        display(['k ' num2str(k) ' n1 ' num2str(n1) '  lastval ' num2str(last_val)]);
        
        n1=n1+1;
        last_val = k;
        
        betas.topoplot2.(fnames{n,1})(:, n1, :) = squeeze(mean(betas.topoplot_all.(fnames{n,1})(:, last_val:k, :), 2, 'omitnan'));

        
    end
end
clear n1 last_val k
for n=1:length(fnames)
    
    
    settings.timesx = times(settings.times_roi)
    settings.times_new = settings.timesx(1:settings.step:end)
    
    settings.n_perm = 10000;
    settings.fwer = .05;
    settings.tail = 0;
    
    [pval, t_orig, clust_info, seed_state, est_alpha]=clust_perm1(betas.topoplot.(fnames{n,1}),chan_hood,settings.n_perm,settings.fwer,settings.tail);
    data_topo.(fnames{n,1}).clust_info = clust_info;
    data_topo.(fnames{n,1}).pval = pval;
    data_topo.(fnames{n,1}).t_orig = t_orig;
    clear pval t_orig clust_info seed_state est_alpha
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear ALLCOM ALLEEG B CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY
s=get(0, 'ScreenSize');
m = length(freqs);

beta = char(946);
n = size(settings.times_roi, 2);
czasy = string(int64(times));
frekwencje = string(int64(freqs));
mkdir(pathBETAS, '\plots\');
savepath = [pathBETAS '\plots\']

every_5th_element = [1:length(settings.times_roi)]
every_5th_element(mod(every_5th_element,5) == 0) = 0;
czasy(every_5th_element~=0) = " "
clear every_5th_element

every_3d_element = [1:length(freqs)]
every_3d_element(mod(every_3d_element,3) == 0) = 0;
frekwencje(every_3d_element~=0) = " "
clear every_3d_element




for i=1:length(fnames)
    clear temp* mean_data
    temp_cluster = cluster.(fnames{i, 1});
    temp_data = betas.selected_electrodes.(fnames{i,1});
    
    
    temp_cluster = temp_cluster.cluster;
    mean_data = mean(temp_data, 3, 'omitnan');
    
    
    
    figure('Position', [0 0 s(3) s(4)], 'Visible', 'off');
    
    %plot = heatmap(times(times_limit), freqs, (mean_data))
    plot = heatmap(times, freqs, (mean_data))
    plot.title(['\fontsize{24} ' beta ' coefficient - ' (fnames{i,1})])
    plot.XDisplayLabels = czasy;
    plot.YDisplayLabels = frekwencje;
    plot.XLabel = '\fontsize{20} Times [ms]'
    plot.YLabel = '\fontsize{20} Frequency [Hz]'
    plot.FontSize = 16
    colormap('jet')
    grid off
    caxis([-0.04 0.04])
    
    
    saveas(plot,[savepath  fnames{i,1} '.png']);
    saveas(plot,[savepath  fnames{i,1} '.fig']);
    close all
    
    clear idx_clusters signif_clusters
    
    idx_clusters = zeros(m*n, 1)
    signif_clusters = ([cluster.(fnames{i, 1}).p_values] <0.05)
    for k=1:sum(signif_clusters)
        idx_clusters(temp_cluster{1,k}) = 1
    end
    idx_clusters2 = reshape(idx_clusters, [m n])
    figure('Position', [0 0 s(3) s(4)], 'Visible', 'off');
    plot = heatmap(times, freqs, (idx_clusters2))
    plot.title(['\fontsize{24} ' beta ' coefficient - ' fnames{i,1}])
    plot.XDisplayLabels = czasy;
    plot.YDisplayLabels = frekwencje;
    plot.XLabel = '\fontsize{20} Times [ms]'
    plot.YLabel = '\fontsize{20} Frequency [Hz]'
    plot.CellLabelColor = 'None'
    plot.FontSize = 16
    colormap('jet')
    grid off
    caxis([-0.04 0.04])
    
    saveas(plot,[savepath  fnames{i,1} '_mask.png']);
    saveas(plot,[savepath  fnames{i,1} '_mask.fig']);
    close all
    
    
    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% TOPOPLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

limits.up = 0.5
limits.down = -0.5
%mask_nonsignificant = data_topo.threshold.diff_clust.neg_clust_ids~=0 | data_topo.threshold.diff_clust.pos_clust_ids~=0


settings.timesx = settings.times_new
s=get(0, 'ScreenSize');

fnames_topo= fields(data_topo)

for i=1:length(fnames_topo)
    clear temp* mean_data mask_nonsignificant to_plot mean_scalp signif_el mask_significant
    
    mask_nonsignificant = data_topo.(fnames_topo{i, 1}).pval <0.05
    to_plot = zeros(size(data_topo.(fnames_topo{i, 1}).pval  ));
    temp = squeeze(mean(betas.topoplot.(fnames_topo{i, 1}) , 3))
    to_plot(mask_nonsignificant) = temp(mask_nonsignificant)
    heads_cols = 3  ; 
    heads_rows = ceil(size(temp,2)/heads_cols); 
        figure('Position', [0 0 s(3) s(4)], "Visible", "off"); hold on;
        t = tiledlayout(heads_cols, heads_rows, 'TileSpacing','normal', 'Padding', 'Compact');
        title(t,[ beta ' values - ' fnames_topo{i, 1}]);
        t.Title.FontSize = 30
        t.Title.FontWeight = 'bold'
        
        
        for n=1:length(settings.timesx)
            nexttile;
            topoplot(to_plot(:, n), chanlocs(1:64));
            title([num2str(int64(settings.timesx(n))) '  ms' ]);
            
        end
        for n=1:length(t.Children)
            t.Children(n).FontSize = 18;
            t.Children(n).TitleFontWeight = 'normal'
            %t.Children(n).CLim = [limits.down limits.up]
        end
        
        t.Children(8).Visible = 'off'
       cbar;
        %ylim([limits.down limits.up]);
       t.Parent.Children(1).YLabel.String = [' beta vals']
        t.Parent.Children(1).YLabel.FontSize = 18
        t.Parent.Children(1).YAxisLocation = 'right'
        t.Parent.Children(1).YLabel.VerticalAlignment = 'top'
        
        
        t.Parent.Children(1).FontSize = 20;
        t.Parent.Children(1).FontWeight = 'normal';
        %t.Parent.Children(1).Position = [0.88    0.5    0.015    0.3];
        
        saveas(t,[savepath 'topo_betas' fnames_topo{i, 1} '.png']);
        saveas(t,[savepath 'topo_betas' fnames_topo{i, 1} '.fig']);
        close all
        clear t mask_nonsignificant to_plot

end