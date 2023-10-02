% general settings
settings.paradigm = 3; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes

% cluster permutation test settings
settings.perm = 10000;
settings.p_val = 0.05;

% general plotting settings
settings.limits.up = 0.06;
settings.limits.down = -0.06;
settings.prefix = 'fooof_'; % additional prefix for naming plots

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
pathEEGData = [root '\MARA\']
pathTFData = [root '\tfdata\fooof2\']
pathBETAS = [pathTFData '\betas_fooof\1\']
mkdir(pathBETAS, '\plots2\');
savepath = [pathBETAS '\plots2\']

addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
addpath('C:\Program Files\MATLAB\R2022b\toolbox\signal\signal');
addpath('C:\Program Files\MATLAB\R2022b\toolbox\stats\stats');
addpath('C:\Program Files\MATLAB\R2022b\toolbox\images\images');
addpath 'C:\Users\user\Documents\GitHub\permutation calculation'; % folder with permutest.m


listBetas=dir([pathBETAS '*.mat'  ]);
listTFData=dir([pathTFData '*mat' ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData);


%%
listBetas=dir([pathBETAS '\aperiodic\*.mat'  ]);

for i = 1:length(listBetas)
    load([listBetas(i).folder '\' listBetas(i).name])
    if size(betas, 3) == 3
        all_betas.aperiodic_acc(:,:,i) = betas(:,:,1);
        all_betas.aperiodic_pas(:,:,i) = betas(:,:,2);
        all_betas.aperiodic_interaction(:,:,i) = betas(:,:,3);
        clear betas
    elseif size(betas, 3) == 4
        all_betas.aperiodic_acc(:,:,i) = betas(:,:,2);
        all_betas.aperiodic_pas(:,:,i) = betas(:,:,3);
        all_betas.aperiodic_interaction(:,:,i) = betas(:,:,4);
        clear betas
    end
end

%%
listBetas=dir([pathBETAS '\periodic\*.mat'  ]);

for i = 1:length(listBetas)
    load([listBetas(i).folder '\' listBetas(i).name])

    if size(betas, 3) == 3
        all_betas.periodic_acc(:,:,i) = betas(:,:,1);
        all_betas.periodic_pas(:,:,i) = betas(:,:,2);
        all_betas.periodic_interaction(:,:,i) = betas(:,:,3);
        clear betas
    elseif size(betas, 3) == 4
        all_betas.periodic_acc(:,:,i) = betas(:,:,2);
        all_betas.periodic_pas(:,:,i) = betas(:,:,3);
        all_betas.periodic_interaction(:,:,i) = betas(:,:,4);
        clear betas
    end
end

%%

fnames = fields(all_betas);
m = size(all_betas.(fnames{1,1}), 1);
n = size(all_betas.(fnames{1,1}), 2);
b = size(all_betas.(fnames{1,1}), 3);
zero = zeros(m, n, b); % matrix of zeros, same size as data times, freqs, participants - used in permutation test



for n=1:length(fnames)
    tic
    display(['processing: ' (fnames{n,1})]);
    display(['permutations: ' num2str(settings.perm)]);
    display(['p_val: ' num2str(settings.p_val)]);
    [cluster.(fnames{n,1}).cluster, cluster.(fnames{n,1}).p_values, cluster.(fnames{n,1}).t_sums, cluster.(fnames{n,1}).permutation_distribution ] = permutest(all_betas.(fnames{n,1})(:, :, :), zero, false, settings.p_val, settings.perm, true, inf);

    display(['done: ' (fnames{n,1})]);
    display(['found ' num2str(sum(cluster.(fnames{n,1}).p_values<0.05)) ' significant clusters in ' (fnames{n,1}) ' condition']);
    toc
end

save([savepath 'clusters.mat'], "cluster")

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ss=get(0, 'ScreenSize');
beta = char(946);
%% new plot - using contour * imagesc
for i=1:length(fnames)

    temp_data = all_betas.(fnames{i,1});
    mean_data = mean(temp_data, 3, 'omitnan');

    % finding significant clusters
    temp_cluster = cluster.(fnames{i, 1});
    temp_cluster = temp_cluster.cluster;
    idx_clusters = zeros(35*200, 1);
    signif_clusters = ([cluster.(fnames{i, 1}).p_values] <0.05);
    for k=1:sum(signif_clusters)
        idx_clusters(temp_cluster{1,k}) = 1;
    end
    idx_clusters2 = reshape(idx_clusters, [35 200]);

    fig = figure('Position', [0 0 ss(3) ss(4)], 'Visible', 'on');

    mean_data = flip(mean_data);
    idx_clusters2=flip(idx_clusters2);
    %mean_data([idx_clusters2] == 0) = 0;
    imagesc(mean_data);


    ylabel('\fontsize{28} Frequency [Hz]');
    xlabel('\fontsize{28} Times [ms]');
    h_ax = gca;
    h_ax.Colormap = jet;
    h_ax.FontSize = 24;
    h_ax.CLim = [settings.limits.down settings.limits.up]
    cb = cbar;
    cb.Position = [0.91124072204465,0.11,0.024725137830286,0.815];
    ylim([settings.limits.down settings.limits.up]);
    cb.YLabel.String = ['\fontsize{20}' beta ' coefficient'];
    cb.FontSize = 18;
    cb.YAxisLocation = 'right';
    cb.YLabel.VerticalAlignment = 'top';
    h_ax_c = axes('position', get(h_ax, 'position'), 'Color', 'none');
    contour(h_ax_c, idx_clusters2, 'levels', 1,  'LineColor', 'r', 'LineWidth', 1.5);
    set(h_ax_c, 'YDir','reverse') % for some reason, contour plots are reversed on Y axis and needs to be flipped
    h_ax_c.Color = 'none';
    h_ax_c.XTick = [];
    h_ax_c.YTick = [];
    %h_ax.XTick = 1:200;
    %h_ax.XTickLabel = czasy;
    %h_ax.YTick = 1:35;
    %h_ax.YTickLabel = frekwencje;
    h_ax.TickLength = [0, 0]; % again, for some reason, figure has markers on edges.
    saveas(fig,[savepath settings.prefix fnames{i,1} '.png']);
    saveas(fig,[savepath settings.prefix fnames{i,1} '.fig']);
    close all
end