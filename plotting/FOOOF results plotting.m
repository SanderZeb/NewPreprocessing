results_exp1 = readtable('D:\Drive\1 - Threshold\pwelch\pwelch_result\csv_export\results.csv')
results_exp3 = readtable('D:\Drive\3 - Mask\pwelch\pwelch_result\csv_export\results.csv')
addpath('C:\Users\user\Documents\Violinplot-Matlab-master')





results_exp3(133) = []


central_value.HighPAS_exp1 = results_exp1.central_freq_highpas;
central_value.LowPAS_exp1 = results_exp1.central_freq_lowpas;
central_value.Correct_exp1 = results_exp1.central_freq_corrid;
central_value.Incorrect_exp1 = results_exp1.central_freq_incid;
central_value.HighPAS_exp3 = results_exp3.central_freq_highpas;
central_value.LowPAS_exp3 = results_exp3.central_freq_lowpas;
central_value.Correct_exp3 = results_exp3.central_freq_corrid;
central_value.Incorrect_exp3 = results_exp3.central_freq_incid;

violinplot(central_value)




adjusted_power.HighPAS_exp1 = results_exp1.power_freq_highpas;
adjusted_power.LowPAS_exp1 = results_exp1.power_freq_lowpas;
adjusted_power.Correct_exp1 = results_exp1.power_freq_corrid;
adjusted_power.Incorrect_exp1 = results_exp1.power_freq_incid;
adjusted_power.HighPAS_exp3 = results_exp3.power_freq_highpas;
adjusted_power.LowPAS_exp3 = results_exp3.power_freq_lowpas;
adjusted_power.Correct_exp3 = results_exp3.power_freq_corrid;
adjusted_power.Incorrect_exp3 = results_exp3.power_freq_incid;
violinplot(adjusted_power)



aperiodic.HighPAS_exp1 = results_exp1.aperiodic_highpas;
aperiodic.LowPAS_exp1 = results_exp1.aperiodic_lowpas;
aperiodic.Correct_exp1 = results_exp1.aperiodic_corrid;
aperiodic.Incorrect_exp1 = results_exp1.aperiodic_incid;
aperiodic.HighPAS_exp3 = results_exp3.aperiodic_highpas;
aperiodic.LowPAS_exp3 = results_exp3.aperiodic_lowpas;
aperiodic.Correct_exp3 = results_exp3.aperiodic_corrid;
aperiodic.Incorrect_exp3 = results_exp3.aperiodic_incid;
violinplot(adjusted_power)



periodic.HighPAS_exp1 = results_exp1.spectra_highpas;
periodic.LowPAS_exp1 = results_exp1.spectra_lowpas;
periodic.Correct_exp1 = results_exp1.spectra_corrid;
periodic.Incorrect_exp1 = results_exp1.spectra_incid;
periodic.HighPAS_exp3 = results_exp3.spectra_highpas;
periodic.LowPAS_exp3 = results_exp3.spectra_lowpas;
periodic.Correct_exp3 = results_exp3.spectra_corrid;
periodic.Incorrect_exp3 = results_exp3.spectra_incid;
violinplot(adjusted_power)