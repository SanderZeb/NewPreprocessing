


path = 'D:\Drive\1 - Threshold\Epoching_EpochRejection\additional_info\';
load('D:\Drive\1 - Threshold\behawior.mat')
load('D:\Drive\1 - Threshold\tfdata\all - alpha power.mat')

removedEpochs = dir([path '*.mat'])
all2 = all;
%clear all
all = [];
for i = 1:length(removedEpochs)
    if i ~= 33
    temp = load([path removedEpochs(i).name]);
    id = removedEpochs(i).name(15:end-10);

    curr_behawior = behawior([behawior.ID] == str2num(id),:);
    curr_export = all2([all2.ID] == str2num(id));
    curr_dropout = temp.to_reject;
    curr_behawior.epoch(1:size(curr_behawior, 1)) = [1:size(curr_behawior, 1)]
    curr_behawior([curr_dropout], :) = [];

    if size(curr_behawior,1) ~= length(curr_export)
        for n = 1:size(curr_behawior,1)
            if curr_behawior.thisIndex(n) ~= curr_export(n).thisIndex
                curr_behawior(n, :) = [];
                if  size(curr_behawior,1) == length(curr_export)
                    break
                end
            end
        end
    end

    temp2 = [curr_behawior.epoch];

    for n = 1:length(temp2)
        curr_export(n).epoch = temp2(n);
        curr_export(n).tertile = ceil(curr_export(n).epoch/100);
        if curr_export(n).epoch > 300
            curr_export(n).tertile2 = ceil((curr_export(n).epoch-300)/100);
        else
            curr_export(n).tertile2 = ceil(curr_export(n).epoch/100);
        end
    end

    all = cat(2, all, curr_export);
    end
    
end
        all = rmfield(all, 'id2');
        [all.id2] = all.accuracy; all = orderfields(all,[1:36,44,37:43]); all = rmfield(all,'accuracy');
        save(['D:\Drive\5 - Scenes\behawior_alpha.mat'],'all');
        writetable(struct2table(all), 'D:\Drive\5 - Scenes\behawior_alpha.csv')