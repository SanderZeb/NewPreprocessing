behawior = 'C:\Users\user\Desktop\Behawior\Scenes\';
root1 = 'D:\Drive\5 - Scenes';
pathEEGData1 = [root1 '\MARA\']
listEEGData1=dir([pathEEGData1 '*.set'  ]);


listBehawior=dir([behawior '*.csv'  ]);




clear list
for i = 1:length(listBehawior)
    list{i} = listBehawior(i).name;
end

beh_all = [];
for s=1:length(listEEGData1)

    file=listEEGData1(s).name;
    B = regexp(file,'\d*','Match');
    EEGindex = string(B{1});
    beh = startsWith(list,EEGindex);
    listBehawior2 = listBehawior(beh);
    if length(listBehawior2) == 2
        if listBehawior2(1).bytes == listBehawior2(2).bytes
            listBehawior2(2) = [];
        elseif listBehawior2(1).bytes > listBehawior2(2).bytes
            listBehawior2(2) = [];
        elseif listBehawior2(1).bytes < listBehawior2(2).bytes
            listBehawior2(1) = [];
        else
            display('check manually');
        end
    elseif length(listBehawior2) > 2
        listBehawior2(find(min([listBehawior2.bytes]) == [listBehawior2.bytes])) = [];
        if length(listBehawior2) == 2
            if listBehawior2(1).bytes == listBehawior2(2).bytes
                listBehawior2(2) = [];
            elseif listBehawior2(1).bytes > listBehawior2(2).bytes
                listBehawior2(2) = [];
            elseif listBehawior2(1).bytes < listBehawior2(2).bytes
                listBehawior2(1) = [];
            else
                display('check manually');
            end
        else

            display('check manually');
        end
    end
    if length(listBehawior2) > 0

        beh_all = cat(2, beh_all, (listBehawior2));
    end
end



clear behawior B beh EEGindex file i list listBehawior listBehawior2
behawior = [];
for i = 1:length(beh_all)
    curr_file = [beh_all(i).folder '\' beh_all(i).name];
    %% Set up the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 52, "Encoding", "UTF-8");

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["stim", "pair", "object", "background", "congruency", "duration", "duration_id", "subset", "id", "tasktype", "tasktype_id", "stim_id", "mask", "path", "timing", "thisRepN", "thisTrialN", "thisN", "thisIndex", "version", "task_order", "image_name", "global_start_time", "global_end_time", "pressKey", "pressRT", "releaseRT", "image_started", "image_ended", "name", "globalTime", "fixation_dur", "stimulation_dur", "post_fixation", "opacity", "trigger", "locationResponse_pressKey", "locationResponse_pressRT", "locationResponse_releaseRT", "pasResponse_pressKey", "pasResponse_pressRT", "pasResponse_releaseRT", "image", "stimulus_duration_ms", "stimulus_duration_frames", "mask_duration_frames", "task_type", "displayed_object", "displayed_background", "pair1", "ID", "frameRate"];
    opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "double", "double", "double", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["path", "image"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["tasktype", "path", "name", "image"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, ["stim", "mask", "image_name"], "TrimNonNumeric", true);
    opts = setvaropts(opts, ["stim", "mask", "image_name"], "ThousandsSeparator", ",");
    current_table = readtable(curr_file, opts);

    behawior = cat(1, behawior, current_table) ;

end


for i = 1:size(behawior,1)
    if strlength(behawior.image(i)) > 0
        idx(i) = 0;
    else
        idx(i)=1;
    end
end

behawior(idx==1, :) = [];

save([root1 '\behawior.mat'], 'behawior');


% TASK TYPE
% 0 <-- object
% 1 <-- background

% OBJECT / BACKGROUND
% 0 <-- man made background /object
% 1 <-- natural background / animal
for i = 1:size(behawior,1)
    if behawior.task_type(i) == 0
        if behawior.version(i) == 1
            if behawior.locationResponse_pressKey(i) == 1 & behawior.object(i) == 1
                behawior.corrected_id(i) = 0;
            end
            if behawior.locationResponse_pressKey(i) == 1 & behawior.object(i) == 0
                behawior.corrected_id(i) = 1;
            end
            if behawior.locationResponse_pressKey(i) == 6 & behawior.object(i) == 1
                behawior.corrected_id(i) = 1;
            end
            if behawior.locationResponse_pressKey(i) == 6 & behawior.object(i) == 0
                behawior.corrected_id(i) = 0;
            end
        end
        if behawior.version(i) == 2
            if behawior.locationResponse_pressKey(i) == 1 & behawior.object(i) == 1
                behawior.corrected_id(i) = 1;
            end
            if behawior.locationResponse_pressKey(i) == 1 & behawior.object(i) == 0
                behawior.corrected_id(i) = 0;
            end
            if behawior.locationResponse_pressKey(i) == 6 & behawior.object(i) == 1
                behawior.corrected_id(i) = 0;
            end
            if behawior.locationResponse_pressKey(i) == 6 & behawior.object(i) == 0
                behawior.corrected_id(i) = 1;
            end
        end
    elseif behawior.task_type(i) == 1
        if behawior.version(i) == 1
            if behawior.locationResponse_pressKey(i) == 1 & behawior.background(i) == 1
                behawior.corrected_id(i) = 0;
            end
            if behawior.locationResponse_pressKey(i) == 1 & behawior.background(i) == 0
                behawior.corrected_id(i) = 1;
            end
            if behawior.locationResponse_pressKey(i) == 6 & behawior.background(i) == 1
                behawior.corrected_id(i) = 1;
            end
            if behawior.locationResponse_pressKey(i) == 6 & behawior.background(i) == 0
                behawior.corrected_id(i) = 0;
            end
        end
        if behawior.version(i) == 2
            if behawior.locationResponse_pressKey(i) == 1 & behawior.background(i) == 1
                behawior.corrected_id(i) = 1;
            end
            if behawior.locationResponse_pressKey(i) == 1 & behawior.background(i) == 0
                behawior.corrected_id(i) = 0;
            end
            if behawior.locationResponse_pressKey(i) == 6 & behawior.background(i) == 1
                behawior.corrected_id(i) = 0;
            end
            if behawior.locationResponse_pressKey(i) == 6 & behawior.background(i) == 0
                behawior.corrected_id(i) = 1;
            end
        end
    end
end

for i = 1:size(behawior,1)
    if behawior.pasResponse_pressKey(i) == 0
        behawior.pas_2(i) = 1;
    elseif behawior.pasResponse_pressKey(i) == 1
        behawior.pas_2(i) = 2;
    elseif behawior.pasResponse_pressKey(i) == 6
        behawior.pas_2(i) = 3;
    elseif behawior.pasResponse_pressKey(i) == 7
        behawior.pas_2(i) = 4;
    end




    if behawior.object(i) == 1 & behawior.background(i) == 1
        behawior.congruency_2(i) = 1;
    elseif behawior.object(i) == 0 & behawior.background(i) == 0
        behawior.congruency_2(i) = 1;
    elseif behawior.object(i) == 0 & behawior.background(i) == 1
        behawior.congruency_2(i) = 0;
    elseif behawior.object(i) == 1 & behawior.background(i) == 0
        behawior.congruency_2(i) = 0;
    end
end

n = 1;
for i=1:size(behawior,1)
    if behawior.corrected_id(i) - behawior.id2(i) ~=0
        temp(n,:) = behawior(i, :);
        n=n+1;
    end

end
temp = removevars(temp, ["duration","duration_id","subset","id","tasktype","tasktype_id","stim","stim_id","mask","image_name","global_start_time","global_end_time","pressKey","pressRT","releaseRT","image_started","image_ended","name"]);

save([root1 '\behawior.mat'], 'behawior');





idx = [];
idx.congruent = [];
idx.incongruent = [];
idx.pas1 = [];
idx.pas2 = [];
idx.pas3 = [];
idx.pas4 = [];
idx.correct = [];
idx.incorrect = [];
idx.dur8 = [];
idx.dur16 = [];
idx.dur32 = [];

idx.congruent = [behawior.congruency] == 1;
idx.incongruent = [behawior.congruency] == 0;
idx.pas1 = [behawior.pas] == 1;
idx.pas2 = [behawior.pas] == 2;
idx.pas3 = [behawior.pas] == 3;
idx.pas4 = [behawior.pas] == 4;
idx.correct = [behawior.corrected_id] == 1;
idx.incorrect = [behawior.corrected_id] == 0;
idx.dur8 = [behawior.stimulus_duration_ms] == 8;
idx.dur16 = [behawior.stimulus_duration_ms] == 16;
idx.dur32 = [behawior.stimulus_duration_ms] == 32;
idx.task_object = [behawior.task_type] == 0;
idx.task_background = [behawior.task_type] == 1;


times = [];

timing_type = 'locationResponse_pressRT';
%timing_type = 'pasResponse_pressRT';
times.congruent =  mean(behawior.(timing_type)(idx.congruent));
times.incongruent = mean(behawior.(timing_type)(idx.incongruent));
times.pas1 = mean(behawior.(timing_type)(idx.pas1));
times.pas2 = mean(behawior.(timing_type)(idx.pas2));
times.pas3 = mean(behawior.(timing_type)(idx.pas3));
times.pas4 = mean(behawior.(timing_type)(idx.pas4));
times.correct = mean(behawior.(timing_type)(idx.correct));
times.incorrect = mean(behawior.(timing_type)(idx.incorrect));
times.dur8 = mean(behawior.(timing_type)(idx.dur8));
times.dur16 = mean(behawior.(timing_type)(idx.dur16));
times.dur32 = mean(behawior.(timing_type)(idx.dur32));
times.task_object = mean(behawior.(timing_type)(idx.task_object));
times.task_background = mean(behawior.(timing_type)(idx.task_background));

times_background.congruent =  mean(behawior.(timing_type)(idx.task_background & idx.congruent));
times_background.incongruent = mean(behawior.(timing_type)(idx.task_background & idx.incongruent));
times_background.pas1 = mean(behawior.(timing_type)(idx.task_background & idx.pas1));
times_background.pas2 = mean(behawior.(timing_type)(idx.task_background & idx.pas2));
times_background.pas3 = mean(behawior.(timing_type)(idx.task_background & idx.pas3));
times_background.pas4 = mean(behawior.(timing_type)(idx.task_background & idx.pas4));
times_background.correct = mean(behawior.(timing_type)(idx.task_background & idx.correct));
times_background.incorrect = mean(behawior.(timing_type)(idx.task_background & idx.incorrect));
times_background.dur8 = mean(behawior.(timing_type)(idx.task_background & idx.dur8));
times_background.dur16 = mean(behawior.(timing_type)(idx.task_background & idx.dur16));
times_background.dur32 = mean(behawior.(timing_type)(idx.task_background & idx.dur32));

times_object.congruent =  mean(behawior.(timing_type)(idx.task_object & idx.congruent));
times_object.incongruent = mean(behawior.(timing_type)(idx.task_object & idx.incongruent));
times_object.pas1 = mean(behawior.(timing_type)(idx.task_object & idx.pas1));
times_object.pas2 = mean(behawior.(timing_type)(idx.task_object & idx.pas2));
times_object.pas3 = mean(behawior.(timing_type)(idx.task_object & idx.pas3));
times_object.pas4 = mean(behawior.(timing_type)(idx.task_object & idx.pas4));
times_object.correct = mean(behawior.(timing_type)(idx.task_object & idx.correct), 'omitnan');
times_object.incorrect = mean(behawior.(timing_type)(idx.task_object & idx.incorrect));
times_object.dur8 = mean(behawior.(timing_type)(idx.task_object & idx.dur8));
times_object.dur16 = mean(behawior.(timing_type)(idx.task_object & idx.dur16));
times_object.dur32 = mean(behawior.(timing_type)(idx.task_object & idx.dur32));




boxplot(behawior.locationResponse_pressRT, {behawior.task_type, behawior.pas, behawior.stimulus_duration_ms},"ColorGroup",behawior.pas)
ylim([0 2])
boxplot(behawior.locationResponse_pressRT, {behawior.task_type, behawior.corrected_id, behawior.stimulus_duration_ms},"ColorGroup",behawior.corrected_id)
ylim([0 2])



beh_dur8 = behawior(idx.dur8, :);
beh_dur16 = behawior(idx.dur16, :);
beh_dur32 = behawior(idx.dur32, :);
%boxplot(beh_dur8.locationResponse_pressRT, {beh_dur8.task_type, beh_dur8.corrected_id, },"ColorGroup",beh_dur8.corrected_id, 'Labels', {'background inc', 'background corr', 'object inc', 'object corr'})

figure; hold on;
subplot(1, 3, 1)
boxplot(beh_dur8.locationResponse_pressRT, {beh_dur8.task_type, beh_dur8.corrected_id, },"ColorGroup",beh_dur8.corrected_id)
ylim([0 2])

subplot(1, 3, 2)
boxplot(beh_dur16.locationResponse_pressRT, {beh_dur16.task_type, beh_dur16.corrected_id, },"ColorGroup",beh_dur16.corrected_id)
ylim([0 2])


subplot(1, 3, 3)
boxplot(beh_dur32.locationResponse_pressRT, {beh_dur32.task_type, beh_dur32.corrected_id, },"ColorGroup",beh_dur32.corrected_id)
ylim([0 2])



figure; hold on;
subplot(1, 3, 1)
boxplot(beh_dur8.locationResponse_pressRT, {beh_dur8.task_type, beh_dur8.pas, },"ColorGroup",beh_dur8.pas)
ylim([0 2])

subplot(1, 3, 2)
boxplot(beh_dur16.locationResponse_pressRT, {beh_dur16.task_type, beh_dur16.pas, },"ColorGroup",beh_dur16.pas)
ylim([0 2])


subplot(1, 3, 3)
boxplot(beh_dur32.locationResponse_pressRT, {beh_dur32.task_type, beh_dur32.pas, },"ColorGroup",beh_dur32.pas)
ylim([0 2])



%% only correct

beh_dur8 = behawior(idx.dur8 & idx.correct, :);
beh_dur16 = behawior(idx.dur16 & idx.correct, :);
beh_dur32 = behawior(idx.dur32 & idx.correct, :);
%boxplot(beh_dur8.locationResponse_pressRT, {beh_dur8.task_type, beh_dur8.corrected_id, },"ColorGroup",beh_dur8.corrected_id, 'Labels', {'background inc', 'background corr', 'object inc', 'object corr'})

figure; hold on;
subplot(1, 3, 1)
boxplot(beh_dur8.locationResponse_pressRT, {beh_dur8.task_type, beh_dur8.congruency, },"ColorGroup",beh_dur8.congruency)
ylim([0 2])

subplot(1, 3, 2)
boxplot(beh_dur16.locationResponse_pressRT, {beh_dur16.task_type, beh_dur16.congruency, },"ColorGroup",beh_dur16.congruency)
ylim([0 2])


subplot(1, 3, 3)
boxplot(beh_dur32.locationResponse_pressRT, {beh_dur32.task_type, beh_dur32.congruency, },"ColorGroup",beh_dur32.congruency)
ylim([0 2])



figure; hold on;
subplot(1, 3, 1)
boxplot(beh_dur8.locationResponse_pressRT, {beh_dur8.task_type, beh_dur8.pas, },"ColorGroup",beh_dur8.pas)
ylim([0 2])

subplot(1, 3, 2)
boxplot(beh_dur16.locationResponse_pressRT, {beh_dur16.task_type, beh_dur16.pas, },"ColorGroup",beh_dur16.pas)
ylim([0 2])


subplot(1, 3, 3)
boxplot(beh_dur32.locationResponse_pressRT, {beh_dur32.task_type, beh_dur32.pas, },"ColorGroup",beh_dur32.pas)
ylim([0 2])

writetable(behawior)
