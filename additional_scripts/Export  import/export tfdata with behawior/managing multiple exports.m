

load('D:\Drive\1 - Threshold\tfdata\behawior_alpha.mat')
exp1 = all_data
clear all_data
load('D:\Drive\3 - Mask\tfdata\behawior_alpha.mat')
exp3 = all_data
clear all_data
load('D:\Drive\4 - Faces\tfdata\behawior_alpha.mat')
exp4 = all_data
clear all_data
load('D:\Drive\5 - Scenes\behawior_alpha.mat')
exp5 = struct2table(all)
clear all

to_reject.exp1 = exp1(find(exp1.alpha_dB > 41 | exp1.alpha_dB < 1),:)
%to_reject.exp1 = exp1(find(exp1.opacity > 0.7),:)
exp1(find(exp1.alpha_dB > 41 | exp1.alpha_dB < 1),:) = [];


exp1 = removevars(exp1, ["stim_ori_resp_angles","ori_stim","loc_stim"]);
exp1.Properties.VariableNames(32) = "PAS";


%%%%
exp3.Properties.VariableNames(24) = "PAS";


%%%%
exp4 = removevars(exp4, ["stim","possibleresp","stim_resp_angles","stim_resp","pas_resp","accuracy"]);
exp4.Properties.VariableNames(27) = "accuracy";
for i = 1:size(exp4, 1)
    if exp4.sex(i) == 1
        exp4.sex1(i, :) = 'fema';
    else
        exp4.sex1(i, :) = 'male';
    end
end
exp4 = removevars(exp4, "sex");
exp4.Properties.VariableNames(34) = "sex";
exp4.Properties.VariableNames(26) = "PAS";


%%%%
exp5.Properties.VariableNames(37) = "accuracy";
exp5.Properties.VariableNames(7) = "PAS";
exp5.Properties.VariableNames(34) = "ID_data";
writetable((exp1), ['D:\export\exp1_behawior_alpha.csv'])
writetable((exp3), ['D:\export\exp3_behawior_alpha.csv'])
writetable((exp4), ['D:\export\exp4_behawior_alpha.csv'])
writetable((exp5), ['D:\export\exp5_behawior_alpha.csv'])

save('D:\export\exp1_behawior_alpha.m', "exp1")
save('D:\export\exp3_behawior_alpha.m', "exp3")
save('D:\export\exp4_behawior_alpha.m', "exp4")
save('D:\export\exp5_behawior_alpha.m', "exp5")




figure;
hold on;


%% alpha_dB
subplot(2,2,1)
histogram(exp1.alpha_dB, "BinEdges",[0:1:40])
title('exp1');
subplot(2,2,2)
histogram(exp3.alpha_dB, "BinEdges",[0:1:40])
title('exp3');
subplot(2,2,3)
histogram(exp4.alpha_dB, "BinEdges",[0:1:40])
title('exp4');
subplot(2,2,4)
histogram(exp5.alpha_dB, "BinEdges",[0:1:40])
title('exp5');

%% fixation dur
subplot(2,2,1)
histogram(exp1.fixation_dur, "BinEdges",[min(exp1.fixation_dur):0.5:max(exp1.fixation_dur)])
title('exp1');
subplot(2,2,2)
histogram(exp3.fixation_dur, "BinEdges",[min(exp3.fixation_dur):0.5:max(exp3.fixation_dur)])
title('exp3');
subplot(2,2,3)
histogram(exp4.fixation_dur, "BinEdges",[min(exp4.fixation_dur):0.5:max(exp4.fixation_dur)])
title('exp4');
subplot(2,2,4)
histogram(exp5.fixation_dur, "BinEdges",[min(exp5.fixation_dur):0.5:max(exp5.fixation_dur)])
title('exp5');


%% pas
subplot(2,2,1)
histogram(exp1.PAS, "BinEdges",[1:5])
title('exp1');
subplot(2,2,2)
histogram(exp3.PAS, "BinEdges",[1:5])
title('exp3');
subplot(2,2,3)
histogram(exp4.PAS, "BinEdges",[1:5])
title('exp4');
subplot(2,2,4)
histogram(exp5.PAS, "BinEdges",[1:5])
title('exp5');

%% accuracy
subplot(2,2,1)
histogram(exp1.accuracy, "BinEdges",[0:1:2])
title('exp1');
subplot(2,2,2)
histogram(exp3.accuracy, "BinEdges",[0:1:2])
title('exp3');
subplot(2,2,3)
histogram(exp4.accuracy, "BinEdges",[0:1:2])
title('exp4');
subplot(2,2,4)
histogram(exp5.accuracy, "BinEdges",[0:1:2])
title('exp5');

