settings.paradigm = 3;
settings.confirmatory = 0;

addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
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
mkdir(pathTFData, 'betas_interaction_regress2');
pathBETAS = [pathTFData '\betas_interaction_regress2\'];
%eeglab nogui
listTFData=dir([pathTFData '*.mat'  ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData);
fileEEGData=listEEGData(1).name;
EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
[~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
close all
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY fileEEGData temp data_timef y* x* beta* EEG B file s
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats'
%load('D:\Drive\1 - Threshold\events_new3.mat')
load('D:\Drive\3 - Mask\events_new2.mat')
events_new = events_new2;
%participants_to_drop = [19933 32180 39332 41820 50935 81615 16942 19520
%20998 72974 22154]; % exp1
participants_to_drop = [41 66 103 142 145 162]  %[34375 50935 68100 84136 85124 93496 94182]; % exp3

load d:\chanlocs.mat
channels.CP1 = find(strcmp({chanlocs.labels}, 'CP1')==1);
channels.CPz = find(strcmp({chanlocs.labels}, 'CPz')==1);
channels.CP2 = find(strcmp({chanlocs.labels}, 'CP2')==1);
channels.P1 = find(strcmp({chanlocs.labels}, 'P1')==1);
channels.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1);
channels.P2 = find(strcmp({chanlocs.labels}, 'P2')==1);
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

settings.selected_channels = [channels.O1 channels.Oz channels.O2 channels.PO7 channels.PO8 channels.PO3 channels.PO4 channels.POz channels.Iz channels.P1 channels.Pz channels.P2 channels.P3 channels.P5 channels.P7 channels.P4 channels.P6];


for s=1:length(listTFData)
    if contains(listTFData(s).name, 'tfdata_chan_') == 1
        file=listTFData(s).name;
        B = regexp(file,'\d*','Match');
        listTFData(s).channel = str2num(B{1, 1});
        listTFData(s).participant = str2num(B{1, 2});
        if any(listTFData(s).participant == [participants_to_drop])   
            idx(s) = 1;
        else
            idx(s) = 0;
        end
        if any(listTFData(s).channel == [settings.selected_channels])   
            idx(s) = 0;
        else
            idx(s) = 1;
        end
        
    else
        idx(s) = 1;
    end
end
listTFData([idx]==1) = [];
clear idx

tTotal = 0;
addpath 'C:\Program Files\MATLAB\R2022b\toolbox\stats\stats';
for s=1:length(listTFData)
    tStart = tic;
    %clear participantID channel participant_event temp data_timef acc pas epoch y y_standarized data data_table* lme coefficients
    participantID = listTFData(s).participant;
    channel = listTFData(s).channel;
    %participant_event = events_new{participantID};
    data_timef = abs(load([pathTFData listTFData(s).name]).tfdata);
    data{participantID}(channel,:,:) = squeeze(mean(data_timef(1:9, 1:100, :), 1));
    tEnd = toc(tStart);
    tTotal = tTotal+tEnd;
    estimated_time = tEnd*(length(listTFData) - s);
    display(['procesuję: ' num2str(s) ' z ' num2str(length(listTFData)) '. Trwało: ' num2str(tEnd) 's.']);
    display(['Szacowany czas: ' num2str(estimated_time/60) 'min. Mineło: ' num2str(tTotal/60) 'min.' ]);
    clear betas acc pas x_input data_timef participant_event
end

clear X_train Y_train X-test Y_test SVMModel concatenated_data  predicted_labels_all scores predicted_labels X_test Y X Y_tests concatenated_labels concatenacted_Y concatenated_Y
num_participants = length(data);
concatenated_data = cell(1, num_participants);

for p = 1:num_participants
    [channels, timepoints, trials] = size(data{p});
    tmp = reshape(permute(data{p}(settings.selected_channels, :,:), [3, 1, 2]), trials, length(settings.selected_channels) * timepoints);
    concatenated_data{p} = tmp;
end
% Assuming 'labels' is a cell array with dimensions 1x160, where each cell contains a vector of labels for the corresponding participant


accuracies = zeros(1, num_participants);
for p = 1:num_participants
    tic
    if all(p ~= [participants_to_drop]) 
    % Get the data and labels for the current participant
    X = concatenated_data{p};
%     labels = [events_new{p}.accuracy];
%    labels([labels] == 0 ) = -1;
    labels = [events_new{p}.pas_resp];
    labels([labels] == 1) = 0;
    labels([labels] == 2) = 1;
    labels([labels] == 3) = 1;
    labels([labels] == 4) = 1;
    Y = labels;
    
    % Split the data into training and testing sets
    rng('default'); % For reproducibility
    cv = cvpartition(Y, 'Holdout', 0.2);
    X_train = X(cv.training,:);
    Y_train = Y(cv.training);
    X_test = X(cv.test,:);
    Y_test = Y(cv.test);
    
    % Train the SVM classifier with a linear kernel
    SVMModel = fitcsvm(X_train, Y_train, 'KernelFunction', 'linear', 'Standardize', true);

    % Predict the labels of the test set
    [predicted_labels, scores] = predict(SVMModel, X_test);
    
    Y_tests{p} = Y_test;
    predicted_labels_all{p} = predicted_labels;
    
    % Calculate the accuracy
    accuracy = sum(predicted_labels == Y_test) / length(Y_test);
    accuracies(p) = mean(accuracy);
    accuracy_objective(p) = sum(Y)/length(Y);
    alfa_mean(p) = mean(X, 'all');
    alfa_median(p) = median(X, 'all');
    alfa_std(p) = std(mean(X));
    clear predicted_labels scores accuracy Y_test X_test X_train Y_train labels Y X
    end
    toc
end

idx = [accuracies] == 0;
accuracies(idx) = [];
accuracy_objective(idx) = [];
alfa_mean(idx) = [];
alfa_median(idx) = [];
alfa_std(idx) = [];

% Calculate the average accuracy across participants
average_accuracy = mean(accuracies);
fprintf('Average Accuracy: %.2f%%\n', average_accuracy * 100);


% Initialize an empty array to store the concatenated data
concatenated_Y = [];
concatenated_labels = [];

% Loop through the cells and concatenate their contents
for i = 1:length(Y_tests)
    concatenated_Y = [concatenated_Y Y_tests{i}];
    concatenated_labels = [concatenated_labels; predicted_labels_all{i}];
end


figure;
cm = confusionmat(concatenated_Y, concatenated_labels);
confusionchart(cm);
title('Confusion Matrix');



figure;
title('Accuracy predicition across participants')
plot(1:length(accuracies), accuracies)
hold on; 
%plot(1:length(accuracies), accuracy_objective)
%hold off
yyaxis right

plot(1:length(accuracies), alfa_median)
legend('accuracy of prediction', 'user responses', 'median alpha')
    