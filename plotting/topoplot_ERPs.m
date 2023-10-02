
% List all set files
filelist = dir('D:\Drive\1 - Threshold\MARA\*.set');

% Participants to exclude
excludeIDs = {'16942', '19520', '19933', '28483'};

% Preallocate EEG cell array for efficient computation
EEG_exp1 = cell(length(filelist), 1);

% Loop through the directory
idx = 1;
for file = filelist'
    [~,name,~] = fileparts(file.name);
    participant = strtok(name, '_');
    
    % Exclude specific participants
    if ~ismember(participant, excludeIDs)
        EEG_exp1{idx} = pop_loadset('filename',file.name,'filepath',file.folder);
        EEG_exp1{idx} = pop_rmbase( EEG_exp1{idx}, [-199    0]);
        idx = idx + 1;
    end
end

% List all set files
filelist = dir('D:\Drive\3 - Mask\MARA\*.set');

% Participants to exclude
excludeIDs = {'77413', '57940', '85994'};

% Preallocate EEG cell array for efficient computation
EEG_exp3 = cell(length(filelist), 1);

% Loop through the directory
idx = 1;
for file = filelist'
    [~,name,~] = fileparts(file.name);
    participant = strtok(name, '_');
    
    % Exclude specific participants
    if ~ismember(participant, excludeIDs)
        EEG_exp3{idx} = pop_loadset('filename',file.name,'filepath',file.folder);
        EEG_exp3{idx} = pop_rmbase( EEG_exp3{idx}, [-199    0]);
        idx = idx + 1;
    end
end
%%

% Remove empty cells
EEG_exp1(cellfun(@isempty, EEG_exp1)) = [];

EEG_exp3{31} = [];
EEG_exp3(cellfun(@isempty, EEG_exp3)) = [];

%VAN: PO7, PO8, O2, O1, PO3, PO4 25 62 64 27 26 63
%P3: Pz, POz, CPz, P1, P2 31 30 32 20 57
electrodesVAN = [25 62 64 27 26 63];
electrodesP3 = [31 30 32 20 57];

% Preallocate a 3D matrix for all participants
nParticipants_exp1 = numel(EEG_exp1);
nParticipants_exp3 = numel(EEG_exp3);
nElectrodes = EEG_exp1{1}.nbchan;
nTimes = EEG_exp1{1}.pnts;
allData_exp1 = zeros(nParticipants_exp1, 64, nTimes);
allData_exp3 = zeros(nParticipants_exp3, 64, nTimes);

% Load all participants data into 3D matrix
for i = 1:nParticipants_exp1
    allData_exp1(i, :, :) = mean(EEG_exp1{i}.data(1:64, :, [EEG_exp1{i}.event.pas] == 1 | [EEG_exp1{i}.event.pas] == 2 | [EEG_exp1{i}.event.pas] == 3 | [EEG_exp1{i}.event.pas] == 4), 3);
    dataPAS1_van_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesVAN, :, [EEG_exp1{i}.event.pas] == 1 ), 3),1));
    dataPAS2_van_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesVAN, :, [EEG_exp1{i}.event.pas] == 2 ), 3),1));
    dataPAS3_van_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesVAN, :, [EEG_exp1{i}.event.pas] == 3 ), 3),1));
    dataPAS4_van_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesVAN, :, [EEG_exp1{i}.event.pas] == 4 ), 3),1));
%     dataPAS34_van_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesVAN, :, [EEG_exp1{i}.event.pas] == 3 | [EEG_exp1{i}.event.pas] == 4 ), 3),1));

    dataPAS1_P3_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesP3, :, [EEG_exp1{i}.event.pas] == 1 ), 3),1));
    dataPAS2_P3_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesP3, :, [EEG_exp1{i}.event.pas] == 2 ), 3),1));
    dataPAS3_P3_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesP3, :, [EEG_exp1{i}.event.pas] == 3 ), 3),1));
    dataPAS4_P3_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesP3, :, [EEG_exp1{i}.event.pas] == 4 ), 3),1));
%     dataPAS34_P3_exp1(i, :) = squeeze(mean(mean(EEG_exp1{i}.data(electrodesP3, :, [EEG_exp1{i}.event.pas] == 3 | [EEG_exp1{i}.event.pas] == 4 ), 3),1));

