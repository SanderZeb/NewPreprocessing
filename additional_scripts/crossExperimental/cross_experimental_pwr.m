% Define directories
exp1_dir = 'D:\Drive\1 - Threshold\MARA';
exp2_dir = 'D:\Drive\3 - Mask\MARA';
beta1_dir = 'D:\Drive\1 - Threshold\tfdata';
beta2_dir = 'D:\Drive\3 - Mask\tfdata';

% laod events file
load('D:\Drive\1 - Threshold\events_new3.mat')
exp1_events = events_new(:, 1).';
clear events_new
load('D:\Drive\3 - Mask\events_new2.mat')
exp3_events = events_new2;
clear events_new2

% Get the file list for each directory
exp1_files = dir(fullfile(exp1_dir, '*_1.set'));
exp2_files = dir(fullfile(exp2_dir, '*_3.set'));

% Extract participant IDs for both experiments
exp1_IDs = cellfun(@(x) x(1:5), {exp1_files.name}, 'UniformOutput', false);
exp2_IDs = cellfun(@(x) x(1:5), {exp2_files.name}, 'UniformOutput', false);

% Find common participant IDs
[common_IDs, exp1_indices, exp2_indices] = intersect(exp1_IDs, exp2_IDs);

% Initialize the result matrix
result = cell(numel(common_IDs),12);

    
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
for i = i:numel(common_IDs)
    % Find the corresponding filenames
    exp1_filename = exp1_files(exp1_indices(i)).name;
    exp2_filename = exp2_files(exp2_indices(i)).name;
    
    % Get the indices in the MARA directories
    exp1_index = exp1_indices(i);
    exp2_index = exp2_indices(i);
    
    % Initialize the mean values
    exp1_mean_acc1 = 0;
    exp2_mean_acc1 = 0;
    exp1_mean_pas1 = 0;
    exp2_mean_pas1 = 0;
    exp1_mean_acc0 = 0;
    exp2_mean_acc0 = 0;
    exp1_mean_pasHigh = 0;
    exp2_mean_pasHigh = 0;
    % Loop through channels 
    for s_ch = 1:length(selected_channels)
        ch = selected_channels(s_ch);

    % Define file paths for both experiments
        exp1_beta_file_path = fullfile(beta1_dir, sprintf('tfdata_chan_%d_participant_%d.mat', ch, exp1_index));
        exp2_beta_file_path = fullfile(beta2_dir, sprintf('tfdata_chan_%d_participant_%d.mat', ch, exp2_index));
        
        % Check if files exist before loading
        if exist(exp1_beta_file_path, 'file') && exist(exp2_beta_file_path, 'file')
            % Load the beta files for both experiments
            exp1_beta_file = load(exp1_beta_file_path);
            exp2_beta_file = load(exp2_beta_file_path);

            curr_events_exp1 = exp1_events{1, exp1_index};
            curr_events_exp3 = exp3_events{1, exp2_index};
            % Get the desired range of data
            exp1_data_acc1 = exp1_beta_file.tfdata(2:9, 43:100, [curr_events_exp1.identification2] == 1);
            exp1_data_acc0 = exp1_beta_file.tfdata(2:9, 43:100, [curr_events_exp1.identification2] == 0);
            exp2_data_acc1 = exp2_beta_file.tfdata(2:9, 43:100, [curr_events_exp3.accuracy] == 1);
            exp2_data_acc0 = exp2_beta_file.tfdata(2:9, 43:100, [curr_events_exp3.accuracy] == 0);
            exp1_data_pas1 = exp1_beta_file.tfdata(2:9, 43:100, [curr_events_exp1.pas] == 1);
            exp1_data_pasHigh = exp1_beta_file.tfdata(2:9, 43:100, [curr_events_exp1.pas] > 1);
            exp2_data_pas1 = exp2_beta_file.tfdata(2:9, 43:100, [curr_events_exp3.pas_resp] == 1);
            exp2_data_pasHigh = exp2_beta_file.tfdata(2:9, 43:100, [curr_events_exp3.pas_resp] > 1);
    
            % Calculate the mean for both experiments
            exp1_mean_acc1 = exp1_mean_acc1 + mean(abs(exp1_data_acc1), 'all', 'omitnan');
            exp2_mean_acc1 = exp2_mean_acc1 + mean(abs(exp2_data_acc1), 'all', 'omitnan');
            exp1_mean_pas1 = exp1_mean_pas1 + mean(abs(exp1_data_pas1), 'all', 'omitnan');
            exp2_mean_pas1 = exp2_mean_pas1 + mean(abs(exp2_data_pas1), 'all', 'omitnan');
            exp1_mean_acc0 = exp1_mean_acc0 + mean(abs(exp1_data_acc0), 'all', 'omitnan');
            exp2_mean_acc0 = exp2_mean_acc0 + mean(abs(exp2_data_acc0), 'all', 'omitnan');
            exp1_mean_pasHigh = exp1_mean_pasHigh + mean(abs(exp1_data_pasHigh), 'all', 'omitnan');
            exp2_mean_pasHigh = exp2_mean_pasHigh + mean(abs(exp2_data_pasHigh), 'all', 'omitnan');
        
           
        else
            warning('File(s) not found: %s, %s', exp1_beta_file_path, exp2_beta_file_path);
        end
    end
            % Compute the average mean across all channels
            exp1_mean_acc1 = exp1_mean_acc1 / length(selected_channels);
            exp2_mean_acc1 = exp2_mean_acc1 / length(selected_channels);
            exp1_mean_pas1 = exp1_mean_pas1 / length(selected_channels);
            exp2_mean_pas1 = exp2_mean_pas1 / length(selected_channels); 
            exp1_mean_acc0 = exp1_mean_acc0 / length(selected_channels);
            exp2_mean_acc0 = exp2_mean_acc0 / length(selected_channels);
            exp1_mean_pasHigh = exp1_mean_pasHigh / length(selected_channels);
            exp2_mean_pasHigh = exp2_mean_pasHigh / length(selected_channels); % Store the results
            result(i, :) = {exp1_filename, common_IDs{i}, exp2_filename, common_IDs{i}, exp1_mean_acc1, exp2_mean_acc1, exp1_mean_pas1, exp2_mean_pas1, exp1_mean_acc0, exp2_mean_acc0, exp1_mean_pasHigh, exp2_mean_pasHigh};
