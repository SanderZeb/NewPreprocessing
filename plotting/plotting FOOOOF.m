results_exp1 = readtable('D:\Drive\1 - Threshold\pwelch\pwelch_result\csv_export\results.csv')
results_exp3 = readtable('D:\Drive\3 - Mask\pwelch\pwelch_result\csv_export\results.csv')

settings.plot_4th = 1;
if settings.plot_4th == 1
    results_exp4 = readtable('D:\Drive\4 - Faces\pwelch\pwelch_result\csv_export\results.csv')
end
%% Plotting objective task

figure;
hold on; 
subplot(2,3,1)
hold on;
scatter(1, squeeze(mean(results_exp1.aperiodic_incid)))
errorbar(1, squeeze(mean(results_exp1.aperiodic_incid)),sem(results_exp1.aperiodic_incid))
scatter(2, squeeze(mean(results_exp1.aperiodic_corrid)))
errorbar(2, squeeze(mean(results_exp1.aperiodic_corrid)),sem(results_exp1.aperiodic_corrid))

scatter(3, squeeze(mean(results_exp3.aperiodic_incid)))
errorbar(3, squeeze(mean(results_exp3.aperiodic_incid)),sem(results_exp3.aperiodic_incid))
scatter(4, squeeze(mean(results_exp3.aperiodic_corrid)))
errorbar(4, squeeze(mean(results_exp3.aperiodic_corrid)),sem(results_exp3.aperiodic_corrid))

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.aperiodic_incid)))
    errorbar(5, squeeze(mean(results_exp4.aperiodic_incid)),sem(results_exp4.aperiodic_incid))
    scatter(6, squeeze(mean(results_exp4.aperiodic_corrid)))
    errorbar(6, squeeze(mean(results_exp4.aperiodic_corrid)),sem(results_exp4.aperiodic_corrid))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.aperiodic_corrid) mean(results_exp1.aperiodic_incid) mean(results_exp3.aperiodic_corrid) mean(results_exp3.aperiodic_incid) mean(results_exp4.aperiodic_corrid) mean(results_exp4.aperiodic_incid)]));
    ylim_max = max(max([mean(results_exp1.aperiodic_corrid) mean(results_exp1.aperiodic_incid) mean(results_exp3.aperiodic_corrid) mean(results_exp3.aperiodic_incid) mean(results_exp4.aperiodic_corrid) mean(results_exp4.aperiodic_incid)]))
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
label_pas = {'EXP1 Incorrect';'EXP1 Correct'; 'EXP3 Incorrect'; 'EXP3 Correct';}
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Incorrect';'EXP1 Correct'; 'EXP3 Incorrect'; 'EXP3 Correct'; 'EXP4 Incorrect'; 'EXP4 Correct';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end

title('Aperiodic Activity')
hold off;


subplot(2,3,2)
hold on
scatter(1, squeeze(mean(results_exp1.spectra_incid)))
errorbar(1, squeeze(mean(results_exp1.spectra_incid)),sem(results_exp1.spectra_incid))
scatter(2, squeeze(mean(results_exp1.spectra_corrid)))
errorbar(2, squeeze(mean(results_exp1.spectra_corrid)),sem(results_exp1.spectra_corrid))

scatter(3, squeeze(mean(results_exp3.spectra_incid)))
errorbar(3, squeeze(mean(results_exp3.spectra_incid)),sem(results_exp3.spectra_incid))
scatter(4, squeeze(mean(results_exp3.spectra_corrid)))
errorbar(4, squeeze(mean(results_exp3.spectra_corrid)),sem(results_exp3.spectra_corrid))
if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.spectra_incid)))
    errorbar(5, squeeze(mean(results_exp4.spectra_incid)),sem(results_exp4.spectra_incid))
    scatter(6, squeeze(mean(results_exp4.spectra_corrid)))
    errorbar(6, squeeze(mean(results_exp4.spectra_corrid)),sem(results_exp4.spectra_corrid))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.spectra_corrid) mean(results_exp1.spectra_incid) mean(results_exp3.spectra_corrid) mean(results_exp3.spectra_incid) mean(results_exp4.spectra_corrid) mean(results_exp4.spectra_incid)]));
    ylim_max = max(max([mean(results_exp1.spectra_corrid) mean(results_exp1.spectra_incid) mean(results_exp3.spectra_corrid) mean(results_exp3.spectra_incid) mean(results_exp4.spectra_corrid) mean(results_exp4.spectra_incid)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.spectra_corrid) mean(results_exp1.spectra_incid) mean(results_exp3.spectra_corrid) mean(results_exp3.spectra_incid)]));
