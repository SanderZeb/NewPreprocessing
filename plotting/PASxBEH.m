settings.alltrials = 0;
settings.consc_color = "blue";
settings.unconsc_color = "red";


clear all

load('D:\Drive\1 - Threshold\tfdata\all - alpha power.mat')
if settings.alltrials == 0
    participants.exp1 = max([all.participant])
else 
    participants.exp1 = 1;
end
sumy.exp_1_pas1_corr = sum([all.pas]==1 & [all.identification2] == 1) / participants.exp1;
sumy.exp_1_pas1_incr = sum([all.pas]==1 & [all.identification2] == 0) / participants.exp1;
sumy.exp_1_pas2_corr = sum([all.pas]==2 & [all.identification2] == 1) / participants.exp1;
sumy.exp_1_pas2_incr  = sum([all.pas]==2 & [all.identification2] == 0) / participants.exp1;
sumy.exp_1_pas3_corr = sum([all.pas]==3 & [all.identification2] == 1) / participants.exp1;
sumy.exp_1_pas3_incr  = sum([all.pas]==3 & [all.identification2] == 0) / participants.exp1;
sumy.exp_1_pas4_corr = sum([all.pas]==4 & [all.identification2] == 1) / participants.exp1;
sumy.exp_1_pas4_incr  = sum([all.pas]==4 & [all.identification2] == 0) / participants.exp1;


clear all

load('D:\Drive\3 - Mask\tfdata\all - alpha power.mat')
if settings.alltrials == 0
    participants.exp3 = max([all.participant])
else 
    participants.exp3 = 1;
end
sumy.exp_3_pas1_corr = sum([all.pas]==1 & [all.corr_corr] == 1) / participants.exp3;
sumy.exp_3_pas1_incr = sum([all.pas]==1 & [all.corr_corr] == 0) / participants.exp3;
sumy.exp_3_pas2_corr = sum([all.pas]==2 & [all.corr_corr] == 1) / participants.exp3;
sumy.exp_3_pas2_incr  = sum([all.pas]==2 & [all.corr_corr] == 0) / participants.exp3;
sumy.exp_3_pas3_corr = sum([all.pas]==3 & [all.corr_corr] == 1) / participants.exp3;
sumy.exp_3_pas3_incr  = sum([all.pas]==3 & [all.corr_corr] == 0) / participants.exp3;
sumy.exp_3_pas4_corr = sum([all.pas]==4 & [all.corr_corr] == 1) / participants.exp3;
sumy.exp_3_pas4_incr  = sum([all.pas]==4 & [all.corr_corr] == 0) / participants.exp3;


clear all

load('D:\Drive\4 - Faces\tfdata\all - alpha power.mat')


for i =1:length(all)

empty(i, 1) = isempty(all(i).pas);
empty(i, 2) = isempty(all(i).identification2);
end

idx_to_drop = find(empty)
all(idx_to_drop) = []
if settings.alltrials == 0
    participants.exp4 = max([all.participant])
else 
    participants.exp4 = 1;
end

sumy.exp_4_pas1_corr = sum([all.pas]==1 & [all.identification2] == 1) / participants.exp4;
sumy.exp_4_pas1_incr = sum([all.pas]==1 & [all.identification2] == 0) / participants.exp4;
sumy.exp_4_pas2_corr = sum([all.pas]==2 & [all.identification2] == 1) / participants.exp4;
sumy.exp_4_pas2_incr  = sum([all.pas]==2 & [all.identification2] == 0) / participants.exp4;
sumy.exp_4_pas3_corr = sum([all.pas]==3 & [all.identification2] == 1) / participants.exp4;
sumy.exp_4_pas3_incr  = sum([all.pas]==3 & [all.identification2] == 0) / participants.exp4;
sumy.exp_4_pas4_corr = sum([all.pas]==4 & [all.identification2] == 1) / participants.exp4;
sumy.exp_4_pas4_incr  = sum([all.pas]==4 & [all.identification2] == 0) / participants.exp4;


writetable(struct2table(sumy), 'D:\sum_of_trials.csv')


clear all
load('D:\Drive\5 - Scenes\tfdata\exp5_scenes_alpha.mat')

for i = 1:length(all)
    all(i).t_type = strcmp(all(i).task_type, 'object') % 1 - object; 0 - background
end


if settings.alltrials == 0
    participants.exp5 = max([all.participant])
else 
    participants.exp5 = 1;
end

