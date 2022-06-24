close all
clear all

addpath('C:\Users\user\Desktop\eeglab2022.0')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
root='D:\Drive\2 - Cue\';
pathLoadData = [root '\ICA\']
mkdir([root, '\ERP'])
pathSaveData=[root '\ERP\'];=
eeglab nogui
list=dir([pathLoadData '\*.set'])
participants = length(list)


for s=[1:participants]
    try
        file=list(s).name;
        EEG = pop_loadset('filename',file,'filepath',pathLoadData);

        EEG = pop_rmbase( EEG, [-199    0]);
        
        elec.CP1 = find(strcmp({EEG.chanlocs.labels}, 'CP1')==1)	;
        elec.CPz = find(strcmp({EEG.chanlocs.labels}, 'CPz')==1)	;
        elec.CP2 = find(strcmp({EEG.chanlocs.labels}, 'CP2')==1)	;
        elec.CP3 = find(strcmp({EEG.chanlocs.labels}, 'CP3')==1)	;
        elec.CP4 = find(strcmp({EEG.chanlocs.labels}, 'CP4')==1)	;
        elec.P1 = find(strcmp({EEG.chanlocs.labels}, 'P1')==1)	;
        elec.P2 = find(strcmp({EEG.chanlocs.labels}, 'P2')==1)	;
        elec.P3 = find(strcmp({EEG.chanlocs.labels}, 'P3')==1)	;
        elec.P4 = find(strcmp({EEG.chanlocs.labels}, 'P4')==1)	;
        elec.Pz = find(strcmp({EEG.chanlocs.labels}, 'Pz')==1)	;
        elec.O1 = find(strcmp({EEG.chanlocs.labels}, 'O1')==1)	;
        elec.Oz = find(strcmp({EEG.chanlocs.labels}, 'Oz')==1)	;
        elec.O2 = find(strcmp({EEG.chanlocs.labels}, 'O2')==1)   ;
        elec.PO7 = find(strcmp({EEG.chanlocs.labels}, 'PO7')==1)	;
        elec.PO8 = find(strcmp({EEG.chanlocs.labels}, 'PO8')==1) ;
        elec.PO3 = find(strcmp({EEG.chanlocs.labels}, 'PO3')==1) ;
        elec.PO4 = find(strcmp({EEG.chanlocs.labels}, 'PO4')==1) ;
        VEOG = find(strcmp({EEG.chanlocs.labels}, 'VEOG')==1);		%INDEX CHANNEL
        HEOG = find(strcmp({EEG.chanlocs.labels}, 'HEOG')==1);		%INDEX CHANNEL
        VEOG2 = find(strcmp({EEG.chanlocs.labels}, 'VEOG2')==1);		%INDEX CHANNEL
        HEOG2 = find(strcmp({EEG.chanlocs.labels}, 'HEOG2')==1);		%INDEX CHANNEL
        M1 = find(strcmp({EEG.chanlocs.labels}, 'M1')==1);		%INDEX CHANNEL
        M2 = find(strcmp({EEG.chanlocs.labels}, 'M2')==1);		%INDEX CHANNEL
        Heartrate = find(strcmp({EEG.chanlocs.labels}, 'Heartrate')==1);		%INDEX CHANNEL
        
        
        electrodes.to_excl = [VEOG HEOG VEOG2 M1 M2 Heartrate];
        electrodes.P300 = [elec.P3 elec.P1 elec.Pz elec.P2 elec.P4 elec.CP3 elec.CP1 elec.CPz elec.CP2 elec.CP4]
        electrodes.VAN = [elec.O1 elec.Oz elec.O2 elec.PO7 elec.PO8]
        
        
        EEG = pop_reref( EEG, [],'exclude',[electrodes.to_excl] );
        
        channels = electrodes.VAN
        times_ROI = [EEG.times] > -200 & [EEG.times] < 1200
        %events_idx = [EEG.event.type] == 61
        %ERPs.cond1(s, :,:) = squeeze(mean(EEG.data(channels, times_ROI, events_idx), 3))
        ERPs.cond1(s, :,:) = squeeze(mean(EEG.data(channels, times_ROI, [EEG.event.type] == 61), 3))
        ERPs.cond2(s, :,:) = squeeze(mean(EEG.data(channels, times_ROI, [EEG.event.type] == 62), 3))
        ERPs.cond3(s, :,:) = squeeze(mean(EEG.data(channels, times_ROI, [EEG.event.type] == 63), 3))
        ERPs.cond4(s, :,:) = squeeze(mean(EEG.data(channels, times_ROI, [EEG.event.type] == 64), 3))
        
        
    catch
        warning(['Something went wrong with participant ' num2str(file)]);
    end
end
        
        save([pathSaveData '\ERP.mat'], 'ERPs')
        
        
        to_plot = squeeze(mean(ERPs.cond1, 1)) 
        % .....
        % 
        