ylim_max = max(max([mean(results_exp1.spectra_corrid) mean(results_exp1.spectra_incid) mean(results_exp3.spectra_corrid) mean(results_exp3.spectra_incid)]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end

xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'EXP1 Incorrect'; 'EXP1 Correct';'EXP3 Incorrect'; 'EXP3 Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Incorrect';'EXP1 Correct'; 'EXP3 Incorrect'; 'EXP3 Correct'; 'EXP4 Incorrect'; 'EXP4 Correct';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Power')
hold off;

subplot(2,3,3)
hold on
scatter(2, squeeze(mean(results_exp1.exponent_corrid)))
errorbar(2, squeeze(mean(results_exp1.exponent_corrid)),sem(results_exp1.exponent_corrid))
scatter(1, squeeze(mean(results_exp1.exponent_incid)))
errorbar(1, squeeze(mean(results_exp1.exponent_incid)),sem(results_exp1.exponent_incid))

scatter(4, squeeze(mean(results_exp3.exponent_corrid)))
errorbar(4, squeeze(mean(results_exp3.exponent_corrid)),sem(results_exp3.exponent_corrid))
scatter(3, squeeze(mean(results_exp3.exponent_incid)))
errorbar(3, squeeze(mean(results_exp3.exponent_incid)),sem(results_exp3.exponent_incid))

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.exponent_incid)))
    errorbar(5, squeeze(mean(results_exp4.exponent_incid)),sem(results_exp4.exponent_incid))
    scatter(6, squeeze(mean(results_exp4.exponent_corrid)))
    errorbar(6, squeeze(mean(results_exp4.exponent_corrid)),sem(results_exp4.exponent_corrid))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.exponent_corrid) mean(results_exp1.exponent_incid) mean(results_exp3.exponent_corrid) mean(results_exp3.exponent_incid) mean(results_exp4.exponent_corrid) mean(results_exp4.exponent_incid)]));
    ylim_max = max(max([mean(results_exp1.exponent_corrid) mean(results_exp1.exponent_incid) mean(results_exp3.exponent_corrid) mean(results_exp3.exponent_incid) mean(results_exp4.exponent_corrid) mean(results_exp4.exponent_incid)]))
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
label_pas = {'EXP1 Incorrect'; 'EXP1 Correct';'EXP3 Incorrect'; 'EXP3 Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Incorrect';'EXP1 Correct'; 'EXP3 Incorrect'; 'EXP3 Correct'; 'EXP4 Incorrect'; 'EXP4 Correct';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Exponent')
hold off;


subplot(2,3,4)
hold on
scatter(2, squeeze(mean(results_exp1.offset_flat_corrid)))
errorbar(2, squeeze(mean(results_exp1.offset_flat_corrid)),sem(results_exp1.offset_flat_corrid))
scatter(1, squeeze(mean(results_exp1.offset_flat_incid)))
errorbar(1, squeeze(mean(results_exp1.offset_flat_incid)),sem(results_exp1.offset_flat_incid))

scatter(4, squeeze(mean(results_exp3.offset_flat_corrid)))
errorbar(4, squeeze(mean(results_exp3.offset_flat_corrid)),sem(results_exp3.offset_flat_corrid))
scatter(3, squeeze(mean(results_exp3.offset_flat_incid)))
errorbar(3, squeeze(mean(results_exp3.offset_flat_incid)),sem(results_exp3.offset_flat_incid))

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.offset_flat_incid)))
    errorbar(5, squeeze(mean(results_exp4.offset_flat_incid)),sem(results_exp4.offset_flat_incid))
    scatter(6, squeeze(mean(results_exp4.offset_flat_corrid)))
    errorbar(6, squeeze(mean(results_exp4.offset_flat_corrid)),sem(results_exp4.offset_flat_corrid))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.offset_flat_corrid) mean(results_exp1.offset_flat_incid) mean(results_exp3.offset_flat_corrid) mean(results_exp3.offset_flat_incid) mean(results_exp4.offset_flat_corrid) mean(results_exp4.offset_flat_incid)]));
    ylim_max = max(max([mean(results_exp1.offset_flat_corrid) mean(results_exp1.offset_flat_incid) mean(results_exp3.offset_flat_corrid) mean(results_exp3.offset_flat_incid) mean(results_exp4.offset_flat_corrid) mean(results_exp4.offset_flat_incid)]))
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
label_pas = {'EXP1 Incorrect'; 'EXP1 Correct';'EXP3 Incorrect'; 'EXP3 Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Incorrect';'EXP1 Correct'; 'EXP3 Incorrect'; 'EXP3 Correct'; 'EXP4 Incorrect'; 'EXP4 Correct';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Offset')
hold off;



subplot(2,3,5)
hold on
scatter(2, squeeze(mean(results_exp1.central_freq_corrid)))
errorbar(2, squeeze(mean(results_exp1.central_freq_corrid)),sem(results_exp1.central_freq_corrid))
scatter(1, squeeze(mean(results_exp1.central_freq_incid)))
errorbar(1, squeeze(mean(results_exp1.central_freq_incid)),sem(results_exp1.central_freq_incid))

scatter(4, squeeze(mean(results_exp3.central_freq_corrid)))
errorbar(4, squeeze(mean(results_exp3.central_freq_corrid)),sem(results_exp3.central_freq_corrid))
scatter(3, squeeze(mean(results_exp3.central_freq_incid)))
errorbar(3, squeeze(mean(results_exp3.central_freq_incid)),sem(results_exp3.central_freq_incid))

if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.central_freq_incid)))
    errorbar(5, squeeze(mean(results_exp4.central_freq_incid)),sem(results_exp4.central_freq_incid))
    scatter(6, squeeze(mean(results_exp4.central_freq_corrid)))
    errorbar(6, squeeze(mean(results_exp4.central_freq_corrid)),sem(results_exp4.central_freq_corrid))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.central_freq_corrid) mean(results_exp1.central_freq_incid) mean(results_exp3.central_freq_corrid) mean(results_exp3.central_freq_incid) mean(results_exp4.central_freq_corrid) mean(results_exp4.central_freq_incid)]));
    ylim_max = max(max([mean(results_exp1.central_freq_corrid) mean(results_exp1.central_freq_incid) mean(results_exp3.central_freq_corrid) mean(results_exp3.central_freq_incid) mean(results_exp4.central_freq_corrid) mean(results_exp4.central_freq_incid)]))
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
label_pas = {'EXP1 Incorrect'; 'EXP1 Correct';'EXP3 Incorrect'; 'EXP3 Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Incorrect';'EXP1 Correct'; 'EXP3 Incorrect'; 'EXP3 Correct'; 'EXP4 Incorrect'; 'EXP4 Correct';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('central freq')
hold off;



subplot(2,3,6)
hold on
scatter(2, squeeze(mean(results_exp1.bandwith_freq_corrid)))
errorbar(2, squeeze(mean(results_exp1.bandwith_freq_corrid)),sem(results_exp1.bandwith_freq_corrid))
scatter(1, squeeze(mean(results_exp1.bandwith_freq_incid)))
errorbar(1, squeeze(mean(results_exp1.bandwith_freq_incid)),sem(results_exp1.bandwith_freq_incid))

scatter(4, squeeze(mean(results_exp3.bandwith_freq_corrid)))
errorbar(4, squeeze(mean(results_exp3.bandwith_freq_corrid)),sem(results_exp3.bandwith_freq_corrid))
scatter(3, squeeze(mean(results_exp3.bandwith_freq_incid)))
errorbar(3, squeeze(mean(results_exp3.bandwith_freq_incid)),sem(results_exp3.bandwith_freq_incid))


if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.bandwith_freq_incid)))
    errorbar(5, squeeze(mean(results_exp4.bandwith_freq_incid)),sem(results_exp4.bandwith_freq_incid))
    scatter(6, squeeze(mean(results_exp4.central_freq_corrid)))
    errorbar(6, squeeze(mean(results_exp4.central_freq_corrid)),sem(results_exp4.central_freq_corrid))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.bandwith_freq_corrid) mean(results_exp1.bandwith_freq_incid) mean(results_exp3.bandwith_freq_corrid) mean(results_exp3.bandwith_freq_incid) mean(results_exp4.bandwith_freq_corrid) mean(results_exp4.bandwith_freq_incid)]));
    ylim_max = max(max([mean(results_exp1.bandwith_freq_corrid) mean(results_exp1.bandwith_freq_incid) mean(results_exp3.bandwith_freq_corrid) mean(results_exp3.bandwith_freq_incid) mean(results_exp4.bandwith_freq_corrid) mean(results_exp4.bandwith_freq_incid)]))
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
label_pas = {'EXP1 Incorrect'; 'EXP1 Correct';'EXP3 Incorrect'; 'EXP3 Correct'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Incorrect';'EXP1 Correct'; 'EXP3 Incorrect'; 'EXP3 Correct'; 'EXP4 Incorrect'; 'EXP4 Correct';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Bandwith')
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
label_pas = {'EXP1 Low PAS';'EXP1 High PAS'; 'EXP3 Low PAS'; 'EXP3 High PAS';}
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Low PAS';'EXP1 High PAS'; 'EXP3 Low PAS'; 'EXP3 High PAS'; 'EXP4 Low PAS'; 'EXP4 High PAS';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end