sumy.exp5_obj_pas1_corr = sum([all.t_type] == 1 & [all.pas]==1 & [all.id2] == 1) / participants.exp5;
sumy.exp5_obj__pas1_incr = sum([all.t_type] == 1 & [all.pas]==1 & [all.id2] == 0) / participants.exp5;
sumy.exp5_obj_pas2_corr = sum([all.t_type] == 1 & [all.pas]==2 & [all.id2] == 1) / participants.exp5;
sumy.exp5_obj_pas2_incr  = sum([all.t_type] == 1 & [all.pas]==2 & [all.id2] == 0) / participants.exp5;
sumy.exp5_obj_pas3_corr = sum([all.t_type] == 1 & [all.pas]==3 & [all.id2] == 1) / participants.exp5;
sumy.exp5_obj_pas3_incr  = sum([all.t_type] == 1 & [all.pas]==3 & [all.id2] == 0) / participants.exp5;
sumy.exp5_obj_pas4_corr = sum([all.t_type] == 1 & [all.pas]==4 & [all.id2] == 1) / participants.exp5;
sumy.exp5_obj_pas4_incr  = sum([all.t_type] == 1 & [all.pas]==4 & [all.id2] == 0) / participants.exp5;



sumy.exp5_bgr_pas1_corr = sum([all.t_type] == 0 & [all.pas]==1 & [all.id2] == 1) / participants.exp5;
sumy.exp5_bgr__pas1_incr = sum([all.t_type] == 0 & [all.pas]==1 & [all.id2] == 0) / participants.exp5;
sumy.exp5_bgr_pas2_corr = sum([all.t_type] == 0 & [all.pas]==2 & [all.id2] == 1) / participants.exp5;
sumy.exp5_bgr_pas2_incr  = sum([all.t_type] == 0 & [all.pas]==2 & [all.id2] == 0) / participants.exp5;
sumy.exp5_bgr_pas3_corr = sum([all.t_type] == 0 & [all.pas]==3 & [all.id2] == 1) / participants.exp5;
sumy.exp5_bgr_pas3_incr  = sum([all.t_type] == 0 & [all.pas]==3 & [all.id2] == 0) / participants.exp5;
sumy.exp5_bgr_pas4_corr = sum([all.t_type] == 0 & [all.pas]==4 & [all.id2] == 1) / participants.exp5;
sumy.exp5_bgr_pas4_incr  = sum([all.t_type] == 0 & [all.pas]==4 & [all.id2] == 0) / participants.exp5;



figure; hold on;


subplot(5,1,1)
hold on;
title('Exp 1 - Threshold')
bubblechart( 1, sumy.exp_1_pas1_corr, sumy.exp_1_pas1_corr, settings.consc_color)
bubblechart( 2, sumy.exp_1_pas1_incr, sumy.exp_1_pas1_incr, settings.unconsc_color)
bubblechart( 3, sumy.exp_1_pas2_corr, sumy.exp_1_pas2_corr, settings.consc_color)
bubblechart( 4, sumy.exp_1_pas2_incr, sumy.exp_1_pas2_incr, settings.unconsc_color)
bubblechart( 5, sumy.exp_1_pas3_corr, sumy.exp_1_pas3_corr, settings.consc_color)
bubblechart( 6, sumy.exp_1_pas3_incr, sumy.exp_1_pas3_incr, settings.unconsc_color)
bubblechart( 7, sumy.exp_1_pas4_corr, sumy.exp_1_pas4_corr, settings.consc_color)
bubblechart( 8, sumy.exp_1_pas4_incr, sumy.exp_1_pas4_incr, settings.unconsc_color)

label = {'PAS 1 - Correct';'PAS 1 - Incorrect'; 'PAS 2 - Correct';'PAS 2 - Incorrect'; 'PAS 3 - Correct';'PAS 3 - Incorrect'; 'PAS 4 - Correct';'PAS 4 - Incorrect';}
xticklabels(label)
ylabel('amount of trials')
ylim([0 200])
hold off



subplot(5,1,2)
 hold on;
title('Exp 3 - Mask')
bubblechart( 1, sumy.exp_3_pas1_corr, sumy.exp_3_pas1_corr, settings.consc_color)
bubblechart( 2, sumy.exp_3_pas1_incr, sumy.exp_3_pas1_incr, settings.unconsc_color)
bubblechart( 3, sumy.exp_3_pas2_corr, sumy.exp_3_pas2_corr, settings.consc_color)
bubblechart( 4, sumy.exp_3_pas2_incr, sumy.exp_3_pas2_incr, settings.unconsc_color)
bubblechart( 5, sumy.exp_3_pas3_corr, sumy.exp_3_pas3_corr, settings.consc_color)
bubblechart( 6, sumy.exp_3_pas3_incr, sumy.exp_3_pas3_incr, settings.unconsc_color)
bubblechart( 7, sumy.exp_3_pas4_corr, sumy.exp_3_pas4_corr, settings.consc_color)
bubblechart( 8, sumy.exp_3_pas4_incr, sumy.exp_3_pas4_incr, settings.unconsc_color)

