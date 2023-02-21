path = 'D:\Drive\1 - Threshold\Epoching_EpochRejection\additional_info\';
load('D:\Drive\1 - Threshold\behawior.mat')
load('D:\Drive\1 - Threshold\tfdata\all - alpha power.mat')

tfdata_all = dir(['D:\Drive\1 - Threshold\MARA\*.set'])
removedEpochs = dir([path '*.mat'])
all2 = all;


for i = 1:length(all2)

    all2(i).ID = str2num(tfdata_all(all2(i).participant).name(1:5));

end
for i = 1:length(removedEpochs)

    removedEpochs(i).ID = str2num(removedEpochs(i).name(15:end-10));

end
for i = 1:size(behawior, 1)
    if isnan(behawior.ID(i))
        idx(i) = 1;
    else
        idx(i) = 0;
    end
end
sum(idx)
behawior(logical(idx), :) = [];

%clear all
all = [];

removedEpochs(~[any([removedEpochs.ID] == unique([behawior.ID]))]) = [];
behawior(~[any([behawior.ID] == unique([removedEpochs.ID]))], :) = [];


for i = 1:length(unique([behawior.ID]))
    if i ~= 7
        temp = load([path removedEpochs(i).name]);
        id = removedEpochs(i).ID;
        curr_behawior = behawior([behawior.ID] == id,:);
        curr_export = all2([all2.ID] == (id));
        curr_dropout = temp.to_reject;
        curr_behawior.epoch(1:size(curr_behawior, 1)) = [1:size(curr_behawior, 1)];
        curr_behawior([curr_dropout], :) = [];
        if size(curr_behawior,1) ~= length(curr_export)
            for n = 1:size(curr_behawior,1)
                display(['curr: ' num2str(i) ' and: ' num2str(n)]);
                if (curr_behawior.thisN(n) +1) ~= curr_export(n).epoch
                    curr_behawior(n, :) = [];
                    if  size(curr_behawior,1) == length(curr_export)
                        break
                    end
                end
            end
        end
        all = cat(2, curr_behawior, curr_export);
    end
end
save(['D:\Drive\1 - Threshold\behawior_alpha.mat'],'all');
writetable(struct2table(all), 'D:\Drive\1 - Threshold\behawior_alpha.csv')