title('Aperiodic Activity')
hold off;


subplot(2,3,2)
hold on
scatter(1, squeeze(mean(results_exp1.spectra_lowpas)))
errorbar(1, squeeze(mean(results_exp1.spectra_lowpas)),sem(results_exp1.spectra_lowpas))
scatter(2, squeeze(mean(results_exp1.spectra_highpas)))
errorbar(2, squeeze(mean(results_exp1.spectra_highpas)),sem(results_exp1.spectra_highpas))

scatter(3, squeeze(mean(results_exp3.spectra_lowpas)))
errorbar(3, squeeze(mean(results_exp3.spectra_lowpas)),sem(results_exp3.spectra_lowpas))
scatter(4, squeeze(mean(results_exp3.spectra_highpas)))
errorbar(4, squeeze(mean(results_exp3.spectra_highpas)),sem(results_exp3.spectra_highpas))
if settings.plot_4th == 1
    scatter(5, squeeze(mean(results_exp4.spectra_lowpas)))
    errorbar(5, squeeze(mean(results_exp4.spectra_lowpas)),sem(results_exp4.spectra_lowpas))
    scatter(6, squeeze(mean(results_exp4.spectra_highpas)))
    errorbar(6, squeeze(mean(results_exp4.spectra_highpas)),sem(results_exp4.spectra_highpas))