label = {'PAS 1 - Correct';'PAS 1 - Incorrect'; 'PAS 2 - Correct';'PAS 2 - Incorrect'; 'PAS 3 - Correct';'PAS 3 - Incorrect'; 'PAS 4 - Correct';'PAS 4 - Incorrect';}
xticklabels(label)
ylabel('amount of trials')
ylim([0 200])
hold off


subplot(5,1,3)
 hold on;
title('Exp 4 - Faces')
bubblechart( 1, sumy.exp_4_pas1_corr, sumy.exp_4_pas1_corr, settings.consc_color)
bubblechart( 2, sumy.exp_4_pas1_incr, sumy.exp_4_pas1_incr, settings.unconsc_color)
bubblechart( 3, sumy.exp_4_pas2_corr, sumy.exp_4_pas2_corr, settings.consc_color)
bubblechart( 4, sumy.exp_4_pas2_incr, sumy.exp_4_pas2_incr, settings.unconsc_color)
bubblechart( 5, sumy.exp_4_pas3_corr, sumy.exp_4_pas3_corr, settings.consc_color)
bubblechart( 6, sumy.exp_4_pas3_incr, sumy.exp_4_pas3_incr, settings.unconsc_color)
bubblechart( 7, sumy.exp_4_pas4_corr, sumy.exp_4_pas4_corr, settings.consc_color)
bubblechart( 8, sumy.exp_4_pas4_incr, sumy.exp_4_pas4_incr, settings.unconsc_color)

label = {'PAS 1 - Correct';'PAS 1 - Incorrect'; 'PAS 2 - Correct';'PAS 2 - Incorrect'; 'PAS 3 - Correct';'PAS 3 - Incorrect'; 'PAS 4 - Correct';'PAS 4 - Incorrect';}
xticklabels(label)
ylabel('amount of trials')
ylim([0 200])
hold off

subplot(5,1,4)
 hold on;
title('Exp 5 - Scenes - Object')
bubblechart( 1, sumy.exp5_obj_pas1_corr, sumy.exp5_obj_pas1_corr, settings.consc_color)
bubblechart( 2, sumy.exp5_obj__pas1_incr, sumy.exp5_obj__pas1_incr, settings.unconsc_color)
bubblechart( 3, sumy.exp5_obj_pas2_corr, sumy.exp5_obj_pas2_corr, settings.consc_color)
bubblechart( 4, sumy.exp5_obj_pas2_incr, sumy.exp5_obj_pas2_incr, settings.unconsc_color)
bubblechart( 5, sumy.exp5_obj_pas3_corr, sumy.exp5_obj_pas3_corr, settings.consc_color)
bubblechart( 6, sumy.exp5_obj_pas3_incr, sumy.exp5_obj_pas3_incr, settings.unconsc_color)
bubblechart( 7, sumy.exp5_obj_pas4_corr, sumy.exp5_obj_pas4_corr, settings.consc_color)
bubblechart( 8, sumy.exp5_obj_pas4_incr, sumy.exp5_obj_pas4_incr, settings.unconsc_color)

label = {'PAS 1 - Correct';'PAS 1 - Incorrect'; 'PAS 2 - Correct';'PAS 2 - Incorrect'; 'PAS 3 - Correct';'PAS 3 - Incorrect'; 'PAS 4 - Correct';'PAS 4 - Incorrect';}
xticklabels(label)
ylabel('amount of trials')
ylim([0 200])
hold off




subplot(5,1,5)
 hold on;
title('Exp 5 - Scenes - Background')
bubblechart( 1, sumy.exp5_bgr_pas1_corr, sumy.exp5_bgr_pas1_corr, settings.consc_color)
bubblechart( 2, sumy.exp5_bgr__pas1_incr, sumy.exp5_bgr__pas1_incr, settings.unconsc_color)
bubblechart( 3, sumy.exp5_bgr_pas2_corr, sumy.exp5_bgr_pas2_corr, settings.consc_color)
bubblechart( 4, sumy.exp5_bgr_pas2_incr, sumy.exp5_bgr_pas2_incr, settings.unconsc_color)
bubblechart( 5, sumy.exp5_bgr_pas3_corr, sumy.exp5_bgr_pas3_corr, settings.consc_color)
bubblechart( 6, sumy.exp5_bgr_pas3_incr, sumy.exp5_bgr_pas3_incr, settings.unconsc_color)
bubblechart( 7, sumy.exp5_bgr_pas4_corr, sumy.exp5_bgr_pas4_corr, settings.consc_color)
bubblechart( 8, sumy.exp5_bgr_pas4_incr, sumy.exp5_bgr_pas4_incr, settings.unconsc_color)

