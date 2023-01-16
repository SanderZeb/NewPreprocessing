behawior = 'C:\Users\user\Desktop\Behawior\Gabor\';
root1 = 'D:\Drive\1 - Threshold\';
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
    opts = delimitedTextImportOptions("NumVariables", 39, "Encoding", "UTF-8");
    
    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";
    
    % Specify column names and types
    opts.VariableNames = ["x", "y", "orientation", "thisRepN", "thisTrialN", "thisN", "thisIndex", "stepSize", "intensity", "image_name", "global_start_time", "global_end_time", "pressKey", "pressRT", "releaseRT", "image_started", "image_ended", "name", "globalTime", "fixation_dur", "stimulation_dur", "post_fixation", "opacity", "locationResponse_pressKey", "locationResponse_pressRT", "locationResponse_releaseRT", "orientationResponse_pressKey", "orientationResponse_pressRT", "orientationResponse_releaseRT", "pasResponse_pressKey", "pasResponse_pressRT", "pasResponse_releaseRT", "response", "finalOpacity", "postLoc", "postOri", "ID", "frameRate", "VarName39"];
    opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "string", "double", "double", "double", "double", "double", "double", "double", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string"];
    
    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Specify variable properties
    opts = setvaropts(opts, ["image_name", "VarName39"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["image_name", "name", "VarName39"], "EmptyFieldRule", "auto");
    current_table = readtable(curr_file, opts);

    behawior = cat(1, behawior, current_table) ;

end


for i = 1:size(behawior,1)
    if ~isnan(behawior.postLoc(i))
        idx(i) = 0;
    else
        idx(i)=1;
    end
end

behawior(idx==1, :) = [];

save([root1 '\behawior.mat'], 'behawior');