%     allPAS1_exp1(i, :, :) = mean(EEG_exp1{i}.data(1:64, :, [EEG_exp1{i}.event.pas] == 1 ), 3);
%     allPAS2_exp1(i, :, :) = mean(EEG_exp1{i}.data(1:64, :, [EEG_exp1{i}.event.pas] == 2 ), 3);
%     allPAS34_exp1(i, :, :) = mean(EEG_exp1{i}.data(1:64, :, [EEG_exp1{i}.event.pas] == 3 | [EEG_exp1{i}.event.pas] == 4), 3);
end

% Load all participants data into 3D matrix
for i = 1:nParticipants_exp3
    allData_exp3(i, :, :) = mean(EEG_exp3{i}.data(1:64, :, [EEG_exp3{i}.event.pas] == 1 | [EEG_exp3{i}.event.pas] == 2 | [EEG_exp3{i}.event.pas] == 3 | [EEG_exp3{i}.event.pas] == 4), 3);

    dataPAS1_van_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesVAN, :, [EEG_exp3{i}.event.pas] == 1 ), 3),1));
    dataPAS2_van_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesVAN, :, [EEG_exp3{i}.event.pas] == 2 ), 3),1));
    dataPAS3_van_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesVAN, :, [EEG_exp3{i}.event.pas] == 3 ), 3),1));
    dataPAS4_van_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesVAN, :, [EEG_exp3{i}.event.pas] == 4 ), 3),1));
%     dataPAS34_van_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesVAN, :, [EEG_exp3{i}.event.pas] == 3 | [EEG_exp3{i}.event.pas] == 4 ), 3),1));
%     dataPASall_van_exp3(i, :,:) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesVAN, :, :), 3),1));

    dataPAS1_P3_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesP3, :, [EEG_exp3{i}.event.pas] == 1 ), 3),1));
    dataPAS2_P3_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesP3, :, [EEG_exp3{i}.event.pas] == 2 ), 3),1));
    dataPAS3_P3_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesP3, :, [EEG_exp3{i}.event.pas] == 3 ), 3),1));
    dataPAS4_P3_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesP3, :, [EEG_exp3{i}.event.pas] == 4 ), 3),1));
%     dataPAS34_P3_exp3(i, :, :) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesP3, :, [EEG_exp3{i}.event.pas] == 3 | [EEG_exp3{i}.event.pas] == 4 ), 3),1));
%     dataPASall_P3_exp3(i, :,:) = squeeze(mean(mean(EEG_exp3{i}.data(electrodesP3, :, :), 3),1));
% 
%     allPAS1_exp3(i, :, :) = mean(EEG_exp3{i}.data(1:64, :, [EEG_exp3{i}.event.pas] == 1 ), 3);
%     allPAS2_exp3(i, :, :) = mean(EEG_exp3{i}.data(1:64, :, [EEG_exp3{i}.event.pas] == 2 ), 3);
%     allPAS34_exp3(i, :, :) = mean(EEG_exp3{i}.data(1:64, :, [EEG_exp3{i}.event.pas] == 3 | [EEG_exp3{i}.event.pas] == 4), 3);
end
% Average all participants data
meanData_exp1 = squeeze(mean(allData_exp1, 1, 'omitnan'));
meanData_exp3 = squeeze(mean(allData_exp3, 1, 'omitnan'));
allPAS1_exp1 = squeeze(mean(allPAS1_exp1, 1, 'omitnan'));
allPAS2_exp1 = squeeze(mean(allPAS2_exp1, 1, 'omitnan'));
allPAS34_exp1 = squeeze(mean(allPAS34_exp1, 1, 'omitnan'));
allPAS1_exp3 = squeeze(mean(allPAS1_exp3, 1, 'omitnan'));
allPAS2_exp3 = squeeze(mean(allPAS2_exp3, 1, 'omitnan'));
allPAS34_exp3 = squeeze(mean(allPAS34_exp3, 1, 'omitnan'));

% Create topoplots at every n points
pointsToPlot = 490:15:700; % points
limits = [-5 5];
for point = pointsToPlot
    %subplot(ceil(length(pointsToPlot)/ceil(sqrt(length(pointsToPlot)))), ceil(sqrt(length(pointsToPlot))), find(point==pointsToPlot));
    fig = figure('Visible', 'off'); hold on;
    topoplot(allPAS1_exp3(:,point), EEG_exp1{1}.chanlocs, 'maplimits', limits);
    saveas(fig,['C:\Users\user\Desktop\Nowy folder\exp3_pas1_' num2str(point) '.png']);
    close all
    clear fig
    %title(['Point = ' num2str(point) ' ms = ' num2str(EEG_exp1{1}.times(point)/1000)]);
