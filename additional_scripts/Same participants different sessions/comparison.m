clear all
root1 = 'D:\Drive\1 - Threshold\';
root2 = 'D:\Drive\3 - Mask\';
clear root
pathTFData1 = [root1 '\tfdata\']
pathTFData2 = [root2 '\tfdata\']
pathEEGData1 = [root1 '\MARA\']
pathEEGData2 = [root2 '\MARA\']
listTFData1=dir([pathTFData1 '*mat' ]);
listEEGData1=dir([pathEEGData1 '*.set'  ]);
listTFData2=dir([pathTFData2 '*mat' ]);
listEEGData2=dir([pathEEGData2 '*.set'  ]);
participants1 = length(listEEGData1);
participants2 = length(listEEGData2);

for s=1:length(listEEGData1)
    
    file=listEEGData1(s).name;
    B = regexp(file,'\d*','Match');
    EEGindexes_1(s,:) = string(B{1});
end

for s=1:length(listEEGData2)
    
    file=listEEGData2(s).name;
    B = regexp(file,'\d*','Match');
    EEGindexes_2(s,:) = string(B{1});
end


for i=1:length(EEGindexes_1)
    curr = EEGindexes_1(i);
    
    match_index(i,:) = strcmp(curr, [EEGindexes_2])

end

idx_to_analyse_1 = any(match_index,2)
idx_to_analyse_2 = any(match_index,1)

match_EEGData1 = listEEGData1(idx_to_analyse_1);
match_EEGData2 = listEEGData2(idx_to_analyse_2);




pathLoadData1 = match_EEGData1(1).folder;
pathLoadData2 = match_EEGData2(1).folder;
mkdir('D:\Drive\', '\1&3exp');
pathSaveData= 'D:\Drive\1&3exp\';
eeglab nogui
list1=dir([pathLoadData1 '\*.set'  ])
list2=dir([pathLoadData2 '\*.set'  ])
participants1 = length(match_EEGData1)
participants2 = length(match_EEGData2)

events_1 = load([root1 'events.mat'])
events_exp1 = events_1.events(:, idx_to_analyse_1);
events_2 = load([root2 'events.mat'])
events_exp2 = events_2.events(:, idx_to_analyse_2)

addpath('C:\Program Files\MATLAB\R2022b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2022b\toolbox\stats\stats\')

fileEEGData=list1(1).name;
EEG = pop_loadset('filename',fileEEGData,'filepath',pathLoadData1);
chanlocs = EEG.chanlocs;
channels(1).M1 = find(strcmp({chanlocs.labels}, 'M1')==1);  			%INDEX CHANNEL
channels.M2 = find(strcmp({chanlocs.labels}, 'M2')==1);              	%INDEX CHANNEL
channels.CP1 = find(strcmp({chanlocs.labels}, 'CP1')==1);
channels.CPz = find(strcmp({chanlocs.labels}, 'CPz')==1);
channels.CP2 = find(strcmp({chanlocs.labels}, 'CP2')==1);
channels.P1 = find(strcmp({chanlocs.labels}, 'P1')==1);
channels.Pz = find(strcmp({chanlocs.labels}, 'Pz')==1);
channels.P2 = find(strcmp({chanlocs.labels}, 'P2')==1);
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
channels.VEOG = find(strcmp({chanlocs.labels}, 'VEOG')==1);									%INDEX CHANNEL
channels.HEOG = find(strcmp({chanlocs.labels}, 'HEOG')==1);									%INDEX CHANNEL

settings.selected_channels = [channels.O1 channels.Oz channels.O2 channels.PO7 channels.PO8 channels.PO3 channels.PO4 channels.POz channels.Iz channels.P1 channels.Pz channels.P2 channels.P3 channels.P5 channels.P7];


for s=[1:participants1]
    try
        
        pairs(s).participant_event1 = events_exp1{s};
        pairs(s).participant_event2 = events_exp2{s};

            pairs(s).exp1_idx_corr = logical([pairs(s).participant_event1.identification2] ==1);
            pairs(s).exp1_idx_inc = logical([pairs(s).participant_event1.identification2] == 0);
            pairs(s).exp1_idx_highpas = logical([pairs(s).participant_event1.pas] >= 2);
            pairs(s).exp1_idx_lowpas = logical([pairs(s).participant_event1.pas] == 1);
        
            pairs(s).exp3_idx_corr = logical([pairs(s).participant_event2.corr_corr] ==1);
            pairs(s).exp3_idx_inc = logical([pairs(s).participant_event2.corr_corr] == 0);
            pairs(s).exp3_idx_highpas = logical([pairs(s).participant_event2.pas] >= 2);
            pairs(s).exp3_idx_lowpas = logical([pairs(s).participant_event2.pas] == 1);


        file1=match_EEGData1(s).name;
        file2=match_EEGData2(s).name;
        
        pairs(s).EEG1 = pop_loadset('filename',file1,'filepath',pathLoadData1);
        pairs(s).EEG2 = pop_loadset('filename',file2,'filepath',pathLoadData2);
       

        pairs(s).EEG1_alpha = pop_eegfiltnew( pairs(s).EEG1, 'locutoff',  8,   'hicutoff', 13, 'filtorder',  826 );
        pairs(s).EEG2_alpha = pop_eegfiltnew( pairs(s).EEG2, 'locutoff',  8,   'hicutoff', 13, 'filtorder',  826 );

        pairs(s).id1 = file1;
        pairs(s).id2 = file2;
        for i = 1:length(settings.selected_channels)
        pairs(s).hilbert_threshold(i, :,:) = abs(hilbert(pairs(s).EEG1_alpha.data(settings.selected_channels(i),:,:)));
        pairs(s).hilbert_mask(i, :,:) =abs(hilbert(pairs(s).EEG2_alpha.data(settings.selected_channels(i),:,:)));
        
        pairs(s).pwelch_threshold_correct(i,:,:) = pwelch(squeeze(mean(pairs(s).EEG1.data(settings.selected_channels(i), 1:512, pairs(s).exp1_idx_corr), 3)));
        pairs(s).pwelch_threshold_inccorrect(i,:,:) = pwelch(squeeze(mean(pairs(s).EEG1.data(settings.selected_channels(i), 1:512, pairs(s).exp1_idx_inc), 3)));
        pairs(s).pwelch_threshold_highpas(i,:,:) = pwelch(squeeze(mean(pairs(s).EEG1.data(settings.selected_channels(i), 1:512, pairs(s).exp1_idx_highpas), 3)));
        pairs(s).pwelch_threshold_lowpas(i,:,:) = pwelch(squeeze(mean(pairs(s).EEG1.data(settings.selected_channels(i), 1:512, pairs(s).exp1_idx_lowpas), 3)));

        pairs(s).pwelch_masked_correct(i,:,:) = pwelch(squeeze(mean(pairs(s).EEG2.data(settings.selected_channels(i), 1:512, pairs(s).exp3_idx_corr), 3)));
        pairs(s).pwelch_masked_incorrect(i,:,:) = pwelch(squeeze(mean(pairs(s).EEG2.data(settings.selected_channels(i), 1:512, pairs(s).exp3_idx_inc), 3)));
        pairs(s).pwelch_masked_highpas(i,:,:) = pwelch(squeeze(mean(pairs(s).EEG2.data(settings.selected_channels(i), 1:512, pairs(s).exp3_idx_highpas), 3)));
        pairs(s).pwelch_masked_lowpas(i,:,:) = pwelch(squeeze(mean(pairs(s).EEG2.data(settings.selected_channels(i), 1:512, pairs(s).exp3_idx_lowpas), 3)));
        end

        
    catch

    end
end




squeeze(mean(mean(pairs(1).hilbert_threshold(:, :, pairs(1).exp1_idx_highpas), 3), 1))

for i = 1:length(pairs)

    comparison.exp1_highpas(i,:) = squeeze(mean(mean(pairs(i).hilbert_threshold(:, :, pairs(i).exp1_idx_highpas), 3), 1));
    comparison.exp3_highpas(i,:) = squeeze(mean(mean(pairs(i).hilbert_mask(:, :, pairs(i).exp3_idx_highpas), 3), 1));

    comparison.exp1_lowpas(i,:) = squeeze(mean(mean(pairs(i).hilbert_threshold(:, :, pairs(i).exp1_idx_lowpas), 3), 1));
    comparison.exp3_lowpas(i,:) = squeeze(mean(mean(pairs(i).hilbert_mask(:, :, pairs(i).exp3_idx_lowpas), 3), 1));
end


histogram(comparison)


figure; hold on
plot(mean(comparison.exp1_highpas, 1))
plot(mean(comparison.exp3_highpas, 1))
% poszukać outlierów
% eksport do fooofa
