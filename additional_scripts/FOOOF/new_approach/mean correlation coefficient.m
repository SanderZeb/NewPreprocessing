% Calculate means
mean_exp1_corr = mean([exp1.corr_correlation_coef_raw]);
mean_exp1_incorr = mean([exp1.incorrect_correlation_coef_raw]);
mean_exp3_corr = mean([exp3.corr_correlation_coef_raw]);
mean_exp3_incorr = mean([exp3.incorrect_correlation_coef_raw]);
mean_exp4_corr = mean([exp4.corr_correlation_coef_raw]);
mean_exp4_incorr = mean([exp4.incorrect_correlation_coef_raw]);
mean_exp5_bg_corr = mean([exp5_backgrounds.corr_correlation_coef_raw]);
mean_exp5_bg_incorr = mean([exp5_backgrounds.incorrect_correlation_coef_raw]);
mean_exp5_obj_corr = mean([exp5_objects.corr_correlation_coef_raw]);
mean_exp5_obj_incorr = mean([exp5_objects.incorrect_correlation_coef_raw]);

mean_values = [mean_exp1_corr; mean_exp1_incorr; mean_exp3_corr; mean_exp3_incorr; mean_exp4_corr; mean_exp4_incorr; mean_exp5_bg_corr; mean_exp5_bg_incorr; mean_exp5_obj_corr; mean_exp5_obj_incorr];

% Create row names
rowNames = {'exp1_corr', 'exp1_incorr', 'exp3_corr', 'exp3_incorr', 'exp4_corr', 'exp4_incorr', 'exp5_bg_corr', 'exp5_bg_incorr', 'exp5_obj_corr', 'exp5_obj_incorr'};

% Create table
data = table(mean_values, 'VariableNames', {'Mean_Correlation_Coef'}, 'RowNames', rowNames);

% Display table
disp(data);
           
