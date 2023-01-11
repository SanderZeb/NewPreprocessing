clear all
for paradigm = [1 : 5]
    settings.paradigm = paradigm;
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
    pathEEGData = [root '\MARA\'];

    
    listEEGData=dir([pathEEGData '*.set'  ]);
    participants = length(listEEGData);
    load([root 'events.mat']);
    data(settings.paradigm, :).events = events;
    data(settings.paradigm, :).list = [listEEGData];
    
    

    for s=[1:participants]
        id = listEEGData(s).name;
        fileALLinfoData(paradigm,s, :) = listEEGData(s);
        indexfileEEGData(paradigm, s,:)=s;
        if length(listEEGData(s).name) == 9
            fileEEGData(paradigm, s, :)=string(listEEGData(s).name(1:end-4));
        elseif length(listEEGData(s).name) == 11
            fileEEGData(paradigm, s,:)=string(listEEGData(s).name(1:end-6));
        elseif length(listEEGData(s).name) == 5
            fileEEGData(paradigm, s,:)=string(listEEGData(s).name(1:end));
        end
    end
end

allFiles = reshape(fileALLinfoData, 1, [5*length(fileALLinfoData)]);
allIndexes = reshape(indexfileEEGData, 1, [5*length(indexfileEEGData)]);

sizes = strlength(fileEEGData);
if max(max(sizes)) ~= min(min(sizes))
    display('somewhere there is an wrongly named EEG file');
end


unique_participants = unique(fileEEGData);
paths = [];
paths.id = [];


for i =1:length(unique_participants)
    curr_participant = unique_participants(i);
    paths(i).id = curr_participant;
    paths(i).exp1 = 0;
    paths(i).pathEXP1 = 0;
    paths(i).sizeEXP1 = 0;
    paths(i).dateEXP1 = 0;
    paths(i).fNameEXP1 = 0;
    paths(i).eventsEXP1 = 0;
    paths(i).exp2 = 0;
    paths(i).pathEXP2 = 0;
    paths(i).sizeEXP2 = 0;
    paths(i).dateEXP2 = 0;
    paths(i).fNameEXP2 = 0;
    paths(i).eventsEXP2 = 0;
    paths(i).exp3 = 0;
    paths(i).pathEXP3 = 0;
    paths(i).sizeEXP3 = 0;
    paths(i).dateEXP3 = 0;
    paths(i).fNameEXP3 = 0;
    paths(i).eventsEXP3 = 0;
    paths(i).exp4 = 0;
    paths(i).pathEXP4 = 0;
    paths(i).sizeEXP4 = 0;
    paths(i).dateEXP4 = 0;
    paths(i).fNameEXP4 = 0;
    paths(i).eventsEXP4 = 0;
    paths(i).exp5 = 0;
    paths(i).pathEXP5 = 0;
    paths(i).sizeEXP5 = 0;
    paths(i).dateEXP5 = 0;
    paths(i).fNameEXP5 = 0;
    paths(i).eventsEXP5 = 0;
    exps = find(strcmp(fileEEGData, curr_participant));
    paths(i).exps = length(exps);
    participant_idx = strcmp(fileEEGData, curr_participant);
    exps_id = find(participant_idx == 1);
    for n=1:length(exps)
        curr_exp = exps(n);
        if contains(allFiles(curr_exp).folder, '1 - Threshold')
            paths(i).exp1 = 1;
            paths(i).pathEXP1 = [allFiles(curr_exp).folder '\' allFiles(curr_exp).name];
            paths(i).sizeEXP1 = allFiles(curr_exp).bytes;
            paths(i).dateEXP1 = allFiles(curr_exp).bytes;
            paths(i).fNameEXP1 = allFiles(curr_exp).name;
            paths(i).eventsEXP1 = data(1).events{allIndexes(curr_exp)};
        elseif contains(allFiles(curr_exp).folder, '2 - Cue')
            paths(i).exp2 = 1;
            paths(i).pathEXP2 = [allFiles(curr_exp).folder '\' allFiles(curr_exp).name];
            paths(i).sizeEXP2 = allFiles(curr_exp).bytes;
            paths(i).dateEXP2 = allFiles(curr_exp).bytes;
            paths(i).fNameEXP2 = allFiles(curr_exp).name;
            paths(i).eventsEXP2 = data(2).events{allIndexes(curr_exp)};
        elseif contains(allFiles(curr_exp).folder, '3 - Mask')
            paths(i).exp3 = 1;
            paths(i).pathEXP3 = [allFiles(curr_exp).folder '\' allFiles(curr_exp).name];
            paths(i).sizeEXP3 = allFiles(curr_exp).bytes;
            paths(i).dateEXP3 = allFiles(curr_exp).bytes;
            paths(i).fNameEXP3 = allFiles(curr_exp).name;
            paths(i).eventsEXP3 = data(3).events{allIndexes(curr_exp)};
        elseif contains(allFiles(curr_exp).folder, '4 - Faces')
            paths(i).exp4 = 1;
            paths(i).pathEXP4 = [allFiles(curr_exp).folder '\' allFiles(curr_exp).name];
            paths(i).sizeEXP4 = allFiles(curr_exp).bytes;
            paths(i).dateEXP4 = allFiles(curr_exp).bytes;
            paths(i).fNameEXP4 = allFiles(curr_exp).name;
            paths(i).eventsEXP4 = data(4).events{allIndexes(curr_exp)};
        elseif contains(allFiles(curr_exp).folder, '5 - Scenes')
            paths(i).exp5 = 1;
            paths(i).pathEXP5 = [allFiles(curr_exp).folder '\' allFiles(curr_exp).name];
            paths(i).sizeEXP5 = allFiles(curr_exp).bytes;
            paths(i).dateEXP5 = allFiles(curr_exp).bytes;
            paths(i).fNameEXP5 = allFiles(curr_exp).name;
            paths(i).eventsEXP5 = data(5).events{allIndexes(curr_exp)};
        else
            display('ERROR');
            break;
        end

    end
end


save('C:\Users\user\Desktop\app_test\paths.mat', 'paths')