end

if settings.plot_4th == 1
    ylim_min = min(min([mean(results_exp1.spectra_highpas) mean(results_exp1.spectra_lowpas) mean(results_exp3.spectra_highpas) mean(results_exp3.spectra_lowpas) mean(results_exp4.spectra_highpas) mean(results_exp4.spectra_lowpas)]));
    ylim_max = max(max([mean(results_exp1.spectra_highpas) mean(results_exp1.spectra_lowpas) mean(results_exp3.spectra_highpas) mean(results_exp3.spectra_lowpas) mean(results_exp4.spectra_highpas) mean(results_exp4.spectra_lowpas)]))
    ylim([ylim_min-(abs(ylim_min)*0.2) ylim_max+(abs(ylim_max)*0.2)])
end
if settings.plot_4th == 0
ylim_min = min(min([mean(results_exp1.spectra_highpas) mean(results_exp1.spectra_lowpas) mean(results_exp3.spectra_highpas) mean(results_exp3.spectra_lowpas)]));
ylim_max = max(max([mean(results_exp1.spectra_highpas) mean(results_exp1.spectra_lowpas) mean(results_exp3.spectra_highpas) mean(results_exp3.spectra_lowpas)]));
ylim([ylim_min-(abs(ylim_min)*1) ylim_max+(abs(ylim_max)*0.3)])
end

xlabel(' ')
if settings.plot_4th == 0
xticks([1,2,3,4])
label_pas = {'EXP1 Low PAS'; 'EXP1 High PAS';'EXP3 Low PAS'; 'EXP3 High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Low PAS';'EXP1 High PAS'; 'EXP3 Low PAS'; 'EXP3 High PAS'; 'EXP4 Low PAS'; 'EXP4 High PAS';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Power')
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
label_pas = {'EXP1 Low PAS'; 'EXP1 High PAS';'EXP3 Low PAS'; 'EXP3 High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Low PAS';'EXP1 High PAS'; 'EXP3 Low PAS'; 'EXP3 High PAS'; 'EXP4 Low PAS'; 'EXP4 High PAS';}
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
label_pas = {'EXP1 Low PAS'; 'EXP1 High PAS';'EXP3 Low PAS'; 'EXP3 High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Low PAS';'EXP1 High PAS'; 'EXP3 Low PAS'; 'EXP3 High PAS'; 'EXP4 Low PAS'; 'EXP4 High PAS';}
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
label_pas = {'EXP1 Low PAS'; 'EXP1 High PAS';'EXP3 Low PAS'; 'EXP3 High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Low PAS';'EXP1 High PAS'; 'EXP3 Low PAS'; 'EXP3 High PAS'; 'EXP4 Low PAS'; 'EXP4 High PAS';}
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
label_pas = {'EXP1 Low PAS'; 'EXP1 High PAS';'EXP3 Low PAS'; 'EXP3 High PAS'; }
xticklabels(label_pas)
xline(2.5)
xlim([0 5])
elseif settings.plot_4th == 1
xticks([1,2,3,4, 5, 6])
label_pas = {'EXP1 Low PAS';'EXP1 High PAS'; 'EXP3 Low PAS'; 'EXP3 High PAS'; 'EXP4 Low PAS'; 'EXP4 High PAS';}
xticklabels(label_pas)
xline(2.5)
xline(4.5)
xlim([0 7])
end
title('Bandwith')
hold off;
