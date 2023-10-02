% Define directories
exp1_dir = 'D:\Drive\3 - Mask\MARA\';
exp2_dir = 'D:\Drive\4 - Faces\MARA\';
beta1_dir = 'D:\Drive\3 - Mask\tfdata\betas_interaction\';
beta2_dir = 'D:\Drive\4 - Faces\tfdata\betas_interaction_mvregress_new2\';

% Get the file list for each directory
exp1_files = dir(fullfile(exp1_dir, '*_3.set'));
exp2_files = dir(fullfile(exp2_dir, '*_4.set'));

% Extract participant IDs for both experiments
exp1_IDs = cellfun(@(x) x(1:5), {exp1_files.name}, 'UniformOutput', false);
exp2_IDs = cellfun(@(x) x(1:5), {exp2_files.name}, 'UniformOutput', false);

% Find common participant IDs
[common_IDs, exp1_indices, exp2_indices] = intersect(exp1_IDs, exp2_IDs);

% Initialize the result matrix
result = cell(numel(common_IDs), 8);

    
    load("D:\chanlocs.mat")
    channels.O1 = find(strcmp({chanlocs.labels}, 'O1')==1);
    channels.Oz = find(strcmp({chanlocs.labels}, 'Oz')==1);
    channels.O2 = find(strcmp({chanlocs.labels}, 'O2')==1);
    channels.PO7 = find(strcmp({chanlocs.labels}, 'PO7')==1);
    channels.PO8 = find(strcmp({chanlocs.labels}, 'PO8')==1);
    channels.PO3 = find(strcmp({chanlocs.labels}, 'PO3')==1);
    channels.PO4 = find(strcmp({chanlocs.labels}, 'PO4')==1);
    channels.POz = find(strcmp({chanlocs.labels}, 'POz')==1);
    channels.P1 = find(strcmp({chanlocs.labels}, 'P1')==1);
    channels.P2 = find(strcmp({chanlocs.labels}, 'P2')==1);
    channels.P3 = find(strcmp({chanlocs.labels}, 'P3')==1);
    channels.P4 = find(strcmp({chanlocs.labels}, 'P4')==1);
    channels.P5 = find(strcmp({chanlocs.labels}, 'P5')==1);
    channels.P6 = find(strcmp({chanlocs.labels}, 'P6')==1);
    channels.P7 = find(strcmp({chanlocs.labels}, 'P7')==1);
    channels.P8 = find(strcmp({chanlocs.labels}, 'P8')==1);
    channels.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1);
    channels.Iz = find(strcmp({chanlocs.labels}, 'Iz')==1);
    selected_channels = [channels.O1 channels.Oz channels.O2 channels.PO7 channels.PO3 channels.POz channels.PO4 channels.PO8 channels.Iz channels.P7 channels.P5 channels.P3 channels.P1 channels.Pz channels.P2 channels.P4 channels.P6 channels.P8];

% Loop through common IDs and process the data
for i = 1:numel(common_IDs)
    % Find the corresponding filenames
    exp1_filename = exp1_files(exp1_indices(i)).name;
    exp2_filename = exp2_files(exp2_indices(i)).name;
    
    % Get the indices in the MARA directories
    exp1_index = exp1_indices(i);
    exp2_index = exp2_indices(i);
    
    % Initialize the mean values
    exp1_mean_acc = 0;
    exp2_mean_acc = 0;
    exp1_mean_pas = 0;
    exp2_mean_pas = 0;
    % Loop through channels 
    for s_ch = 1:length(selected_channels)
        ch = selected_channels(s_ch);

    % Define file paths for both experiments
        exp1_beta_file_path = fullfile(beta1_dir, sprintf('%d_betas_chann_%d.mat', exp1_index, ch));
        exp2_beta_file_path = fullfile(beta2_dir, sprintf('%d_betas_chann_%d.mat', exp2_index, ch));
        
        % Check if files exist before loading
        if exist(exp1_beta_file_path, 'file') && exist(exp2_beta_file_path, 'file')
            % Load the beta files for both experiments
            exp1_beta_file = load(exp1_beta_file_path);
            exp2_beta_file = load(exp2_beta_file_path);
            % Get the desired range of data
            exp1_data_acc = exp1_beta_file.betas(2:9, 43:100, 2);
            exp2_data_acc = exp2_beta_file.betas(2:9, 43:100, 2);
            exp1_data_pas = exp1_beta_file.betas(2:9, 43:100, 3);
            exp2_data_pas = exp2_beta_file.betas(2:9, 43:100, 3);
    
            % Calculate the mean for both experiments
            exp1_mean_acc = exp1_mean_acc + mean(exp1_data_acc, 'all', 'omitnan');
            exp2_mean_acc = exp2_mean_acc + mean(exp2_data_acc, 'all', 'omitnan');
            exp1_mean_pas = exp1_mean_pas + mean(exp1_data_pas, 'all', 'omitnan');
            exp2_mean_pas = exp2_mean_pas + mean(exp2_data_pas, 'all', 'omitnan');
        
           
        else
            warning('File(s) not found: %s, %s', exp1_beta_file_path, exp2_beta_file_path);
        end
    end
            % Compute the average mean across all channels
            exp1_mean_acc = exp1_mean_acc / length(selected_channels);
            exp2_mean_acc = exp2_mean_acc / length(selected_channels);
            exp1_mean_pas = exp1_mean_pas / length(selected_channels);
            exp2_mean_pas = exp2_mean_pas / length(selected_channels);
             % Store the results
            result(i, :) = {exp1_filename, common_IDs{i}, exp2_filename, common_IDs{i}, exp1_mean_acc, exp2_mean_acc, exp1_mean_pas, exp2_mean_pas};
