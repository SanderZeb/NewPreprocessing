settings.paradigm = 4
if settings.paradigm == 1
    root = 'D:\Drive\1 - Threshold\';
elseif settings.paradigm == 2
    root = 'D:\Drive\2 - Cue\';
elseif settings.paradigm == 3
    root = 'D:\Drive\3 - Mask\';
elseif settings.paradigm == 4
    root = 'D:\Drive\4 - Faces\';
elseif settings.paradigm == 5
    root = 'D:\Drive\5 - Scenes\';
end

% Define the paths to the directories containing .bdf and .set files
bdf_path = [root '\raw'];
set_path = [root '\MARA'];

% Get the list of .bdf and .set files in the respective directories
bdf_files = dir(fullfile(bdf_path, '*.bdf'));
set_files = dir(fullfile(set_path, '*.set'));

% Extract the file names without extensions
bdf_filenames = {bdf_files.name}';
set_filenames = {set_files.name}';
bdf_filenames_no_ext = cellfun(@(x) x(1:end-4), bdf_filenames, 'UniformOutput', false);
set_filenames_no_ext = cellfun(@(x) x(1:end-4), set_filenames, 'UniformOutput', false);

% Find the missing .set files
missing_set_files = setdiff(bdf_filenames_no_ext, set_filenames_no_ext);

% Display the list of missing .set files
fprintf('Missing .set files:\n');
for i = 1:numel(missing_set_files)
    fprintf('%s.set\n', missing_set_files{i});
end
