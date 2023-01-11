results_exp1 = readtable('D:\Drive\1 - Threshold\pwelch\pwelch_result\csv_export\results.csv')
results_exp3 = readtable('D:\Drive\3 - Mask\pwelch\pwelch_result\csv_export\results.csv')

settings.plot_4th = 1;
if settings.plot_4th == 1
    results_exp4 = readtable('D:\Drive\4 - Faces\pwelch\pwelch_result\csv_export\results.csv')
    results_exp5_obj = readtable('D:\Drive\5 - Scenes\pwelch\pwelch_result\obj\csv_export\results.csv')
    results_exp5_bgr = readtable('D:\Drive\5 - Scenes\pwelch\pwelch_result\bgr\csv_export\results.csv')
end




%% Plotting objective task

figure;



subplot(2,3,1)
hold on
scatter(1, squeeze(mean(results_exp1.difference_incid)), "red")
errorbar(1, squeeze(mean(results_exp1.difference_incid)),sem(results_exp1.difference_incid) , "red")
scatter(2, squeeze(mean(results_exp1.difference_corrid)), "blue")
errorbar(2, squeeze(mean(results_exp1.difference_corrid)),sem(results_exp1.difference_corrid), "blue")

scatter(3, squeeze(mean(results_exp3.difference_incid)), "red")
errorbar(3, squeeze(mean(results_exp3.difference_incid)),sem(results_exp3.difference_incid), "red")
scatter(4, squeeze(mean(results_exp3.difference_corrid)), "blue")
errorbar(4, squeeze(mean(results_exp3.difference_corrid)),sem(results_exp3.difference_corrid), "blue")
if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.difference_incid)), "red")
    errorbar(5, squeeze(mean(results_exp4.difference_incid)),sem(results_exp4.difference_incid), "red")
    scatter(6, squeeze(mean(results_exp4.difference_corrid)), "blue")
    errorbar(6, squeeze(mean(results_exp4.difference_corrid)),sem(results_exp4.difference_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.difference_incid)), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.difference_incid)),sem(results_exp5_obj.difference_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.difference_corrid)), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.difference_corrid)),sem(results_exp5_obj.difference_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.difference_incid)), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.difference_incid)),sem(results_exp5_bgr.difference_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.difference_corrid)), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.difference_corrid)),sem(results_exp5_bgr.difference_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.difference_corrid) mean(results_exp1.difference_incid) mean(results_exp3.difference_corrid) mean(results_exp3.difference_incid) mean(results_exp4.difference_corrid) mean(results_exp4.difference_incid)  mean(results_exp5_obj.difference_corrid) mean(results_exp5_obj.difference_incid)  mean(results_exp5_bgr.difference_corrid) mean(results_exp5_bgr.difference_incid)]));
    ylim_max = max(max([mean(results_exp1.difference_corrid) mean(results_exp1.difference_incid) mean(results_exp3.difference_corrid) mean(results_exp3.difference_incid) mean(results_exp4.difference_corrid) mean(results_exp4.difference_incid) mean(results_exp5_obj.difference_corrid) mean(results_exp5_obj.difference_incid)  mean(results_exp5_bgr.difference_corrid) mean(results_exp5_bgr.difference_incid)]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.difference_corrid) mean(results_exp1.difference_incid) mean(results_exp3.difference_corrid) mean(results_exp3.difference_incid)]));