end


pointsToPlot = 490:15:1000; % points
limits = [-5 5];
temp = squeeze(mean(allData_exp1, 1));
for point = pointsToPlot
    subplot(ceil(length(pointsToPlot)/ceil(sqrt(length(pointsToPlot)))), ceil(sqrt(length(pointsToPlot))), find(point==pointsToPlot));
    topoplot(temp(:,point), EEG_exp3{1}.chanlocs, 'maplimits', limits);
 
    title([num2str(round(EEG_exp3{1}.times(point)/1000, 2)) ' s']);
end

pointsToPlotERP = 490:700;

figure; hold on;

subplot(2,2,1); hold on;
plot(EEG_exp1{1}.times(pointsToPlotERP), squeeze(mean(dataPAS1_van_exp1(:, pointsToPlotERP), 1, 'omitnan')), 'r');
plot(EEG_exp1{1}.times(pointsToPlotERP), squeeze(mean(dataPAS2_van_exp1(:, pointsToPlotERP), 1, 'omitnan')), 'b');
plot(EEG_exp1{1}.times(pointsToPlotERP), squeeze(mean(dataPAS34_van_exp1(:, pointsToPlotERP), 1, 'omitnan')), 'g');
plot(EEG_exp1{1}.times(pointsToPlotERP), squeeze(mean(meanData_exp1(electrodesVAN, pointsToPlotERP), 1, 'omitnan')), 'black');
title(['EXP1 VAN']);

subplot(2,2,2); hold on;
plot(EEG_exp1{1}.times(pointsToPlotERP), squeeze(mean(dataPAS1_P3_exp1(:, pointsToPlotERP), 1, 'omitnan')), 'r');
plot(EEG_exp1{1}.times(pointsToPlotERP), squeeze(mean(dataPAS2_P3_exp1(:, pointsToPlotERP), 1, 'omitnan')), 'b');
plot(EEG_exp1{1}.times(pointsToPlotERP), squeeze(mean(dataPAS34_P3_exp1(:, pointsToPlotERP), 1, 'omitnan')), 'g');
plot(EEG_exp1{1}.times(pointsToPlotERP), squeeze(mean(meanData_exp1(electrodesP3, pointsToPlotERP), 1, 'omitnan')), 'black');
title(['EXP1 P3']);

subplot(2,2,3); hold on;
plot(EEG_exp3{1}.times(pointsToPlotERP), squeeze(mean(dataPAS1_van_exp3(:, pointsToPlotERP), 1, 'omitnan')), 'r');
plot(EEG_exp3{1}.times(pointsToPlotERP), squeeze(mean(dataPAS2_van_exp3(:, pointsToPlotERP), 1, 'omitnan')), 'b');
plot(EEG_exp3{1}.times(pointsToPlotERP), squeeze(mean(dataPAS34_van_exp3(:, pointsToPlotERP), 1, 'omitnan')), 'g');
plot(EEG_exp3{1}.times(pointsToPlotERP), squeeze(mean(meanData_exp3(electrodesVAN, pointsToPlotERP), 1, 'omitnan')), 'black');
title(['EXP3 VAN']);

subplot(2,2,4); hold on;
plot(EEG_exp3{1}.times(pointsToPlotERP), squeeze(mean(dataPAS1_P3_exp3(:, pointsToPlotERP), 1, 'omitnan')), 'r');
plot(EEG_exp3{1}.times(pointsToPlotERP), squeeze(mean(dataPAS2_P3_exp3(:, pointsToPlotERP), 1, 'omitnan')), 'b');
plot(EEG_exp3{1}.times(pointsToPlotERP), squeeze(mean(dataPAS34_P3_exp3(:, pointsToPlotERP), 1, 'omitnan')), 'g');
plot(EEG_exp3{1}.times(pointsToPlotERP), squeeze(mean(meanData_exp3(electrodesP3, pointsToPlotERP), 1, 'omitnan')), 'black');
title(['EXP3 P3']);



