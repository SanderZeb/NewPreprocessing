close all
clear all
paradigm = 3; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes; 6 - Kinga


addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')



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

pathLoadData = [root '\MARA\']
mkdir([root, '\phase'])
pathSaveData=[root '\phase\'];
mkdir([pathSaveData, '\additional_info'])
eeglab nogui
list=dir([pathLoadData '\*.set'  ])
participants = length(list)

addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2022b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2022b\toolbox\stats\stats\')

addpath C:\Users\user\Documents\GitHub\NewPreprocessing\helpers
time_period_low = 384;   %200 ms pre is 131 to 170; 400ms pre is 91 to 170
time_period_high = 512;
n_chan = 64;
Fs = 256;                    % Sampling frequency
T = 1/Fs;                    % Time
L = (time_period_high-time_period_low+1);                     % Trial Length
f = Fs/2*linspace(0,1,L/2);   %divide the frequency into bins from 0 to half the sampling frequency
low_f = 3;



for i_sub = 1:participants                                                %for each subject
    file=list(i_sub).name;
    EEG = pop_loadset('filename',file,'filepath',pathLoadData);

    EEG.event([EEG.event.type] == 10) = [];
    i_sub = int64(i_sub);
    for i_cond = 1:6                                      %for each condition
        i_cond = int64(i_cond);
        %acc = [EEG.event.identification2];
        acc = [EEG.event.corr_corr];
        pas = [EEG.event.pas];

        if i_cond == 1
            condition = [acc] == 1;
        elseif i_cond == 2
            condition = [acc] == 0;
        elseif i_cond == 3
            if sum([pas]==1) > 10
                condition = [pas] == 1;
            else
                condition = [];
            end
        elseif i_cond == 4
            if sum([pas]==2) > 10
                condition = [pas] == 2;
            else
                condition = [];
            end
        elseif i_cond == 5
            if sum([pas]==3) > 10
                condition = [pas] == 3;
            else
                condition = [];
            end
        elseif i_cond == 6
            if sum([pas]==4) > 10
                condition = [pas] == 4;
            else
                condition = [];
            end
        end
        if ~isempty(condition)
            data = EEG.data(:,:, condition);
        else
            data = [];
        end
        if ~isempty(data)
            for i_chan = 1:64
                i_chan = int64(i_chan);
                for i_trial=1:size(data,3)           %for each single trial
                    i_trial = int64(i_trial);
                    data2 = data(i_chan,time_period_low:time_period_high,i_trial);   %get the trial data

                    y = fft(data2);
                    m = abs(y)/(L/2);             %get the magnitude of each fbin
                    pow = m(1:L/2).^2;            %square to get the power, only of the first half, second is redundant


                    p = angle(y(1:L/2));          %get the phase in radians of each bin, only first half
                    p_d = p * (180/pi);           %Convert phase to degrees

                    running_power(i_trial ) = log(pow(1,low_f));  %keep a list for each trial of the power in the bin

                    if p_d(1,low_f) >=0
                        running_phase(i_trial ) = p_d(1,low_f);  %and again for the phase
                    else
                        running_phase(i_trial) = 360 - abs((p_d(1,low_f)));
                    end

                end

                [circ_mean,range,X,Y,cos_a,sin_a] = circle_mean(running_phase.');    % Computes the circular mean for each condition in each subject
                phase_out(i_sub,i_cond,i_chan) = circ_mean;                        %record the condition circular phase mean
                range_out(i_sub,i_cond,i_chan) = range;                            %record the range (concentration) of each of these means
                X_out(i_sub,i_cond,i_chan) = X;                                    %record the cosine component of the mean
                Y_out(i_sub,i_cond,i_chan) = Y;                                    %record the sine component of the mean
                cos_out(i_sub,i_cond,i_chan) = cos_a;
                sin_out(i_sub,i_cond,i_chan) = sin_a;
                pow_sum = 0;
                for i_pow_row = 1:size(running_power)

                    pow_sum = pow_sum + running_power(i_pow_row);

                end
                power_out(i_sub,i_cond,i_chan) = pow_sum/(i_pow_row-1);
                clear data2 y m pow p p_d running_power running_phase circ_mean range X Y cos_a sin_a pow_sum i_pow_row
            end
        end
        clear data condition
    end
end



for i_chan = 1:64
    [circ_grand_mean(i_chan,1), circ_grand_range(i_chan,1), X_bar(i_chan,1), Y_bar(i_chan,1), cos_bar(i_chan,1), sin_bar(i_chan,1)] = circle_grand_mean(phase_out(:,1,i_chan),range_out(:,1,i_chan));
    [circ_grand_mean(i_chan,2), circ_grand_range(i_chan,2), X_bar(i_chan,2), Y_bar(i_chan,2), cos_bar(i_chan,2), sin_bar(i_chan,2)] = circle_grand_mean(phase_out(:,2,i_chan),range_out(:,2,i_chan));
    [circ_grand_mean(i_chan,3), circ_grand_range(i_chan,3), X_bar(i_chan,3), Y_bar(i_chan,3), cos_bar(i_chan,3), sin_bar(i_chan,3)] = circle_grand_mean(phase_out(:,3,i_chan),range_out(:,3,i_chan));
    [circ_grand_mean(i_chan,4), circ_grand_range(i_chan,4), X_bar(i_chan,4), Y_bar(i_chan,4), cos_bar(i_chan,4), sin_bar(i_chan,4)] = circle_grand_mean(phase_out(:,4,i_chan),range_out(:,4,i_chan));
    [circ_grand_mean(i_chan,5), circ_grand_range(i_chan,5), X_bar(i_chan,5), Y_bar(i_chan,5), cos_bar(i_chan,5), sin_bar(i_chan,5)] = circle_grand_mean(phase_out(:,5,i_chan),range_out(:,5,i_chan));
    [circ_grand_mean(i_chan,6), circ_grand_range(i_chan,6), X_bar(i_chan,6), Y_bar(i_chan,6), cos_bar(i_chan,6), sin_bar(i_chan,6)] = circle_grand_mean(phase_out(:,6,i_chan),range_out(:,6,i_chan));
    circ_grand_mean(i_chan,7) = circ_grand_mean(i_chan,1) - circ_grand_mean(i_chan,2); % corr - incorr
    circ_grand_mean(i_chan,8) = circ_grand_mean(i_chan,6) - circ_grand_mean(i_chan,3); % PAS4 - PAS1
    circ_grand_mean(i_chan,9) = circ_grand_mean(i_chan,5) - circ_grand_mean(i_chan,3); % PAS3 - PAS1
    circ_grand_mean(i_chan,10) = circ_grand_mean(i_chan,4) - circ_grand_mean(i_chan,3); % PAS2 - PAS1
    if abs(circ_grand_mean(i_chan,3)) > 180
        if circ_grand_mean(i_chan,3) < 0
            circ_grand_mean(i_chan,3) = -360 - circ_grand_mean(i_chan,3);
        else
            circ_grand_mean(i_chan,3) = 360 - circ_grand_mean(i_chan,3);
        end
    end


    [circ_grand_mean(i_chan,11)] = circle_test(cos_out(:,:,i_chan),sin_out(:,:,i_chan),cos_bar(i_chan,:),sin_bar(i_chan,:));

    pow_grand_mean(i_chan,1) = mean(power_out(:,1,i_chan), 'omitnan');
    pow_grand_mean(i_chan,2) = mean(power_out(:,2,i_chan), 'omitnan');
    pow_grand_mean(i_chan,3) = mean(power_out(:,3,i_chan), 'omitnan');
    pow_grand_mean(i_chan,4) = mean(power_out(:,4,i_chan), 'omitnan');
    pow_grand_mean(i_chan,5) = mean(power_out(:,5,i_chan), 'omitnan');
    pow_grand_mean(i_chan,6) = mean(power_out(:,6,i_chan), 'omitnan');

    pow_grand_mean(i_chan,7) = pow_grand_mean(i_chan,1) - pow_grand_mean(i_chan,2);
    pow_grand_mean(i_chan,8) = pow_grand_mean(i_chan,6) - pow_grand_mean(i_chan,3);
    pow_grand_mean(i_chan,9) = pow_grand_mean(i_chan,5) - pow_grand_mean(i_chan,3);
    pow_grand_mean(i_chan,10) = pow_grand_mean(i_chan,4) - pow_grand_mean(i_chan,3);

end


channel = 28 % iz
figure('Position', [242,558,998,420]);
addpath('C:\Users\user\Desktop\circstat-matlab-master')
nBins = 36;
ax1 = polaraxes('Position',[-0.039278557114228,0.211904761904763,0.599999999999999,0.600000000000002],'Box','on');
CircHist(phase_out(:, 1, channel),  nBins, 'ax', ax1);
ax2 = polaraxes('Position',[0.395591182364728,0.219047619047621,0.599999999999999,0.600000000000004],'Box','on');
CircHist(phase_out(:, 2, channel),  nBins, 'ax', ax2);




figure('Position', [242,558,998,420]);
for i = 1:64
    channel = i;
    addpath('C:\Users\user\Desktop\circstat-matlab-master')
    nBins = 36;

    ax1 = polaraxes('Position',[-0.039278557114228,0.211904761904763,0.599999999999999,0.600000000000002],'Box','on');
    CircHist(phase_out(:, 1, channel),  nBins, 'ax', ax1);

    ax2 = polaraxes('Position',[0.395591182364728,0.219047619047621,0.599999999999999,0.600000000000004],'Box','on');
    CircHist(phase_out(:, 2, channel),  nBins, 'ax', ax2);

    drawnow;
end


load d:\chanlocs.mat
chanlocs = chanlocs(1:64);

%% objective
figure; hold on;
subplot(1,3,1)
topoplot(circ_grand_mean(:,1), chanlocs);
title('correct');
clim([0 360]);
hold off
subplot(1,3,2); hold on;
topoplot(circ_grand_mean(:,2), chanlocs);
title('incorrect');
clim([0 360]);
cbar;
hold off
subplot(1,3,3); hold on;
topoplot(circ_grand_mean(:,2)-circ_grand_mean(:,1), chanlocs, 'electrodes', 'labels');
title('difference [inc - corr]');
clim([-360 360]);
cbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TOPO PAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PAS1 vs PAS234
figure; hold on;
subplot(1,3,1)
pas234 = (circ_grand_mean(:,4) + circ_grand_mean(:,5) + circ_grand_mean(:, 6)) / 3;
topoplot(pas234, chanlocs);
title('pas234');
clim([0 360]);
hold off
subplot(1,3,2); hold on;
topoplot(circ_grand_mean(:,3), chanlocs);
title('pas1');
clim([0 360]);
cbar;
hold off
subplot(1,3,3); hold on;
topoplot(pas234 - circ_grand_mean(:,3), chanlocs, 'electrodes', 'labels');
title('difference [pas234 - pas1]');
clim([-360 360]);
cbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PAS1 vs PAS2
figure; hold on;
subplot(3,3,1)
pas234 = circ_grand_mean(:,4) + circ_grand_mean(:,5) + circ_grand_mean(:, 6) / 3;
topoplot(circ_grand_mean(:,4), chanlocs);
title('pas2');
clim([0 360]);
hold off
subplot(3,3,2); hold on;
topoplot(circ_grand_mean(:,3), chanlocs);
title('pas1');
clim([0 360]);
cbar;
hold off
subplot(3,3,3); hold on;
topoplot(circ_grand_mean(:,3) - circ_grand_mean(:,4), chanlocs, 'electrodes', 'labels');
title('difference [pas1 - pas2]');
clim([-360 360]);
cbar;

%% PAS1 vs PAS3
subplot(3,3,4)
topoplot(circ_grand_mean(:,5), chanlocs);
title('pas3');
clim([0 360]);
hold off
subplot(3,3,5); hold on;
topoplot(circ_grand_mean(:,3), chanlocs);
title('pas1');
clim([0 360]);
cbar;
hold off
subplot(3,3,6); hold on;
topoplot(circ_grand_mean(:,3) - circ_grand_mean(:,5), chanlocs, 'electrodes', 'labels');
title('difference [pas1 - pas3]');
clim([-360 360]);
cbar;

%% PAS1 vs PAS4
subplot(3,3,7)
topoplot(circ_grand_mean(:,6), chanlocs);
title('pas4');
clim([0 360]);
hold off
subplot(3,3,8); hold on;
topoplot(circ_grand_mean(:,3), chanlocs);
title('pas1');
clim([0 360]);
cbar;
hold off
subplot(3,3,9); hold on;
topoplot(circ_grand_mean(:,3) - circ_grand_mean(:,6), chanlocs, 'electrodes', 'labels');
title('difference [pas1 - pas4]');
clim([-360 360]);
cbar;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

channel = 29 % oz
figure('Position', [242,558,998,420]);
addpath('C:\Users\user\Desktop\circstat-matlab-master')
nBins = 36;
ax1 = polaraxes('Position',[-0.039278557114228,0.211904761904763,0.599999999999999,0.600000000000002],'Box','on');
CircHist(phase_out(:, 3, channel),  nBins, 'ax', ax1);
ax2 = polaraxes('Position',[0.395591182364728,0.219047619047621,0.599999999999999,0.600000000000004],'Box','on');
CircHist(phase_out(:, 5, channel),  nBins, 'ax', ax2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

channel = 28 % Iz
bar([X_bar(channel, 1), X_bar(channel, 2)])
bar([Y_bar(channel, 1), Y_bar(channel, 2)])
bar([cos_bar(channel, 1), cos_bar(channel, 2)])
bar([sin_bar(channel, 1), sin_bar(channel, 3)])


bar([X_bar(channel, 3), X_bar(channel, 4), X_bar(channel, 5), X_bar(channel, 6)])
bar([Y_bar(channel, 3), Y_bar(channel, 4), Y_bar(channel, 5), Y_bar(channel, 6)])

bar([cos_bar(channel, 3), cos_bar(channel, 4), cos_bar(channel, 5), cos_bar(channel, 6)])
bar([sin_bar(channel, 3), sin_bar(channel, 4), sin_bar(channel, 5), sin_bar(channel, 6)])