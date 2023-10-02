% Load the event data
load('D:\Drive\4 - Faces\events_new2.mat');
%load('D:\Drive\5 - Scenes\events.mat');
%events_new2 = events;
%root = 'D:\Drive\5 - Scenes\';
root = 'D:\Drive\4 - Faces\';
pathLoadData= [root '\MARA\'];
list=dir([pathLoadData '*.set'  ]);
file=list(1).name;
EEG = pop_loadset('filename',file,'filepath',pathLoadData);

[ersp,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
clear ersp itc powbase erspboot itcboot itcphase PLUGINS STUDY 
timewindow = times > -1200 & times < -500; %scenes + faces
% Define the conditions
conditions_accuracy = {'0', '1'};
conditions_PAS = {'1', '2', '3', '4'};

% Iterate over each participant
for p = 1:length(events_new2)

    % Check if the events file exists
    if isempty(events_new2{p}) == 0

        % Load the events for the current participant
        events = events_new2{p};

        % Iterate over each channel
        for c = 1:64

            % Check if the events file exists
            if exist([root 'tfdata\tfdata_chan_' num2str(c) '_participant_' num2str(p) '.mat'], 'file')  == 0
                flag = 0;
                continue;
            else
                % Load the time-frequency data for the current participant
                tfdata = load([root 'tfdata\tfdata_chan_' num2str(c) '_participant_' num2str(p) '.mat']);


                % Compute the power spectral density for each epoch using the Morlet wavelet
                psd = abs(tfdata.tfdata(:,timewindow,:)).^2;

                % Sum the power spectral density over time to obtain the power spectrum
                ps = mean(psd, 2);

                % Extract the power spectral density for the current channel
                psd_channel = squeeze(ps);

                psd_all(c, :, :) = psd_channel;
                flag = 1;

            end

        end
        if flag == 1
            save([root '\pwelch_fromMorlet2\psd_' num2str(p) '.mat'], "psd_all");
            clear ps*
        end
    end
end

