path = 'D:\Drive\3 - Mask\Epoching_EpochRejection\additional_info\';
load('D:\Drive\3 - Mask\behawior.mat')
load('D:\Drive\3 - Mask\tfdata\all - alpha power.mat')

tfdata_all = dir(['D:\Drive\3 - Mask\MARA\*.set'])
removedEpochs = dir([path '*.mat'])
all2 = all;


for i = 1:length(all2)

    all2(i).ID = str2num(tfdata_all(all2(i).participant).name(1:5));

end
for i = 1:length(removedEpochs)

    removedEpochs(i).ID = str2num(removedEpochs(i).name(15:end-10));

end
for i = 1:size(behawior, 1)

    to_change = str2mat(behawior.ID(i, 1));
    behawior.ID(i) = str2num(to_change(1:5));
    behawior.ID2(i) = str2num(to_change(1:5));

    if behawior.orientation(i) == -45
        behawior.stim(i) = 101;
    elseif behawior.orientation(i) == 45
        behawior.stim(i) = 107;
    elseif behawior.orientation(i) == 0
        behawior.stim(i) = 100;
    elseif behawior.orientation(i) == 90
        behawior.stim(i) = 106;
    end
    if behawior.orientationResponse_pressKey(i) == 0
        behawior.stim_resp_angles(i) = 0;
        behawior.stim_resp(i) = 100;
    elseif behawior.orientationResponse_pressKey(i) == 1
        behawior.stim_resp_angles(i) = -45;
        behawior.stim_resp(i) = 101;
    elseif behawior.orientationResponse_pressKey(i) == 6
        behawior.stim_resp_angles(i) = 90;
        behawior.stim_resp(i) = 106;
    elseif behawior.orientationResponse_pressKey(i) == 7
        behawior.stim_resp_angles(i) = 45;
        behawior.stim_resp(i) = 107;
    end
    if behawior.pasResponse_pressKey(i) == 0
        behawior.pas_resp(i) = 1;
    elseif behawior.pasResponse_pressKey(i) == 1
        behawior.pas_resp(i) = 2;
    elseif behawior.pasResponse_pressKey(i) == 6
        behawior.pas_resp(i) = 3;
    elseif behawior.pasResponse_pressKey(i) == 7
        behawior.pas_resp(i) = 4;
    end

end




%clear all
all = [];

removedEpochs(~[any([removedEpochs.ID] == unique([behawior.ID2]))]) = [];

% 
% removedEpochs([any([removedEpochs.ID] == unique([behawior.ID2]))]) = [];
% % missing files


for i = 1:length(unique([behawior.ID]))
    % if i ~= 42
    temp = load([path removedEpochs(i).name]);
    id = removedEpochs(i).ID;

    if i ~= 54
        curr_behawior = behawior([behawior.ID2] == id,:);
    elseif i == 54
        curr_behawior = behawior([behawior.ID2] == id,:);
        curr_behawior(401:end,:) = [];
    end
    curr_export = all2([all2.ID] == (id));
    curr_dropout = temp.to_reject;
    curr_behawior.epoch(1:size(curr_behawior, 1)) = [1:size(curr_behawior, 1)]
    curr_behawior([curr_dropout], :) = [];

    if size(curr_behawior,1) ~= length(curr_export)
        pause
        for n = 1:size(curr_behawior,1)
            if (curr_behawior.thisN(n) +1) ~= curr_export(n).epoch
                curr_behawior(n, :) = [];
                if  size(curr_behawior,1) == length(curr_export)
                    break
                end
            end
        end
    end


    all = cat(2, all, curr_export);
    %end
end
save(['D:\Drive\3 - Mask\behawior_alpha.mat'],'all');
writetable(struct2table(all), 'D:\Drive\3 - Mask\behawior_alpha.csv')











for i = 1:length(test)
    if test(1, i) == 0
        test(3, i) = 1;
    end
    if test(1, i) == 1
        test(3, i) = 2;
    end
    if test(1, i) == 6
        test(3, i) = 3;
    end
    if test(1, i) == 7
        test(3, i) = 4;
    end
end