ylim_max = max(max([mean(results_exp1.difference_corrid) mean(results_exp1.difference_incid) mean(results_exp3.difference_corrid) mean(results_exp3.difference_incid)]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end

xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Adjusted power')
hold off;




subplot(2,3,2)
hold on
scatter(2, squeeze(mean(results_exp1.central_freq_corrid)), "blue")
errorbar(2, squeeze(mean(results_exp1.central_freq_corrid)),sem(results_exp1.central_freq_corrid), "blue")
scatter(1, squeeze(mean(results_exp1.central_freq_incid)), "red")
errorbar(1, squeeze(mean(results_exp1.central_freq_incid)),sem(results_exp1.central_freq_incid), "red")

scatter(4, squeeze(mean(results_exp3.central_freq_corrid)), "blue")
errorbar(4, squeeze(mean(results_exp3.central_freq_corrid)),sem(results_exp3.central_freq_corrid), "blue")
scatter(3, squeeze(mean(results_exp3.central_freq_incid)), "red")
errorbar(3, squeeze(mean(results_exp3.central_freq_incid)),sem(results_exp3.central_freq_incid), "red")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.central_freq_incid)), "red")
    errorbar(5, squeeze(mean(results_exp4.central_freq_incid)),sem(results_exp4.central_freq_incid), "red")
    scatter(6, squeeze(mean(results_exp4.central_freq_corrid)), "blue")
    errorbar(6, squeeze(mean(results_exp4.central_freq_corrid)),sem(results_exp4.central_freq_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.central_freq_incid)), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.central_freq_incid)),sem(results_exp5_obj.central_freq_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.central_freq_corrid)), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.central_freq_corrid)),sem(results_exp5_obj.central_freq_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.central_freq_incid)), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.central_freq_incid)),sem(results_exp5_bgr.central_freq_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.central_freq_corrid)), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.central_freq_corrid)),sem(results_exp5_bgr.central_freq_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.central_freq_corrid) mean(results_exp1.central_freq_incid) mean(results_exp3.central_freq_corrid) mean(results_exp3.central_freq_incid) mean(results_exp4.central_freq_corrid) mean(results_exp4.central_freq_incid)  mean(results_exp5_obj.central_freq_corrid) mean(results_exp5_obj.central_freq_incid)  mean(results_exp5_bgr.central_freq_corrid) mean(results_exp5_bgr.central_freq_incid)]));
    ylim_max = max(max([mean(results_exp1.central_freq_corrid) mean(results_exp1.central_freq_incid) mean(results_exp3.central_freq_corrid) mean(results_exp3.central_freq_incid) mean(results_exp4.central_freq_corrid) mean(results_exp4.central_freq_incid)  mean(results_exp5_obj.central_freq_corrid) mean(results_exp5_obj.central_freq_incid)  mean(results_exp5_bgr.central_freq_corrid) mean(results_exp5_bgr.central_freq_incid)]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.central_freq_corrid) mean(results_exp1.central_freq_incid) mean(results_exp3.central_freq_corrid) mean(results_exp3.central_freq_incid)]));
    ylim_max = max(max([mean(results_exp1.central_freq_corrid) mean(results_exp1.central_freq_incid) mean(results_exp3.central_freq_corrid) mean(results_exp3.central_freq_incid)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('central freq')
hold off;



subplot(2,3,3)
hold on
scatter(2, squeeze(mean(results_exp1.bandwith_freq_corrid)), "blue")
errorbar(2, squeeze(mean(results_exp1.bandwith_freq_corrid)),sem(results_exp1.bandwith_freq_corrid), "blue")
scatter(1, squeeze(mean(results_exp1.bandwith_freq_incid)), "red")
errorbar(1, squeeze(mean(results_exp1.bandwith_freq_incid)),sem(results_exp1.bandwith_freq_incid), "red")

scatter(4, squeeze(mean(results_exp3.bandwith_freq_corrid)), "blue")
errorbar(4, squeeze(mean(results_exp3.bandwith_freq_corrid)),sem(results_exp3.bandwith_freq_corrid), "blue")
scatter(3, squeeze(mean(results_exp3.bandwith_freq_incid)), "red")
errorbar(3, squeeze(mean(results_exp3.bandwith_freq_incid)),sem(results_exp3.bandwith_freq_incid), "red")


if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.bandwith_freq_incid)), "red")
    errorbar(5, squeeze(mean(results_exp4.bandwith_freq_incid)),sem(results_exp4.bandwith_freq_incid), "red")
    scatter(6, squeeze(mean(results_exp4.bandwith_freq_corrid)), "blue")
    errorbar(6, squeeze(mean(results_exp4.bandwith_freq_corrid)),sem(results_exp4.bandwith_freq_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.bandwith_freq_incid)), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.bandwith_freq_incid)),sem(results_exp5_obj.bandwith_freq_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.bandwith_freq_corrid)), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.bandwith_freq_corrid)),sem(results_exp5_obj.bandwith_freq_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.bandwith_freq_incid)), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.bandwith_freq_incid)),sem(results_exp5_bgr.bandwith_freq_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.bandwith_freq_corrid)), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.bandwith_freq_corrid)),sem(results_exp5_bgr.bandwith_freq_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.bandwith_freq_corrid) mean(results_exp1.bandwith_freq_incid) mean(results_exp3.bandwith_freq_corrid) mean(results_exp3.bandwith_freq_incid) mean(results_exp4.bandwith_freq_corrid) mean(results_exp4.bandwith_freq_incid)  mean(results_exp5_obj.bandwith_freq_corrid) mean(results_exp5_obj.bandwith_freq_incid)  mean(results_exp5_bgr.bandwith_freq_corrid) mean(results_exp5_bgr.bandwith_freq_incid)]));
    ylim_max = max(max([mean(results_exp1.bandwith_freq_corrid) mean(results_exp1.bandwith_freq_incid) mean(results_exp3.bandwith_freq_corrid) mean(results_exp3.bandwith_freq_incid) mean(results_exp4.bandwith_freq_corrid) mean(results_exp4.bandwith_freq_incid)  mean(results_exp5_obj.bandwith_freq_corrid) mean(results_exp5_obj.bandwith_freq_incid)  mean(results_exp5_bgr.bandwith_freq_corrid) mean(results_exp5_bgr.bandwith_freq_incid)]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.bandwith_freq_corrid) mean(results_exp1.bandwith_freq_incid) mean(results_exp3.bandwith_freq_corrid) mean(results_exp3.bandwith_freq_incid)]));
    ylim_max = max(max([mean(results_exp1.bandwith_freq_corrid) mean(results_exp1.bandwith_freq_incid) mean(results_exp3.bandwith_freq_corrid) mean(results_exp3.bandwith_freq_incid)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end

xlabel(' ')

if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Bandwith')
hold off;







hold on; 
subplot(2,3,4)
hold on;
scatter(1, squeeze(mean(results_exp1.aperiodic_incid)), "red")
errorbar(1, squeeze(mean(results_exp1.aperiodic_incid)),sem(results_exp1.aperiodic_incid), "red")
scatter(2, squeeze(mean(results_exp1.aperiodic_corrid)), "blue")
errorbar(2, squeeze(mean(results_exp1.aperiodic_corrid)),sem(results_exp1.aperiodic_corrid), "blue")

scatter(3, squeeze(mean(results_exp3.aperiodic_incid)), "red")
errorbar(3, squeeze(mean(results_exp3.aperiodic_incid)),sem(results_exp3.aperiodic_incid), "red")
scatter(4, squeeze(mean(results_exp3.aperiodic_corrid)), "blue")
errorbar(4, squeeze(mean(results_exp3.aperiodic_corrid)),sem(results_exp3.aperiodic_corrid), "blue")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.aperiodic_incid)), "red")
    errorbar(5, squeeze(mean(results_exp4.aperiodic_incid)),sem(results_exp4.aperiodic_incid), "red")
    scatter(6, squeeze(mean(results_exp4.aperiodic_corrid)), "blue")
    errorbar(6, squeeze(mean(results_exp4.aperiodic_corrid)),sem(results_exp4.aperiodic_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.aperiodic_incid)), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.aperiodic_incid)),sem(results_exp5_obj.aperiodic_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.aperiodic_corrid)), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.aperiodic_corrid)),sem(results_exp5_obj.aperiodic_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.aperiodic_incid)), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.aperiodic_incid)),sem(results_exp5_bgr.aperiodic_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.aperiodic_corrid)), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.aperiodic_corrid)),sem(results_exp5_bgr.aperiodic_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.aperiodic_corrid) mean(results_exp1.aperiodic_incid) mean(results_exp3.aperiodic_corrid) mean(results_exp3.aperiodic_incid) mean(results_exp4.aperiodic_corrid) mean(results_exp4.aperiodic_incid) mean(results_exp5_obj.aperiodic_corrid) mean(results_exp5_obj.aperiodic_incid)  mean(results_exp5_bgr.aperiodic_corrid) mean(results_exp5_bgr.aperiodic_incid)]));
    ylim_max = max(max([mean(results_exp1.aperiodic_corrid) mean(results_exp1.aperiodic_incid) mean(results_exp3.aperiodic_corrid) mean(results_exp3.aperiodic_incid) mean(results_exp4.aperiodic_corrid) mean(results_exp4.aperiodic_incid) mean(results_exp5_obj.aperiodic_corrid) mean(results_exp5_obj.aperiodic_incid)  mean(results_exp5_bgr.aperiodic_corrid) mean(results_exp5_bgr.aperiodic_incid)]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.aperiodic_corrid) mean(results_exp1.aperiodic_incid) mean(results_exp3.aperiodic_corrid) mean(results_exp3.aperiodic_incid)]));
    ylim_max = max(max([mean(results_exp1.aperiodic_corrid) mean(results_exp1.aperiodic_incid) mean(results_exp3.aperiodic_corrid) mean(results_exp3.aperiodic_incid)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end

    xlabel(' ')

if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct';}
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end

title('Aperiodic activity')
hold off;


subplot(2,3,5)
hold on
scatter(2, squeeze(mean(results_exp1.exponent_corrid)), "blue")
errorbar(2, squeeze(mean(results_exp1.exponent_corrid)),sem(results_exp1.exponent_corrid), "blue")
scatter(1, squeeze(mean(results_exp1.exponent_incid)), "red")
errorbar(1, squeeze(mean(results_exp1.exponent_incid)),sem(results_exp1.exponent_incid), "red")

scatter(4, squeeze(mean(results_exp3.exponent_corrid)), "blue")
errorbar(4, squeeze(mean(results_exp3.exponent_corrid)),sem(results_exp3.exponent_corrid), "blue")
scatter(3, squeeze(mean(results_exp3.exponent_incid)), "red")
errorbar(3, squeeze(mean(results_exp3.exponent_incid)),sem(results_exp3.exponent_incid), "red")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.exponent_incid)), "red")
    errorbar(5, squeeze(mean(results_exp4.exponent_incid)),sem(results_exp4.exponent_incid), "red")
    scatter(6, squeeze(mean(results_exp4.exponent_corrid)), "blue")
    errorbar(6, squeeze(mean(results_exp4.exponent_corrid)),sem(results_exp4.exponent_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.exponent_incid)), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.exponent_incid)),sem(results_exp5_obj.exponent_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.exponent_corrid)), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.exponent_corrid)),sem(results_exp5_obj.exponent_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.exponent_incid)), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.exponent_incid)),sem(results_exp5_bgr.exponent_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.exponent_corrid)), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.exponent_corrid)),sem(results_exp5_bgr.exponent_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.exponent_corrid) mean(results_exp1.exponent_incid) mean(results_exp3.exponent_corrid) mean(results_exp3.exponent_incid) mean(results_exp4.exponent_corrid) mean(results_exp4.exponent_incid) mean(results_exp5_obj.exponent_corrid) mean(results_exp5_obj.exponent_incid)  mean(results_exp5_bgr.exponent_corrid) mean(results_exp5_bgr.exponent_incid)]));
    ylim_max = max(max([mean(results_exp1.exponent_corrid) mean(results_exp1.exponent_incid) mean(results_exp3.exponent_corrid) mean(results_exp3.exponent_incid) mean(results_exp4.exponent_corrid) mean(results_exp4.exponent_incid) mean(results_exp5_obj.exponent_corrid) mean(results_exp5_obj.exponent_incid)  mean(results_exp5_bgr.exponent_corrid) mean(results_exp5_bgr.exponent_incid)]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.exponent_corrid) mean(results_exp1.exponent_incid) mean(results_exp3.exponent_corrid) mean(results_exp3.exponent_incid)]));
