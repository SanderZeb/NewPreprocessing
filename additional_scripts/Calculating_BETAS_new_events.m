settings.paradigm = 4;
settings.inverted = 0;
settings.intercept = 0;
settings.confirmatory = 1;
%
% if n ==1
%     settings.inverted = 1;
%     settings.intercept = 0;
% elseif n==2
%     settings.inverted = 1;
%     settings.intercept = 1;
% elseif n==3
%     settings.inverted = 0;
%     settings.intercept = 1;
% elseif n==4
%     settings.inverted = 0;
%     settings.intercept = 0;
% end

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
if settings.inverted== 1 & settings.intercept== 1
    mkdir(pathTFData, 'betas_odwrotne_intercept');
    pathBETAS = [pathTFData '\betas_odwrotne_intercept\']
elseif settings.inverted== 1 & settings.intercept== 0
    mkdir(pathTFData, 'betas_odwrotne');
    pathBETAS = [pathTFData '\betas_odwrotne\']
elseif settings.inverted == 0 & settings.intercept== 1
    mkdir(pathTFData, 'betas_intercept');
    pathBETAS = [pathTFData '\betas_intercept\']
elseif settings.inverted== 0 & settings.intercept== 0
    mkdir(pathTFData, 'betas');
    pathBETAS = [pathTFData '\betas\']
end
addpath 'C:\Users\user\Desktop\eeglab-eeglab2021.0'
addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
eeglab nogui

listTFData=dir([pathTFData '*.mat'  ]);
listEEGData=dir([pathEEGData '*.set'  ]);
participants = length(listEEGData)

try
    load([root 'events_new2.mat'])
    events_new = events_new2;
    fileEEGData=listEEGData(1).name;
    EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
catch
    for s=[1:participants]
        fileEEGData=listEEGData(s).name;
        EEG = pop_loadset('filename',fileEEGData,'filepath',pathEEGData);
        if settings.paradigm == 1
            EEG = pop_selectevent( EEG, 'type',[120 121 126 127 130 131 136 137 140 141 146 147 150 151 156 157] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 2
            addpath 'C:\Users\user\Documents\GitHub\NewPreprocessing\helpers'
            EEG = events_cue_assign_stim_to_cue(EEG)
            EEG = pop_selectevent( EEG, 'type',[61 62 63 64] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 3
            EEG = pop_selectevent( EEG, 'type',[100 101 106 107] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 4
            EEG = pop_selectevent( EEG, 'type',[103 104] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
        elseif settings.paradigm == 5
            %EEG = pop_selectevent( EEG, 'type',[20 21 120 121 40 41 140 141 80 81 180 181 30 31 130 131 50 51 150 151 90 91 190 191] ,'deleteevents','on','deleteepochs','on','invertepochs','off');
            display('KONIECZNY DEBUGGING MARKERÓW IDENTIFICATION!');
        end
        events{s} = EEG.event;
    end
    %save([root 'events.mat'], 'events');
end
clear ALLCOM ALLEEG CURRENTSET CURRENTSTUDY globalvars LASTCOM PLUGINLIST STUDY fileEEGData

for s=1:length(listTFData)
    
    file=listTFData(s).name;
    
    B = regexp(file,'\d*','Match');
    listTFData(s).channel = str2num(B{1, 1})
    listTFData(s).participant = str2num(B{1, 2})
end

[~,~,~,settings.times,settings.freqs,~,~] = newtimef(EEG.data(1,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 8], 'freqs', [6 40], 'baseline', NaN);
clear temp data_timef y* x* beta* EEG B file s
close all
    clear temp data_timef y* x* beta* empty* participant_event participantID channel id_to_drop
for s=1:length(listTFData)
    participantID = listTFData(s).participant;
    channel = listTFData(s).channel;
    
    if ~isempty(events_new{1, participantID}) & size(events_new{1, participantID},1) ~= 0  & ~any(participantID==[163]) % ~any(participantID==[31 40 41 42 66 103 130 142 145 162 163 164 165 166 167 168])
    participant_event = events_new{1, participantID};
    temp = load([pathTFData listTFData(s).name]);
    data_timef = abs(temp.tfdata);
    
    
    
    %to_include = [participant_event.epoch];
    
    %data_timef = data_timef(:,:,to_include);
    %data_timef = data_timef(:,:,:);
    
    
    participant_event = removevars(participant_event, ["thisRepN","thisTrialN","thisN","thisIndex","stepSize","intensity","image_name","global_start_time", ...
        "global_end_time","pressKey","pressRT","releaseRT","image_started","image_ended","name","globalTime","fixation_dur","stimulation_dur","post_fixation", ...
        "opacity","orientationResponse_pressRT","orientationResponse_releaseRT","pasResponse_pressRT","pasResponse_releaseRT","response","finalOpacity","postOri", ...
        "ID","frameRate","VarName35", "urevent", "latency", "x", "y"]);

    x = participant_event;

    for i=1:size(x, 1)
        if x.orientationResponse_pressKey(i) == 0
            x.resp(i) = 100;
        elseif x.orientationResponse_pressKey(i) == 1
            x.resp(i) = 101;
        elseif x.orientationResponse_pressKey(i) == 6
            x.resp(i) = 106;
        elseif x.orientationResponse_pressKey(i) == 7
            x.resp(i) = 107;
        end

        if x.pasResponse_pressKey(i) == 0
            x.pas(i) = 1;
        elseif x.pasResponse_pressKey(i) == 1
            x.pas(i) = 2;
        elseif x.pasResponse_pressKey(i) == 6
            x.pas(i) = 3;
        elseif x.pasResponse_pressKey(i) == 7
            x.pas(i) = 4;
        end

        if x.type(i) == x.resp(i)
            x.corr_corr(i) = 1;
        else
            x.corr_corr(i) = 0;
        end



    end
    x = removevars(x, ["type","orientation","orientationResponse_pressKey","pasResponse_pressKey","resp","epoch"]);

%     x = rmfield(x, 'type');
%     x = rmfield(x, 'latency');
%     x = rmfield(x, 'urevent');
%     x = rmfield(x, 'epoch');
%     
%     
%     x = rmfield(x, 'identification');
%     if settings.paradigm == 1 | settings.paradigm == 2
%         x = rmfield(x, 'detection');
%         %x = rmfield(x, 'identification2');
%         x = rmfield(x, 'corr_corr');
%         %x = rmfield(x, 'oldepoch');
%     end
%     
%     if settings.paradigm == 3 | settings.paradigm == 4
%         x = rmfield(x, 'stimulus');
%     end
%     empty_event = cellfun(@isempty, struct2cell(x));
%     empty_events(s) = sum(sum(empty_event));
%     
%     if sum(sum(empty_event)) > 0
%         empty_event = squeeze(empty_event)';
%         [empty_event_r, empty_event_c] = find(empty_event==1);
%         %         if length(unique(empty_event_r)) == 1
%         %             x([unique(empty_event_r)]).pas = 1;
%         %             x([unique(empty_event_r)]).detection2 = 0;
%         %             x([unique(empty_event_r)]).identification2 = 0;
%         %
%         %         end
%         id_to_drop = unique(empty_event_r)
%     else
%         id_to_drop = [];
%     end
%     
%     x([id_to_drop]) = [];
%     try
%         x = single(transpose(cell2mat(squeeze(struct2cell(x)))));
%     catch
%         x = single(transpose(table2array(cell2table(squeeze(struct2cell(x))))));
%     end
    id_to_drop = [];
 x = single(transpose(table2array(x))).';   
    
    
    if settings.intercept == 1
        
        addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
        if settings.paradigm == 1 | settings.paradigm == 2
            x_standarized = ones(length(x), 1); % intercept
            x_standarized(:, 2) = zscore(x(:, 1)); % PAS
            x_standarized(:, 3) = zscore(x(:, 2)); % DETECTION
            x_standarized(:, 4) = zscore(x(:, 3)); % IDENTIFICATION
            x_standarized(:, 5) = x_standarized(:, 2).*x_standarized(:, 3); % interaction  DET X IDENTIFICATION
            x_standarized(:, 6) = x_standarized(:, 2).*x_standarized(:, 3).*x_standarized(:, 2); % interaction PAS X DET X IDENTIFICATION
            
        elseif settings.paradigm == 3 | settings.paradigm == 4
            x_standarized = ones(length(x), 1); % intercept
            x_standarized(:, 2) = zscore(x(:, 1)); % PAS
            x_standarized(:, 3) = zscore(x(:, 2)); % IDENTIFICATION
            x_standarized(:, 4) = x_standarized(:, 2).*x_standarized(:, 3); % interaction  PAS X IDENTIFICATION
            
            
            
            
        end
        
        for (k=1:length(settings.times))
            for(j=1:length(settings.freqs))
                clear y* ;
                y = squeeze(data_timef(j,k,:));
                if length(x) ~= length(y)
                    y(id_to_drop) = [];
                end
                y_standarized = zscore(y);
                %beta= mvregress( x_standarized,y_standarized); % mvregress(X, Y)
                if settings.inverted == 0
                    beta= x_standarized\y_standarized; % mvregress(X, Y)
                elseif settings.inverted == 1
                    beta= y_standarized\x_standarized; % mvregress(X, Y)
                    % betas needs to be transposed
                    beta = beta';
                end
                
                if settings.paradigm == 1 | settings.paradigm == 2
                    beta_intercept(j, k) = beta(1,1);
                    beta_pas(j, k) = beta(2, 1);
                    beta_detection(j,k) = beta(3, 1);
                    beta_identification(j,k) = beta(4,1);
                    beta_interaction1(j, k) = beta(5, 1);
                    beta_interaction2(j, k) = beta(6, 1);
                elseif settings.paradigm == 3 | settings.paradigm == 4
                    beta_intercept(j, k) = beta(1,1);
                    beta_pas(j, k) = beta(2, 1);
                    beta_identification(j,k) = beta(3,1);
                    beta_interaction1(j, k) = beta(4, 1);
                end
            end
        end
        display(['procesujê: ' num2str(s) ' z ' num2str(length(listTFData)) ]);
        if settings.paradigm == 1 | settings.paradigm == 2
            save([pathBETAS num2str(participantID) '_Betas_intercept_chann_' num2str(channel)], 'beta_intercept')
            save([pathBETAS num2str(participantID) '_Betas_pas_chann_' num2str(channel)], 'beta_pas')
            save([pathBETAS num2str(participantID) '_Betas_detection_chann_' num2str(channel)], 'beta_detection')
            save([pathBETAS num2str(participantID) '_Betas_identification_chann_' num2str(channel)], 'beta_identification')
            save([pathBETAS num2str(participantID) '_Betas_interaction1_chann_' num2str(channel)], 'beta_interaction1')
            save([pathBETAS num2str(participantID) '_Betas_interaction2_chann_' num2str(channel)], 'beta_interaction2')
        elseif settings.paradigm == 3 | settings.paradigm == 4
            save([pathBETAS num2str(participantID) '_Betas_intercept_chann_' num2str(channel)], 'beta_intercept')
            save([pathBETAS num2str(participantID) '_Betas_pas_chann_' num2str(channel)], 'beta_pas')
            save([pathBETAS num2str(participantID) '_Betas_identification_chann_' num2str(channel)], 'beta_identification')
            save([pathBETAS num2str(participantID) '_Betas_interaction1_chann_' num2str(channel)], 'beta_interaction1')
        end
        
        
    elseif settings.intercept == 0
        
        addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
        if settings.paradigm == 1 | settings.paradigm == 2
            x_standarized(:, 1) = zscore(x(:, 1)); % PAS
            x_standarized(:, 2) = zscore(x(:, 2)); % DETECTION
            x_standarized(:, 3) = zscore(x(:, 3)); % IDENTIFICATION
        end
        
        if settings.paradigm == 3 | settings.paradigm == 4
            x_standarized(:, 1) = zscore(x(:, 1)); % PAS
            x_standarized(:, 2) = zscore(x(:, 2)); % IDENTIFICATION
        end
        
        
        
        for (k=1:length(settings.times))
            for(j=1:length(settings.freqs))
                clear y* ;
                y = squeeze(data_timef(j,k,:));
                y(id_to_drop) = [];
                y_standarized = zscore(y);
                %beta= mvregress( x_standarized,y_standarized); % mvregress(X, Y)
                if settings.inverted == 0
                    beta= x_standarized\y_standarized; % mvregress(X, Y)
                elseif settings.inverted == 1
                    beta= y_standarized\x_standarized; % mvregress(X, Y)
                    % special cse for inverted beta equation
                    beta = beta';
                end
                
                if settings.paradigm == 1 | settings.paradigm == 2
                    beta_pas(j, k) = beta(1, 1);
                    beta_detection(j,k) = beta(2, 1);
                    beta_identification(j,k) = beta(3,1);
                elseif settings.paradigm == 3 | settings.paradigm == 4
                    beta_pas(j, k) = beta(1, 1);
                    beta_identification(j,k) = beta(2,1);
                end
                
            end
        end
        display(['procesujê: ' num2str(s) ' z ' num2str(length(listTFData)) ]);
        %display(['currently found ' num2str(sum(empty_events)) ]);
        if settings.paradigm == 1 | settings.paradigm == 2
            save([pathBETAS num2str(participantID) '_Betas_pas_chann_' num2str(channel)], 'beta_pas')
            save([pathBETAS num2str(participantID) '_Betas_detection_chann_' num2str(channel)], 'beta_detection')
            save([pathBETAS num2str(participantID) '_Betas_identification_chann_' num2str(channel)], 'beta_identification')
        elseif settings.paradigm == 3 | settings.paradigm == 4
            save([pathBETAS num2str(participantID) '_Betas_pas_chann_' num2str(channel)], 'beta_pas')
            save([pathBETAS num2str(participantID) '_Betas_identification_chann_' num2str(channel)], 'beta_identification')
        end
    end
    clear temp data_timef y* x* beta* empty* participant_event participantID channel id_to_drop
    end
end
