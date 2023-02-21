load('D:\export\exp1_bootstraps\exp1_significant_vals.mat');
exp1.significant_vals = significant_vals;
clear significant_vals
load('D:\export\exp3_bootstraps\exp3_significant_vals.mat');
exp3.significant_vals = significant_vals;
clear significant_vals
load('D:\export\exp4_bootstraps\exp4_significant_vals.mat');
exp4.significant_vals = significant_vals;
clear significant_vals
load('D:\export\exp5_bootstraps\significant vals - bootstraping_object.mat');
exp5_obj.significant_vals = significant_vals;
clear significant_vals
load('D:\export\exp5_bootstraps\significant vals - bootstraping_background.mat');
exp5_bgr.significant_vals = significant_vals;
clear significant_vals


%% plot settings
rangeY = [0 1000];
rangeX = [10 100];

participants_in_batch = [10 20 30 40 50 60 70 80 90 100]
figure; hold on;
subplot(5,1,1)
hold on;
plot(participants_in_batch, exp1.significant_vals.pas_lme_sum)
plot(participants_in_batch, exp1.significant_vals.identification_lme_sum)
ylim(rangeY);
yticks([0 500 1000]);
yticklabels({'0','0.5','1'});
xlim(rangeX);
hold off;


%%
subplot(5,1,2)
hold on;
plot(participants_in_batch, exp3.significant_vals.pas_lme_sum)
plot(participants_in_batch, exp3.significant_vals.identification_lme_sum)
ylim(rangeY);
yticks([0 500 1000]);
yticklabels({'0','0.5','1'});
xlim(rangeX);
hold off;
%%
subplot(5,1,3)
hold on;
plot(participants_in_batch, exp4.significant_vals.pas_lme_sum)
plot(participants_in_batch, exp4.significant_vals.identification_lme_sum)
ylim(rangeY);
yticks([0 500 1000]);
yticklabels({'0','0.5','1'});
xlim(rangeX);
hold off;

%%
subplot(5,1,4)
hold on;
plot(participants_in_batch, exp5_bgr.significant_vals.pas_lme_sum)
plot(participants_in_batch, exp5_bgr.significant_vals.identification_lme_sum)
ylim(rangeY);
yticks([0 500 1000]);
yticklabels({'0','0.5','1'});
xlim(rangeX);
hold off;
%%
subplot(5,1,5)
hold on;
plot(participants_in_batch, exp5_obj.significant_vals.pas_lme_sum)
plot(participants_in_batch, exp5_obj.significant_vals.identification_lme_sum)
ylim(rangeY);
yticks([0 500 1000]);
yticklabels({'0','0.5','1'});
xlim(rangeX);
hold off;


f = openfig('C:\Users\user\Desktop\BOOTSTRAP figures\bootstrapy_update.fig')
exportgraphics(f,'graph.png','Resolution',600);