label = {'PAS 1 - Correct';'PAS 1 - Incorrect'; 'PAS 2 - Correct';'PAS 2 - Incorrect'; 'PAS 3 - Correct';'PAS 3 - Incorrect'; 'PAS 4 - Correct';'PAS 4 - Incorrect';}
xticklabels(label)
ylabel('amount of trials')
ylim([0 200])
hold off



%%
figure; hold on;
bubblechart( 1, 1, sumy.exp_1_pas1_corr, settings.consc_color)
bubblechart( 2, 1, sumy.exp_1_pas1_incr, settings.unconsc_color)
bubblechart( 3, 1, sumy.exp_1_pas2_corr, settings.consc_color)
bubblechart( 4, 1, sumy.exp_1_pas2_incr, settings.unconsc_color)
bubblechart( 5, 1, sumy.exp_1_pas3_corr, settings.consc_color)
bubblechart( 6, 1, sumy.exp_1_pas3_incr, settings.unconsc_color)
bubblechart( 7, 1, sumy.exp_1_pas4_corr, settings.consc_color)
bubblechart( 8, 1, sumy.exp_1_pas4_incr, settings.unconsc_color)



bubblechart( 1, 2, sumy.exp_3_pas1_corr, settings.consc_color)
bubblechart( 2, 2, sumy.exp_3_pas1_incr, settings.unconsc_color)
bubblechart( 3, 2, sumy.exp_3_pas2_corr, settings.consc_color)
bubblechart( 4, 2, sumy.exp_3_pas2_incr, settings.unconsc_color)
bubblechart( 5, 2, sumy.exp_3_pas3_corr, settings.consc_color)
bubblechart( 6, 2, sumy.exp_3_pas3_incr, settings.unconsc_color)
bubblechart( 7, 2, sumy.exp_3_pas4_corr, settings.consc_color)
bubblechart( 8, 2, sumy.exp_3_pas4_incr, settings.unconsc_color)

bubblechart( 1, 3, sumy.exp_4_pas1_corr, settings.consc_color)
bubblechart( 2, 3, sumy.exp_4_pas1_incr, settings.unconsc_color)
bubblechart( 3, 3, sumy.exp_4_pas2_corr, settings.consc_color)
bubblechart( 4, 3, sumy.exp_4_pas2_incr, settings.unconsc_color)
bubblechart( 5, 3, sumy.exp_4_pas3_corr, settings.consc_color)
bubblechart( 6, 3, sumy.exp_4_pas3_incr, settings.unconsc_color)
bubblechart( 7, 3, sumy.exp_4_pas4_corr, settings.consc_color)
bubblechart( 8, 3, sumy.exp_4_pas4_incr, settings.unconsc_color)

bubblechart( 1, 4, sumy.exp5_obj_pas1_corr, settings.consc_color)
bubblechart( 2, 4, sumy.exp5_obj__pas1_incr, settings.unconsc_color)
bubblechart( 3, 4, sumy.exp5_obj_pas2_corr, settings.consc_color)
bubblechart( 4, 4, sumy.exp5_obj_pas2_incr, settings.unconsc_color)
bubblechart( 5, 4, sumy.exp5_obj_pas3_corr, settings.consc_color)
bubblechart( 6, 4, sumy.exp5_obj_pas3_incr, settings.unconsc_color)
bubblechart( 7, 4, sumy.exp5_obj_pas4_corr, settings.consc_color)
bubblechart( 8, 4, sumy.exp5_obj_pas4_incr, settings.unconsc_color)


bubblechart( 1, 5, sumy.exp5_bgr_pas1_corr, settings.consc_color)
bubblechart( 2, 5, sumy.exp5_bgr__pas1_incr, settings.unconsc_color)
bubblechart( 3, 5, sumy.exp5_bgr_pas2_corr, settings.consc_color)
bubblechart( 4, 5, sumy.exp5_bgr_pas2_incr, settings.unconsc_color)
bubblechart( 5, 5, sumy.exp5_bgr_pas3_corr, settings.consc_color)
bubblechart( 6, 5, sumy.exp5_bgr_pas3_incr, settings.unconsc_color)
bubblechart( 7, 5, sumy.exp5_bgr_pas4_corr, settings.consc_color)
bubblechart( 8, 5, sumy.exp5_bgr_pas4_incr, settings.unconsc_color)

label = {'PAS 1 - Correct';'PAS 1 - Incorrect'; 'PAS 2 - Correct';'PAS 2 - Incorrect'; 'PAS 3 - Correct';'PAS 3 - Incorrect'; 'PAS 4 - Correct';'PAS 4 - Incorrect';}
xticklabels(label)
yticks([1:5])
label2 = {'1 Exp - Threshold'; '3 Exp - Mask'; '4 Exp - Faces'; '5 Exp - Objects'; '5 Exp - Background'}
yticklabels(label2)