% Create an array of the variable names and their corresponding data
varNames = {'dataPAS1_van_exp1', 'dataPAS2_van_exp1', 'dataPAS3_van_exp1', 'dataPAS4_van_exp1', 'dataPAS1_P3_exp1', 'dataPAS2_P3_exp1', 'dataPAS3_P3_exp1', 'dataPAS4_P3_exp1', 'dataPAS1_van_exp3', 'dataPAS2_van_exp3', 'dataPAS3_van_exp3', 'dataPAS4_van_exp3',  'dataPAS1_P3_exp3', 'dataPAS2_P3_exp3', 'dataPAS3_P3_exp3', 'dataPAS4_P3_exp3'};
varData = {dataPAS1_van_exp1 dataPAS2_van_exp1 dataPAS3_van_exp1 dataPAS4_van_exp1 dataPAS1_P3_exp1 dataPAS2_P3_exp1 dataPAS3_P3_exp1 dataPAS4_P3_exp1 dataPAS1_van_exp3 dataPAS2_van_exp3 dataPAS3_van_exp3 dataPAS4_van_exp3  dataPAS1_P3_exp3 dataPAS2_P3_exp3 dataPAS3_P3_exp3 dataPAS4_P3_exp3};




% Loop through the variables and save each one as a CSV
for i = 1:length(varNames)
    % Squeeze the data to remove singleton dimensions
    squeezedData = squeeze(varData{i});
    % Save the data as a CSV
    writematrix(squeezedData, ['C:\Users\user\Desktop\topoplots amplitude EXP1&3\ERP csv export\' varNames{i} '.csv']);
end












% Load all participants data into 3D matrix
for i = 1:nParticipants_exp1

    dataPAS1_van_exp1_raw(i, :) = squeeze((mean(EEG_exp1{i}.data(electrodesVAN, :, [EEG_exp1{i}.event.pas] == 1 )),1));
    dataPAS2_van_exp1_raw(i, :) = squeeze((mean(EEG_exp1{i}.data(electrodesVAN, :, [EEG_exp1{i}.event.pas] == 2 )),1));
    dataPAS34_van_exp1_raw(i, :) = squeeze((mean(EEG_exp1{i}.data(electrodesVAN, :, [EEG_exp1{i}.event.pas] == 3 | [EEG_exp1{i}.event.pas] == 4 )),1));

    dataPAS1_P3_exp1_raw(i, :) = squeeze((mean(EEG_exp1{i}.data(electrodesP3, :, [EEG_exp1{i}.event.pas] == 1 )),1));
    dataPAS2_P3_exp1_raw(i, :) = squeeze((mean(EEG_exp1{i}.data(electrodesP3, :, [EEG_exp1{i}.event.pas] == 2 )),1));
    dataPAS34_P3_exp1_raw(i, :) = squeeze((mean(EEG_exp1{i}.data(electrodesP3, :, [EEG_exp1{i}.event.pas] == 3 | [EEG_exp1{i}.event.pas] == 4 )),1));

end

% Load all participants data into 3D matrix
for i = 1:nParticipants_exp3

    dataPAS1_van_exp3_raw(i, :, :) = squeeze((mean(EEG_exp3{i}.data(electrodesVAN, :, [EEG_exp3{i}.event.pas] == 1 )),1));
    dataPAS2_van_exp3_raw(i, :, :) = squeeze((mean(EEG_exp3{i}.data(electrodesVAN, :, [EEG_exp3{i}.event.pas] == 2 )),1));
    dataPAS34_van_exp3_raw(i, :, :) = squeeze((mean(EEG_exp3{i}.data(electrodesVAN, :, [EEG_exp3{i}.event.pas] == 3 | [EEG_exp3{i}.event.pas] == 4 )),1));
    dataPASall_van_exp3_raw(i, :,:) = squeeze((mean(EEG_exp3{i}.data(electrodesVAN, :, :), 3),1));

    dataPAS1_P3_exp3_raw(i, :, :) = squeeze((mean(EEG_exp3{i}.data(electrodesP3, :, [EEG_exp3{i}.event.pas] == 1 )),1));
    dataPAS2_P3_exp3_raw(i, :, :) = squeeze((mean(EEG_exp3{i}.data(electrodesP3, :, [EEG_exp3{i}.event.pas] == 2 )),1));
    dataPAS34_P3_exp3_raw(i, :, :) = squeeze((mean(EEG_exp3{i}.data(electrodesP3, :, [EEG_exp3{i}.event.pas] == 3 | [EEG_exp3{i}.event.pas] == 4 )),1));
    dataPASall_P3_exp3_raw(i, :,:) = squeeze((mean(EEG_exp3{i}.data(electrodesP3, :, :)),1));
end