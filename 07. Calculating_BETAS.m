root = 'D:\Drive\1 - Threshold\';
pathTFData = [root '\tfdata\']
pathEEGData = [root '\MARA\']
mkdir(pathTFData, 'betas');
pathBETAS = [root '\tfdata\betas\']
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
eeglab nogui

listTFData=dir([pathTFData '*.mat'  ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData)



try
        load([root 'events.mat'])
catch
    for s=[1:participants]
        fileEEGData=listEEGData(s).name;
        EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
        EEG = pop_selectevent( EEG, 'type',[120 121 126 127 130 131 136 137 140 141 146 147 150 151 156 157] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        events{s} = EEG.event;
    end
end
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY

for s=1:length(listTFData)
    
    file=listTFData(s).name;
    
    B = regexp(file,'\d*','Match');
    listTFData(s).channel = str2num(B{1, 1})
    listTFData(s).participant = str2num(B{1, 2})
end

clear temp data y* x* beta*
for s=s:length(listTFData)
    participantID = listTFData(s).participant;
    channel = listTFData(s).channel;
    participant_event = events{participantID};
    temp = load([pathTFData listTFData(s).name]);
    data = abs(temp.tfdata);
    
    x = participant_event;
    x = rmfield(x, 'latency');
    x = rmfield(x, 'type');
    x = rmfield(x, 'epoch');
    x = rmfield(x, 'urevent');
    try
    x = rmfield(x, 'duration');
    catch
        
    end
    x = rmfield(x, 'identification');
    x = rmfield(x, 'detection');
    %x = rmfield(x, 'identification2');
    x = rmfield(x, 'corr_corr');
    %x = rmfield(x, 'oldepoch');
    
    empty_event = cellfun(@isempty, struct2cell(x));
    
    if sum(sum(empty_event)) > 0
        empty_event = squeeze(empty_event)';
        [empty_event_r, empty_event_c] = find(empty_event==1);
        x([empty_event_r]).pas = 1;
        x([empty_event_r]).detection2 = 0;
        x([empty_event_r]).identification2 = 0;
    end
    
    
    try
        x = single(transpose(cell2mat(squeeze(struct2cell(x)))));
    catch
        x = single(transpose(table2array(cell2table(squeeze(struct2cell(x))))));
    end
    
    
    
    
    x_standarized = ones(length(x), 1); % intercept
    x_standarized(:, 2) = zscore(x(:, 1)); % PAS
    x_standarized(:, 3) = zscore(x(:, 2)); % DETECTION
    x_standarized(:, 4) = zscore(x(:, 3)); % IDENTIFICATION
    x_standarized(:, 5) = x_standarized(:, 2).*x_standarized(:, 3); % interaction  DET X IDENTIFICATION
    x_standarized(:, 6) = x_standarized(:, 2).*x_standarized(:, 3).*x_standarized(:, 2); % interaction PAS X DET X IDENTIFICATION
    
    if isnan(x_standarized(:, 3)) % in case of submitting by the participant same answer during an experiment
        x_standarized(:, 3) = ones(length(x), 1);
        x_standarized(:, 5) = x_standarized(:, 2).*x_standarized(:, 3); % interaction  DET X IDENTIFICATION
        x_standarized(:, 6) = x_standarized(:, 2).*x_standarized(:, 3).*x_standarized(:, 2); % interaction PAS X DET X IDENTIFICATION
    end
    if isnan(x_standarized(:, 4)) % in case of submitting by the participant same answer during an experiment
        x_standarized(:, 4) = ones(length(x), 1);
        x_standarized(:, 5) = x_standarized(:, 2).*x_standarized(:, 3); % interaction  DET X IDENTIFICATION
        x_standarized(:, 6) = x_standarized(:, 2).*x_standarized(:, 3).*x_standarized(:, 2); % interaction PAS X DET X IDENTIFICATION
    end
    
    
    for (k=1:200)
        for(j=1:35)
            clear y* ;
            y = squeeze(data(j,k,:));
            y_standarized = zscore(y);
            %beta= mvregress( x_standarized,y_standarized); % mvregress(X, Y)
            beta= x_standarized\y_standarized; % mvregress(X, Y)
            
            beta_intercept(j, k) = beta(1,1);
            beta_pas(j, k) = beta(2, 1);
            beta_detection(j,k) = beta(3, 1);
            beta_identification(j,k) = beta(4,1);
            beta_interaction1(j, k) = beta(5, 1);
            beta_interaction2(j, k) = beta(6, 1);
        end
    end
    display(['procesujê: ' num2str(s) ' z ' num2str(length(listTFData)) ]);
    save([pathBETAS num2str(participantID) '_Betas_intercept_chann_' num2str(channel)], 'beta_intercept')
    save([pathBETAS num2str(participantID) '_Betas_pas_chann_' num2str(channel)], 'beta_pas')
    save([pathBETAS num2str(participantID) '_Betas_detection_chann_' num2str(channel)], 'beta_detection')
    save([pathBETAS num2str(participantID) '_Betas_identification_chann_' num2str(channel)], 'beta_identification')
    save([pathBETAS num2str(participantID) '_Betas_interaction1_chann_' num2str(channel)], 'beta_interaction1')
    save([pathBETAS num2str(participantID) '_Betas_interaction2_chann_' num2str(channel)], 'beta_interaction2')
    clear temp data y* x* beta* empty*
    
end