end

% Convert the result to a table
result_table = cell2table(result, 'VariableNames', {'Exp1_Filename', 'Exp1_ID', 'Exp3_Filename', 'Exp3_ID', 'Exp1_Beta_Mean_acc1', 'Exp3_Beta_Mean_acc1', 'Exp1_Beta_Mean_pas1', 'Exp3_Beta_Mean_pas1', 'Exp1_Beta_Mean_acc0', 'Exp3_Beta_Mean_acc0', 'Exp1_Beta_Mean_pasHigh', 'Exp3_Beta_Mean_pasHigh'});

% Display the result
disp(result_table);


figure;

subplot(1,2,1)
% Extract the Exp1_Beta_Mean and Exp3_Beta_Mean columns from the result_table
exp1_mean1 = cell2mat(result_table.Exp1_Beta_Mean_acc1);
exp2_mean1 = cell2mat(result_table.Exp3_Beta_Mean_acc1);
exp1_mean0 = cell2mat(result_table.Exp1_Beta_Mean_acc0);
exp2_mean0 = cell2mat(result_table.Exp3_Beta_Mean_acc0);

% Create a scatter plot of the two mean values
hold on;
scatter(exp1_mean1, exp2_mean1, 'filled', 'd');
scatter(exp1_mean0, exp2_mean0, 'filled', 'o');

xlabel('Exp1 B coeff Mean');
ylabel('Exp3 B coeff Mean');
title('B coeff Accuracy Exp1 vs Exp3');
grid on;

% Calculate the correlation and fit a linear regression line
fit_result = polyfit(exp1_mean1, exp2_mean1, 1);
hold on;
plot(exp2_mean1, polyval(fit_result, exp2_mean1), 'b', 'LineWidth', 2);
hold off;

fit_result = polyfit(exp1_mean0, exp2_mean0, 1);
hold on;
plot(exp2_mean0, polyval(fit_result, exp2_mean0), 'r', 'LineWidth', 2);
hold off;
% Calculate the correlation coefficient
correlation = corrcoef(exp1_mean, exp2_mean);
disp(['Correlation Coefficient: ', num2str(correlation(1, 2))]);



subplot(1,2,2)
% Extract the Exp1_Beta_Mean and Exp3_Beta_Mean columns from the result_table
exp1_mean = cell2mat(result_table.Exp1_Beta_Mean_pas);
exp2_mean = cell2mat(result_table.Exp3_Beta_Mean_pas);

% Create a scatter plot of the two mean values
scatter(exp1_mean, exp2_mean, 'filled');
xlabel('Exp1 B coeff Mean');
ylabel('Exp3 B coeff Mean');
title('B coeff PAS Exp1 vs Exp3');
grid on;

% Calculate the correlation and fit a linear regression line
fit_result = polyfit(exp1_mean, exp2_mean, 1);
hold on;
plot(exp1_mean, polyval(fit_result, exp1_mean), 'r', 'LineWidth', 2);
hold off;

% Calculate the correlation coefficient
correlation = corrcoef(exp1_mean, exp2_mean);
disp(['Correlation Coefficient: ', num2str(correlation(1, 2))]);