end

% Convert the result to a table
result_table = cell2table(result, 'VariableNames', {'Exp1_Filename', 'Exp1_ID', 'Exp3_Filename', 'Exp3_ID', 'Exp1_Beta_Mean_acc', 'Exp3_Beta_Mean_acc', 'Exp1_Beta_Mean_pas', 'Exp3_Beta_Mean_pas'});
result_table([19,42:44,59],:) = [];
% Display the result
disp(result_table);

figure;

subplot(1,2,1)
% Extract the Exp1_Beta_Mean and Exp3_Beta_Mean columns from the result_table
%exp1_mean = cell2mat(result_table.Exp1_Beta_Mean_acc);
%exp2_mean = cell2mat(result_table.Exp3_Beta_Mean_acc);

exp1_mean = result_table.Exp1_Beta_Mean_acc;
exp2_mean = result_table.Exp3_Beta_Mean_acc;

% Create a scatter plot of the two mean values
scatter(exp1_mean, exp2_mean, 'filled');
xlabel('Exp2 B coeff Mean');
ylabel('Exp3 B coeff Mean');
title('B coeff Accuracy Exp2 vs Exp3');
grid on;

% Calculate the correlation and fit a linear regression line
fit_result = polyfit(exp1_mean, exp2_mean, 1);
hold on;
plot(exp1_mean, polyval(fit_result, exp1_mean), 'r', 'LineWidth', 2);
% Calculate the correlation coefficient
correlation = corrcoef(exp1_mean, exp2_mean);
disp(['Correlation Coefficient: ', num2str(correlation(1, 2))]);

correlation_text = ['Correlation Coefficient: ', num2str(correlation(1, 2))];

addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
% Add the correlation coefficient text to the plot
text_x = min(exp1_mean) + 0.1 * range(exp1_mean);
text_y = min(exp2_mean) + 0.8 * range(exp2_mean);
text(text_x, text_y, correlation_text, 'FontSize', 12, 'Color', 'blue');
hold off;



subplot(1,2,2)
% Extract the Exp1_Beta_Mean and Exp3_Beta_Mean columns from the result_table
exp1_mean = result_table.Exp1_Beta_Mean_pas;
exp2_mean = result_table.Exp3_Beta_Mean_pas;

% Create a scatter plot of the two mean values
scatter(exp1_mean, exp2_mean, 'filled');
xlabel('Exp2 B coeff Mean');
ylabel('Exp3 B coeff Mean');
title('B coeff PAS Exp2 vs Exp3');
grid on;

% Calculate the correlation and fit a linear regression line
fit_result = polyfit(exp1_mean, exp2_mean, 1);
hold on;
plot(exp1_mean, polyval(fit_result, exp1_mean), 'r', 'LineWidth', 2);
% Calculate the correlation coefficient
correlation = corrcoef(exp1_mean, exp2_mean);
disp(['Correlation Coefficient: ', num2str(correlation(1, 2))]);

correlation_text = ['Correlation Coefficient: ', num2str(correlation(1, 2))];

addpath 'C:\Program Files\MATLAB\R2019b\toolbox\stats\stats'
% Add the correlation coefficient text to the plot
text_x = min(exp1_mean) + 0.1 * range(exp1_mean);
text_y = min(exp2_mean) + 0.8 * range(exp2_mean);
text(text_x, text_y, correlation_text, 'FontSize', 12, 'Color', 'blue');
hold off;