ylim_max = max(max([mean(results_exp1.exponent_corrid) mean(results_exp1.exponent_incid) mean(results_exp3.exponent_corrid) mean(results_exp3.exponent_incid)]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end
xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Exponent')
hold off;

subplot(2,3,6)
hold on
scatter(2, squeeze(mean(results_exp1.offset_flat_corrid)), "blue")
errorbar(2, squeeze(mean(results_exp1.offset_flat_corrid)),sem(results_exp1.offset_flat_corrid), "blue")
scatter(1, squeeze(mean(results_exp1.offset_flat_incid)), "red")
errorbar(1, squeeze(mean(results_exp1.offset_flat_incid)),sem(results_exp1.offset_flat_incid), "red")

scatter(4, squeeze(mean(results_exp3.offset_flat_corrid)), "blue")
errorbar(4, squeeze(mean(results_exp3.offset_flat_corrid)),sem(results_exp3.offset_flat_corrid), "blue")
scatter(3, squeeze(mean(results_exp3.offset_flat_incid)), "red")
errorbar(3, squeeze(mean(results_exp3.offset_flat_incid)),sem(results_exp3.offset_flat_incid), "red")

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.offset_flat_incid)), "red")
    errorbar(5, squeeze(mean(results_exp4.offset_flat_incid)),sem(results_exp4.offset_flat_incid), "red")
    scatter(6, squeeze(mean(results_exp4.offset_flat_corrid)), "blue")
    errorbar(6, squeeze(mean(results_exp4.offset_flat_corrid)),sem(results_exp4.offset_flat_corrid), "blue")


    scatter(7, squeeze(mean(results_exp5_obj.offset_flat_incid)), "red")
    errorbar(7, squeeze(mean(results_exp5_obj.offset_flat_incid)),sem(results_exp5_obj.offset_flat_incid), "red")
    scatter(8, squeeze(mean(results_exp5_obj.offset_flat_corrid)), "blue")
    errorbar(8, squeeze(mean(results_exp5_obj.offset_flat_corrid)),sem(results_exp5_obj.offset_flat_corrid), "blue")


    scatter(9, squeeze(mean(results_exp5_bgr.offset_flat_incid)), "red")
    errorbar(9, squeeze(mean(results_exp5_bgr.offset_flat_incid)),sem(results_exp5_bgr.offset_flat_incid), "red")
    scatter(10, squeeze(mean(results_exp5_bgr.offset_flat_corrid)), "blue")
    errorbar(10, squeeze(mean(results_exp5_bgr.offset_flat_corrid)),sem(results_exp5_bgr.offset_flat_corrid), "blue")
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.offset_flat_corrid) mean(results_exp1.offset_flat_incid) mean(results_exp3.offset_flat_corrid) mean(results_exp3.offset_flat_incid) mean(results_exp4.offset_flat_corrid) mean(results_exp4.offset_flat_incid) mean(results_exp5_obj.offset_flat_corrid) mean(results_exp5_obj.offset_flat_incid)  mean(results_exp5_bgr.offset_flat_corrid) mean(results_exp5_bgr.offset_flat_incid)]));
    ylim_max = max(max([mean(results_exp1.offset_flat_corrid) mean(results_exp1.offset_flat_incid) mean(results_exp3.offset_flat_corrid) mean(results_exp3.offset_flat_incid) mean(results_exp4.offset_flat_corrid) mean(results_exp4.offset_flat_incid) mean(results_exp5_obj.offset_flat_corrid) mean(results_exp5_obj.offset_flat_incid)  mean(results_exp5_bgr.offset_flat_corrid) mean(results_exp5_bgr.offset_flat_incid)]));
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.offset_flat_corrid) mean(results_exp1.offset_flat_incid) mean(results_exp3.offset_flat_corrid) mean(results_exp3.offset_flat_incid)]));
    ylim_max = max(max([mean(results_exp1.offset_flat_corrid) mean(results_exp1.offset_flat_incid) mean(results_exp3.offset_flat_corrid) mean(results_exp3.offset_flat_incid)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end




xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Incorrect'; 'Correct';'Incorrect'; 'Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6, 7, 8, 9, 10])
%label_pas = {'Incorrect';'Correct'; 'Incorrect'; 'Correct'; 'Incorrect'; 'Correct'; ' Obj Incorrect'; ' Obj Correct'; ' Bgr Incorrect'; ' Bgr Correct';}
%xticklabels(label_pas)
xline(2.5)
xline(4.5)
xline(6.5)
xline(8.5)
xlim([0 11])
end
title('Offset')
hold off;





%% plotting subjective task


figure;
hold on; 
subplot(2,3,1)
hold on;
scatter(1, squeeze(mean(results_exp1.aperiodic_lowpas)))
errorbar(1, squeeze(mean(results_exp1.aperiodic_lowpas)),sem(results_exp1.aperiodic_lowpas))
scatter(2, squeeze(mean(results_exp1.aperiodic_highpas)))
errorbar(2, squeeze(mean(results_exp1.aperiodic_highpas)),sem(results_exp1.aperiodic_highpas))

scatter(3, squeeze(mean(results_exp3.aperiodic_lowpas)))
errorbar(3, squeeze(mean(results_exp3.aperiodic_lowpas)),sem(results_exp3.aperiodic_lowpas))
scatter(4, squeeze(mean(results_exp3.aperiodic_highpas)))
errorbar(4, squeeze(mean(results_exp3.aperiodic_highpas)),sem(results_exp3.aperiodic_highpas))

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.aperiodic_lowpas)))
    errorbar(5, squeeze(mean(results_exp4.aperiodic_lowpas)),sem(results_exp4.aperiodic_lowpas))
    scatter(6, squeeze(mean(results_exp4.aperiodic_highpas)))
    errorbar(6, squeeze(mean(results_exp4.aperiodic_highpas)),sem(results_exp4.aperiodic_highpas))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.aperiodic_highpas) mean(results_exp1.aperiodic_lowpas) mean(results_exp3.aperiodic_highpas) mean(results_exp3.aperiodic_lowpas) mean(results_exp4.aperiodic_highpas) mean(results_exp4.aperiodic_lowpas)]));
    ylim_max = max(max([mean(results_exp1.aperiodic_highpas) mean(results_exp1.aperiodic_lowpas) mean(results_exp3.aperiodic_highpas) mean(results_exp3.aperiodic_lowpas) mean(results_exp4.aperiodic_highpas) mean(results_exp4.aperiodic_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.aperiodic_highpas) mean(results_exp1.aperiodic_lowpas) mean(results_exp3.aperiodic_highpas) mean(results_exp3.aperiodic_lowpas)]));
    ylim_max = max(max([mean(results_exp1.aperiodic_highpas) mean(results_exp1.aperiodic_lowpas) mean(results_exp3.aperiodic_highpas) mean(results_exp3.aperiodic_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end

    xlabel(' ')

if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS';}
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end

title('Aperiodic Activity')
hold off;


subplot(2,3,2)
hold on
scatter(1, squeeze(mean(results_exp1.difference_lowpas)))
errorbar(1, squeeze(mean(results_exp1.difference_lowpas)),sem(results_exp1.difference_lowpas))
scatter(2, squeeze(mean(results_exp1.difference_highpas)))
errorbar(2, squeeze(mean(results_exp1.difference_highpas)),sem(results_exp1.difference_highpas))

scatter(3, squeeze(mean(results_exp3.difference_lowpas)))
errorbar(3, squeeze(mean(results_exp3.difference_lowpas)),sem(results_exp3.difference_lowpas))
scatter(4, squeeze(mean(results_exp3.difference_highpas)))
errorbar(4, squeeze(mean(results_exp3.difference_highpas)),sem(results_exp3.difference_highpas))
if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.difference_lowpas)))
    errorbar(5, squeeze(mean(results_exp4.difference_lowpas)),sem(results_exp4.difference_lowpas))
    scatter(6, squeeze(mean(results_exp4.difference_highpas)))
    errorbar(6, squeeze(mean(results_exp4.difference_highpas)),sem(results_exp4.difference_highpas))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.difference_highpas) mean(results_exp1.difference_lowpas) mean(results_exp3.difference_highpas) mean(results_exp3.difference_lowpas) mean(results_exp4.difference_highpas) mean(results_exp4.difference_lowpas)]));
    ylim_max = max(max([mean(results_exp1.difference_highpas) mean(results_exp1.difference_lowpas) mean(results_exp3.difference_highpas) mean(results_exp3.difference_lowpas) mean(results_exp4.difference_highpas) mean(results_exp4.difference_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.difference_highpas) mean(results_exp1.difference_lowpas) mean(results_exp3.difference_highpas) mean(results_exp3.difference_lowpas)]));
