load('D:\Drive\5 - Scenes\tfdata\corrected_exp5_scenes_alpha.mat')
load('D:\Drive\5 - Scenes\behawior.mat')

alpha = struct2table(new_alpha)
listEEGData = dir(['D:\Drive\5 - Scenes\MARA\*.set']);
listEEGData(34) = []; % bad one;
listRemovedEpochs = dir(['D:\Drive\5 - Scenes\Epoching_EpochRejection\additional_info\*.mat']);
listRemovedEpochs(34) = []; % bad one;
participants = unique(alpha.participant);

mix_all = []
for i = 1 : length(participants)

    current_participant = participants(i);
    current_participant_ID = str2num(listEEGData(current_participant).name(1:5));
    current_alpha = alpha(alpha.participant == current_participant, :);
    current_behawior = behawior(behawior.ID == current_participant_ID, :);
    current_removed_epochs = load([listRemovedEpochs(i).folder '\' listRemovedEpochs(i).name])

    backupbeh = current_behawior;
    current_behawior(current_removed_epochs.to_reject, :) =[];

    if size(current_behawior, 1) == size(current_alpha,1)

        disp('OK');

        mix = cat(1, current_alpha, current_behawior);
        mix_all = cat(1, mix_all, mix);
    else
        disp('error');
        disp(['diff: ' num2str(size(current_behawior, 1) - size(current_alpha,1)) ]);
        addpath('C:\Users\user\Documents\GitHub\NewPreprocessing\events\behawior');
        [current_behawior, current_alpha] = search_for_extradropouts(current_behawior, current_alpha)
        mix = cat(2, current_alpha, current_behawior);
        mix_all = cat(2, mix_all, mix);


    end



end
