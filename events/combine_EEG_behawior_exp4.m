% raw files
fileType = 1; % 1 - raw (bdf); 0 - .set file
paradigm = 4; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes; 6 - Kinga



addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2022b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2022b\toolbox\stats\stats\')
clear opts
opts  = [];
opts = delimitedTextImportOptions("NumVariables", 41, "Encoding", "UTF-8");

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["x", "y", "orientation", "stimFile", "maskFile", "maskIndicator", "thisRepN", "thisTrialN", "thisN", "thisIndex", "stepSize", "intensity", "image_name", "global_start_time", "global_end_time", "pressKey", "pressRT", "releaseRT", "image_started", "image_ended", "name", "globalTime", "fixation_dur", "stimulation_dur", "post_fixation", "opacity", "orientationResponse_pressKey", "orientationResponse_pressRT", "orientationResponse_releaseRT", "pasResponse_pressKey", "pasResponse_pressRT", "pasResponse_releaseRT", "image", "mask", "orientation1", "response", "finalOpacity", "postOri", "ID", "frameRate", "VarName41"];
opts.VariableTypes = ["double", "double", "double", "string", "double", "double", "double", "double", "double", "double", "double", "double", "string", "double", "double", "double", "double", "double", "double", "double", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "double", "double", "double", "double", "double", "double", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["stimFile", "image_name", "VarName41"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["stimFile", "image_name", "name", "image", "VarName41"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["maskFile", "mask"], "TrimNonNumeric", true);
opts = setvaropts(opts, ["maskFile", "mask"], "ThousandsSeparator", ",");

%%

if  paradigm == 1
    root = 'D:\Drive\1 - Threshold\';
    path_csvs = 'D:\Drive\behawior\Gabor\';
elseif  paradigm == 2
    root = 'D:\Drive\2 - Cue\';
elseif  paradigm == 3
    root = 'D:\Drive\3 - Mask\';
    path_csvs = 'D:\Drive\behawior\Mask\';
elseif  paradigm == 4
    root = 'D:\Drive\4 - Faces\';
    path_csvs = 'D:\Drive\behawior\Faces\';
elseif  paradigm == 5
    root = 'D:\Drive\5 - Scenes\';
    load('D:\Drive\5 - Scenes\behawior.mat')
elseif  paradigm == 6
    root='D:\Drive\6 - Kinga\';
end

if  fileType == 0
    pathLoadData = [root '\Preprocessed\']
    listEEGraw=dir([pathLoadData '\*.set'  ])
elseif  fileType == 1
    pathLoadData = [root '\raw\']
    listEEGraw=dir([pathLoadData '\*.bdf'  ])
end

pathEEGData = [root '\MARA\'];
listEEGData=dir([pathEEGData '*.set'  ]);

eeglab nogui
list_csvs = dir([path_csvs '*.csv'])


participantsRAW = length(listEEGraw)
participantsMARA = length(listEEGData)


for i=1:length(listEEGraw)
    if i ~= 82 
        % missing csv:
        % 84330
        clear temp_list id
        id = listEEGraw(i).name(1:5);
        for n = 1:length(list_csvs)
            temp_list(n) = any(contains(string([id]), list_csvs(n).name(1:5)));
        end
        temp_beh = list_csvs(temp_list);
        temp_max = find([temp_beh.bytes]==max([temp_beh.bytes]));
        if length(temp_max) > 1
            temp_beh = temp_beh(temp_max(1));
        else
            temp_beh = temp_beh(temp_max);
        end

        EEG_data_raw(i) = listEEGraw(i);
        behawior(i) = temp_beh;
        clear temp_beh temp_max
    end
end



for s=[s:length(EEG_data_raw)]
    if ~any(s==[82 61 62 63])
        % id 61 & 62 is splitted - merged file is 63, but still has some
        % issues
        clear idx curr_behawior 
        file=EEG_data_raw(s).name;
        beh = behawior(s).name;

        % Import the data
        curr_behawior = readtable([list_csvs(1).folder '\' beh], opts);

        %startLine = find(curr_behawior.name == 'session');
        %startLine2 = startLine(11);
        %opts2.DataLines = [startLine2, Inf];
        %curr_behawior(isnan(curr_behawior.postOri), :) = [];
        curr_behawior(isnan(curr_behawior.pasResponse_pressKey), :) = [];
        %idx = find([curr_behawior.x] == any([1 2]))
        for i = 1:size(curr_behawior, 1)
            if curr_behawior.x(i) == 1 | curr_behawior.x(i) == 2
            idx(i) = 1;
            else
                idx(i) = 0;
            end
        end
        curr_behawior = curr_behawior(logical(idx), :);
        if size(curr_behawior, 1) > 100


            EEG = pop_biosig([pathLoadData '\' file], 'importevent','on');

            for(n=1: length(EEG.event))
                EEG.event(n).type = EEG.event(n).type - 65280;
            end


            i = 1;
            while ( EEG.event(i).type~=206)						%marking staircase values
                EEG.event(i).type = EEG.event(i).type+300;
                i=i+1;
            end

            idx_10 = [EEG.event.type] == 10;
            idx_10_1 = find([idx_10] ==1);
            idx_stimulus = [idx_10_1] + 1;
            idx_response = [idx_10_1] + 2;
            idx_pas = [idx_10_1] + 3;

            eventy = EEG.event(idx_stimulus);
            for i = 1:length(eventy)
                eventy(i).epoch = i;
            end
            eventy2 = []

            if size(curr_behawior, 1) == length(eventy)
                eventy2 = struct2table(eventy);
                eventy2 = cat(2, eventy2, curr_behawior);
                events{1, s} = eventy2;
                events{2, s} = {EEG_data_raw(s).name};
                events{3, s} = beh;
                events{4, s} = 0;
            else
                eventy2 = struct2table(eventy);
                eventy2 = cat(2, eventy2, curr_behawior);
                events{1, s} = 0;
                display('wrong size of events or behawior!');
                events{2, s} = {EEG_data_raw(s).name};
                events{3, s} = beh;
                events{4, s} = eventy2;
            end
        end
    end
end



save('D:\Drive\Behawior\faces_behawior_eeg.mat', "events");





%%%%%%%%%%%%%%%%%%%%%
%load removed epochs?
%load mara folder EEG listEEGData


events_new = [];
eventy_new = [];
for s=1:length(listEEGData)
    if ~any(s==[82 61 62 63])
         clear file
        file=listEEGData(s).name;
        id = file(1:5)
        for i = 1:length(events)
            if ~isempty(events{2, i}) & all(events{2, i}{1}(1:5) == id)
                idx(i) = 1;
            else
                idx(i) = 0;
            end
        end
        current = events{:, logical(idx)}
        clear idx
        %file = listEEGraw(s).name(1:end-3);
        %file = file + "set"
        %id = file{1}(1:5)
        %EEG = pop_loadset('filename',file{1},'filepath',listEEGData(s).folder);

        EEG = pop_loadset('filename',file,'filepath',listEEGData(s).folder);
        clear curr_events curr_events2 idx idx_id
        curr_events = current
        curr_events2 = EEG.event;
        for i = 1 :size(curr_events,1)
            if length(find(curr_events.urevent(i) == [curr_events2.urevent])) > 0
                idx_id(i) = find(curr_events.urevent(i) == [curr_events2.urevent]);
                idx(i) = 1;
            else
                idx(i) = 0;
            end
        end
        event = curr_events(logical(idx),:);
        clear idx
        %eventy_new = cat(1, events_new, event)
        events_new{1, s} = event;
        events_new{2, s} = id;


%         if all(events{2, s}{1,1}(1:5) == id) & size(events{1,s}, 1) > 1
%             curr_events = events{1,s};
%             curr_events2 = EEG.event;
%             for i = 1 :size(curr_events,1)
%                 if length(find(curr_events.urevent(i) == [curr_events2.urevent])) > 0
%                     idx_id(i) = find(curr_events.urevent(i) == [curr_events2.urevent]);
%                     idx(i) = 1;
%                 else
%                     idx(i) = 0;
%                 end
%             end
%             event = curr_events(logical(idx),:);
%             %eventy_new = cat(1, events_new, event)
%             events_new{1, s} = event;
%             events_new{2, s} = id;
%         else
%             events_new{1, s} = 0;
%             events_new{2, s} = id;
%         end
%     end
    end
end
save('D:\Drive\4 - Faces\events_new.mat', "events_new");




% 
% for i = 1 :size(curr_events{1,1},1)
%     if length(find(curr_events{1,1}.urevent(i) == [curr_events2.urevent])) > 0
%         idx_id(i) = find(curr_events{1,1}.urevent(i) == [curr_events2.urevent])
%         idx(i) = 1;
%     else
%         idx(i) = 0;
%     end
% end
% test = curr_events{1,1};
% test2 = test(logical(idx), :)