ylim_max = max(max([mean(results_exp1.difference_highpas) mean(results_exp1.difference_lowpas) mean(results_exp3.difference_highpas) mean(results_exp3.difference_lowpas)]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end

xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Adjusted power')
hold off;

subplot(2,3,3)
hold on
scatter(2, squeeze(mean(results_exp1.exponent_highpas)))
errorbar(2, squeeze(mean(results_exp1.exponent_highpas)),sem(results_exp1.exponent_highpas))
scatter(1, squeeze(mean(results_exp1.exponent_lowpas)))
errorbar(1, squeeze(mean(results_exp1.exponent_lowpas)),sem(results_exp1.exponent_lowpas))

scatter(4, squeeze(mean(results_exp3.exponent_highpas)))
errorbar(4, squeeze(mean(results_exp3.exponent_highpas)),sem(results_exp3.exponent_highpas))
scatter(3, squeeze(mean(results_exp3.exponent_lowpas)))
errorbar(3, squeeze(mean(results_exp3.exponent_lowpas)),sem(results_exp3.exponent_lowpas))

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.exponent_lowpas)))
    errorbar(5, squeeze(mean(results_exp4.exponent_lowpas)),sem(results_exp4.exponent_lowpas))
    scatter(6, squeeze(mean(results_exp4.exponent_highpas)))
    errorbar(6, squeeze(mean(results_exp4.exponent_highpas)),sem(results_exp4.exponent_highpas))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.exponent_highpas) mean(results_exp1.exponent_lowpas) mean(results_exp3.exponent_highpas) mean(results_exp3.exponent_lowpas) mean(results_exp4.exponent_highpas) mean(results_exp4.exponent_lowpas)]));
    ylim_max = max(max([mean(results_exp1.exponent_highpas) mean(results_exp1.exponent_lowpas) mean(results_exp3.exponent_highpas) mean(results_exp3.exponent_lowpas) mean(results_exp4.exponent_highpas) mean(results_exp4.exponent_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.exponent_highpas) mean(results_exp1.exponent_lowpas) mean(results_exp3.exponent_highpas) mean(results_exp3.exponent_lowpas)]));