%% opacity
subplot(2,2,1)
histogram(exp1.opacity)
title('exp1');
subplot(2,2,2)
histogram(exp3.opacity)
title('exp3');
subplot(2,2,3)
histogram(exp4.opacity)
title('exp4');
subplot(2,2,4)
histogram(exp5.opacity)
title('exp5');

%% epoch
subplot(2,2,1)
histogram(exp1.epoch)
title('exp1');
subplot(2,2,2)
histogram(exp3.epoch)
title('exp3');
subplot(2,2,3)
histogram(exp4.epoch)
title('exp4');
subplot(2,2,4)
histogram(exp5.epoch)
title('exp5');



participants.exp1 = unique(exp1.ID_data)
participants.exp3 = unique(exp3.ID_data)
participants.exp4 = unique(exp4.ID_data)
participants.exp5 = unique(exp5.ID_data)



%% manualy manage files
%% exp 1
toRestore1 = all([all.participant] == 27)
toRestore2 = all([all.participant] == 85)
toRestore3 = all([all.participant] == 114)
toRestore4 = all([all.participant] == 122)
%% exp 3
load('D:\export\exp3_behawior_alpha.mat')
root = 'D:\Drive\3 - Mask\';
pathEEGData = [root '\MARA\']
listEEGData=dir([pathEEGData '*.set'  ]);
load('D:\Drive\3 - Mask\tfdata\all - alpha power.mat')
toRestore1 = all([all.participant] == 41)
toRestore2 = all([all.participant] == 66)
toRestore3 = all([all.participant] == 103)
toRestore4 = all([all.participant] == 142)
toRestore5 = all([all.participant] == 145)
toRestore6 = all([all.participant] == 162)
sum([length(toRestore1) length(toRestore2) length(toRestore3) length(toRestore4) length(toRestore5) length(toRestore6)])
save('D:\export\exp3_behawior_alpha.m', "exp3")
writetable((exp3), ['D:\export\exp3_behawior_alpha.csv'])
%% exp 4
root = 'D:\Drive\4 - Faces\';
pathEEGData = [root '\MARA\']
listEEGData=dir([pathEEGData '*.set'  ]);
load('D:\Drive\4 - Faces\tfdata\behawior_alpha.mat')
load('D:\Drive\4 - Faces\tfdata\all - alpha power.mat')
toRestore1 = all([all.participant] == 82)
writetable((exp4), ['D:\export\exp4_behawior_alpha.csv'])
save('D:\export\exp4_behawior_alpha.m', "exp4")


%% manually manage rejected epochs id
%% exp 1
load('D:\Drive\1 - Threshold\Epoching_EpochRejection\additional_info\removed_trials31173_1.set.mat')
temp = 1:400
temp(to_reject) = []
temp = temp.'

load('D:\Drive\1 - Threshold\Epoching_EpochRejection\additional_info\removed_trials73039_1.set.mat')
temp = 1:400
temp(to_reject) = []
temp = temp.'

load('D:\Drive\1 - Threshold\Epoching_EpochRejection\additional_info\removed_trials89742_1.set.mat')
temp = 1:400
temp(to_reject) = []
temp = temp.'

load('D:\Drive\1 - Threshold\Epoching_EpochRejection\additional_info\removed_trials94247_1.set.mat')
temp = 1:400
temp(to_reject) = []
temp = temp.'

%% exp 3 
load('D:\Drive\3 - Mask\Epoching_EpochRejection\additional_info\removed_trials34375_3.set.mat') % '34375_3.set'
temp = 1:400
temp(to_reject) = []
temp = temp.'


load('D:\Drive\3 - Mask\Epoching_EpochRejection\additional_info\removed_trials50935_3.set.mat') % '34375_3.set'
temp = 1:400
temp(to_reject) = []
temp = temp.'


load('D:\Drive\3 - Mask\Epoching_EpochRejection\additional_info\removed_trials68100_3.set.mat') % '34375_3.set'
temp = 1:400
temp(to_reject) = []
temp = temp.'


load('D:\Drive\3 - Mask\Epoching_EpochRejection\additional_info\removed_trials84136_3.set.mat') % '34375_3.set'
temp = 1:400
temp(to_reject) = []
temp = temp.'


load('D:\Drive\3 - Mask\Epoching_EpochRejection\additional_info\removed_trials85124_3.set.mat') % '34375_3.set'
temp = 1:400
temp(to_reject) = []
temp = temp.'



load('D:\Drive\3 - Mask\Epoching_EpochRejection\additional_info\removed_trials94182_3.set.mat') % '34375_3.set'
temp = 1:400
temp(to_reject) = []
temp = temp.'


%% exp4
load('D:\Drive\4 - Faces\Epoching_EpochRejection\additional_info\removed_trials84330_4.set.mat')
temp = 1:189
temp(to_reject) = []
temp = temp.'