ylim_max = max(max([mean(results_exp1.exponent_highpas) mean(results_exp1.exponent_lowpas) mean(results_exp3.exponent_highpas) mean(results_exp3.exponent_lowpas)]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end
xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Exponent')
hold off;


subplot(2,3,4)
hold on
scatter(2, squeeze(mean(results_exp1.offset_flat_highpas)))
errorbar(2, squeeze(mean(results_exp1.offset_flat_highpas)),sem(results_exp1.offset_flat_highpas))
scatter(1, squeeze(mean(results_exp1.offset_flat_lowpas)))
errorbar(1, squeeze(mean(results_exp1.offset_flat_lowpas)),sem(results_exp1.offset_flat_lowpas))

scatter(4, squeeze(mean(results_exp3.offset_flat_highpas)))
errorbar(4, squeeze(mean(results_exp3.offset_flat_highpas)),sem(results_exp3.offset_flat_highpas))
scatter(3, squeeze(mean(results_exp3.offset_flat_lowpas)))
errorbar(3, squeeze(mean(results_exp3.offset_flat_lowpas)),sem(results_exp3.offset_flat_lowpas))

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.offset_flat_lowpas)))
    errorbar(5, squeeze(mean(results_exp4.offset_flat_lowpas)),sem(results_exp4.offset_flat_lowpas))
    scatter(6, squeeze(mean(results_exp4.offset_flat_highpas)))
    errorbar(6, squeeze(mean(results_exp4.offset_flat_highpas)),sem(results_exp4.offset_flat_highpas))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.offset_flat_highpas) mean(results_exp1.offset_flat_lowpas) mean(results_exp3.offset_flat_highpas) mean(results_exp3.offset_flat_lowpas) mean(results_exp4.offset_flat_highpas) mean(results_exp4.offset_flat_lowpas)]));
    ylim_max = max(max([mean(results_exp1.offset_flat_highpas) mean(results_exp1.offset_flat_lowpas) mean(results_exp3.offset_flat_highpas) mean(results_exp3.offset_flat_lowpas) mean(results_exp4.offset_flat_highpas) mean(results_exp4.offset_flat_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.offset_flat_highpas) mean(results_exp1.offset_flat_lowpas) mean(results_exp3.offset_flat_highpas) mean(results_exp3.offset_flat_lowpas)]));
    ylim_max = max(max([mean(results_exp1.offset_flat_highpas) mean(results_exp1.offset_flat_lowpas) mean(results_exp3.offset_flat_highpas) mean(results_exp3.offset_flat_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end




xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Offset')
hold off;



subplot(2,3,5)
hold on
scatter(2, squeeze(mean(results_exp1.central_freq_highpas)))
errorbar(2, squeeze(mean(results_exp1.central_freq_highpas)),sem(results_exp1.central_freq_highpas))
scatter(1, squeeze(mean(results_exp1.central_freq_lowpas)))
errorbar(1, squeeze(mean(results_exp1.central_freq_lowpas)),sem(results_exp1.central_freq_lowpas))

scatter(4, squeeze(mean(results_exp3.central_freq_highpas)))
errorbar(4, squeeze(mean(results_exp3.central_freq_highpas)),sem(results_exp3.central_freq_highpas))
scatter(3, squeeze(mean(results_exp3.central_freq_lowpas)))
errorbar(3, squeeze(mean(results_exp3.central_freq_lowpas)),sem(results_exp3.central_freq_lowpas))

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.central_freq_lowpas)))
    errorbar(5, squeeze(mean(results_exp4.central_freq_lowpas)),sem(results_exp4.central_freq_lowpas))
    scatter(6, squeeze(mean(results_exp4.central_freq_highpas)))
    errorbar(6, squeeze(mean(results_exp4.central_freq_highpas)),sem(results_exp4.central_freq_highpas))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.central_freq_highpas) mean(results_exp1.central_freq_lowpas) mean(results_exp3.central_freq_highpas) mean(results_exp3.central_freq_lowpas) mean(results_exp4.central_freq_highpas) mean(results_exp4.central_freq_lowpas)]));
    ylim_max = max(max([mean(results_exp1.central_freq_highpas) mean(results_exp1.central_freq_lowpas) mean(results_exp3.central_freq_highpas) mean(results_exp3.central_freq_lowpas) mean(results_exp4.central_freq_highpas) mean(results_exp4.central_freq_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.central_freq_highpas) mean(results_exp1.central_freq_lowpas) mean(results_exp3.central_freq_highpas) mean(results_exp3.central_freq_lowpas)]));
    ylim_max = max(max([mean(results_exp1.central_freq_highpas) mean(results_exp1.central_freq_lowpas) mean(results_exp3.central_freq_highpas) mean(results_exp3.central_freq_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('central freq')
hold off;



subplot(2,3,6)
hold on
scatter(2, squeeze(mean(results_exp1.bandwith_freq_highpas)))
errorbar(2, squeeze(mean(results_exp1.bandwith_freq_highpas)),sem(results_exp1.bandwith_freq_highpas))
scatter(1, squeeze(mean(results_exp1.bandwith_freq_lowpas)))
errorbar(1, squeeze(mean(results_exp1.bandwith_freq_lowpas)),sem(results_exp1.bandwith_freq_lowpas))

scatter(4, squeeze(mean(results_exp3.bandwith_freq_highpas)))
errorbar(4, squeeze(mean(results_exp3.bandwith_freq_highpas)),sem(results_exp3.bandwith_freq_highpas))
scatter(3, squeeze(mean(results_exp3.bandwith_freq_lowpas)))
errorbar(3, squeeze(mean(results_exp3.bandwith_freq_lowpas)),sem(results_exp3.bandwith_freq_lowpas))


if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.bandwith_freq_lowpas)))
    errorbar(5, squeeze(mean(results_exp4.bandwith_freq_lowpas)),sem(results_exp4.bandwith_freq_lowpas))
    scatter(6, squeeze(mean(results_exp4.central_freq_highpas)))
    errorbar(6, squeeze(mean(results_exp4.central_freq_highpas)),sem(results_exp4.central_freq_highpas))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.bandwith_freq_highpas) mean(results_exp1.bandwith_freq_lowpas) mean(results_exp3.bandwith_freq_highpas) mean(results_exp3.bandwith_freq_lowpas) mean(results_exp4.bandwith_freq_highpas) mean(results_exp4.bandwith_freq_lowpas)]));
    ylim_max = max(max([mean(results_exp1.bandwith_freq_highpas) mean(results_exp1.bandwith_freq_lowpas) mean(results_exp3.bandwith_freq_highpas) mean(results_exp3.bandwith_freq_lowpas) mean(results_exp4.bandwith_freq_highpas) mean(results_exp4.bandwith_freq_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
    ylim_min = min(min([mean(results_exp1.bandwith_freq_highpas) mean(results_exp1.bandwith_freq_lowpas) mean(results_exp3.bandwith_freq_highpas) mean(results_exp3.bandwith_freq_lowpas)]));
    ylim_max = max(max([mean(results_exp1.bandwith_freq_highpas) mean(results_exp1.bandwith_freq_lowpas) mean(results_exp3.bandwith_freq_highpas) mean(results_exp3.bandwith_freq_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end

xlabel(' ')

if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'Low PAS'; 'High PAS';'Low PAS'; 'High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'Low PAS';'High PAS'; 'Low PAS'; 'High PAS'; 'Low PAS'; 'High PAS';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Bandwith')
hold off;
