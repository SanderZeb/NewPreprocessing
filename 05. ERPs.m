function run_ERPs(settings.paradigm, root)
settings.staticLims = 0
% close all
% clear all
% settings.paradigm = 1; % 1 - threshold; 2 - cue; 3 - mask; 4 - faces; 5 - scenes; 6 - Kinga
%
%
% addpath('C:\Users\user\Desktop\eeglab2022.0')
% addpath('C:\Program Files\MATLAB\R2019b\toolbox\signal\signal\')
% addpath('C:\Program Files\MATLAB\R2019b\toolbox\stats\stats\')
%
%
%
% if settings.paradigm == 1
%     root = 'D:\Drive\1 - Threshold\';
% elseif settings.paradigm == 2
%     root = 'D:\Drive\2 - Cue\';
% elseif settings.paradigm == 3
%     root = 'D:\Drive\3 - Mask\';
% elseif settings.paradigm == 4
%     root = 'D:\Drive\4 - Faces\';
% elseif settings.paradigm == 5
%     root = 'D:\Drive\5 - Scenes\';
% elseif settings.paradigm == 6
%     root='D:\Drive\6 - Kinga\';
% end

pathLoadData = [root '\MARA\']
mkdir([root, '\ERP'])
pathSaveData=[root '\ERP\'];
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
        elec.VEOG = find(strcmp({EEG.chanlocs.labels}, 'VEOG')==1);
        elec.HEOG = find(strcmp({EEG.chanlocs.labels}, 'HEOG')==1);
        elec.VEOG2 = find(strcmp({EEG.chanlocs.labels}, 'VEOG2')==1);
        elec.HEOG2 = find(strcmp({EEG.chanlocs.labels}, 'HEOG2')==1);
        elec.M1 = find(strcmp({EEG.chanlocs.labels}, 'M1')==1);
        elec.M2 = find(strcmp({EEG.chanlocs.labels}, 'M2')==1);
        elec.Heartrate = find(strcmp({EEG.chanlocs.labels}, 'Heartrate')==1);
        
        
        electrodes.to_excl = [elec.VEOG elec.HEOG elec.VEOG2 elec.M1 elec.M2 elec.Heartrate];
        electrodes.P300 = [elec.P3 elec.P1 elec.Pz elec.P2 elec.P4 elec.CP3 elec.CP1 elec.CPz elec.CP2 elec.CP4]
        electrodes.VAN = [elec.O1 elec.Oz elec.O2 elec.PO7 elec.PO8]
        
        
        EEG = pop_reref( EEG, [],'exclude',[electrodes.to_excl] );
        
        channels = electrodes.VAN
        times_ROI = [EEG.times] > -200 & [EEG.times] < 1200
        %events_idx = [EEG.event.type] == 61
        %ERPs.cond1(s, :,:) = squeeze(mean(EEG.data(channels, times_ROI, events_idx), 3))
        
        
        fnames = fieldnames(EEG.event)
        if settings.paradigm == 1
            fnames([2 3 4 5 10]) = []; % get rid of latency, type, det & id response; epoch id
        elseif settings.paradigm == 2
            
        elseif settings.paradigm == 3
            
        elseif settings.paradigm == 4
            
        elseif settings.paradigm == 5
            
        elseif settings.paradigm == 6
            fnames([2 3]) = []; % get rid of latency & type
            
        end
        
        for n = 1:length(fnames)
            event_values = unique([EEG.event.(fnames{n,1})]);
            for nn = 1:length(event_values)
                ERPs.([(fnames{n, 1}) '_' num2str(event_values(nn))])(s, :) = squeeze(mean(mean(EEG.data(channels, times_ROI, [EEG.event.(fnames{n,1})] == event_values(nn)), 3), 1));
            end
            clear event_values;
        end
    catch
        warning(['Something went wrong with participant ' num2str(file)]);
    end
end

save([pathSaveData '\ERP.mat'], 'ERPs')

clear fnames
fnames = fieldnames(ERPs)
settings.xlimup = 1000
settings.xlimdown = -200
settings.ss=get(0, 'ScreenSize');
n = 1
for i = 1:length(fnames)
    fnames2{i, :} = strsplit(fnames{i},'_')
    fnames{i, 2} = fnames2{i,1}{1};
    if size(fnames2{i,1}, 2) == 2
        fnames{i, 3} = fnames2{i,1}{2};
    elseif size(fnames2{i,1}, 2) == 3
        fnames{i, 3} = fnames2{i,1}{3};
    end
    
    
    if i>1 & strcmp(fnames{i, 2}, fnames{i-1, 2})
        fnames{i, 4} = n;
    elseif i == 1
        fnames{i, 4} = n;
    elseif i>1 & ~strcmp(fnames{i, 2}, fnames{i-1, 2})
        n=n+1;
        fnames{i, 4} = n;
    end
    
end


for i = 1:length(fnames)
    dynamic_max = max(max( squeeze(mean(ERPs.(fnames{i, 1}))) + (2*sem(ERPs.(fnames{i, 1})))));
    dynamic_min = min(min( squeeze(mean(ERPs.(fnames{i, 1}))) - (2*sem(ERPs.(fnames{i, 1})))));
    if exist('dynamic_max_all')
        if dynamic_max > dynamic_max_all
            dynamic_max_all = dynamic_max;
        end
    else
        dynamic_max_all = dynamic_max;
    end
    if exist('dynamic_min_all')
        if dynamic_min < dynamic_min_all
            dynamic_min_all = dynamic_min;
        end
    else
        dynamic_min_all = dynamic_min;
    end
    
end






if settings.staticLims == 1
    settings.mlimitdown=-5
    settings.mlimitup=5
    
elseif settings.staticLims == 0
    settings.mlimitdown=dynamic_min_all - (dynamic_min_all*0.2);
    settings.mlimitup=dynamic_max_all + (dynamic_max_all*0.2);
end

settings.timesVec=EEG.times(times_ROI);


for i = 1:length(unique([fnames{:, 4}]))
    
    
    fnames_slice = {fnames{[([fnames{:, 4}] == i)], 1}}'
    titles_slice = {fnames{[([fnames{:, 4}] == i)], 2}}'
    conds_slice = {fnames{[([fnames{:, 4}] == i)], 3}}'
    
    iii = 1
    for ii = 1: length(conds_slice)
        if ii == 1
            conds_slice2{ii} = conds_slice{ii}
        else
            iii = iii+3;
            conds_slice2{iii} = conds_slice{ii};
        end
    end
    
    
    for ii = 1:length(conds_slice2)
        if isempty(conds_slice2{ii})
            conds_slice2{ii} = ' ';
        end
    end
    task_type = fnames{[fnames{:, 4}] == 2, 2}
    
    fig = figure('Position', [0 0 settings.ss(3) settings.ss(4)], 'Visible', 'off'); hold on;
    
    for n = 1:length(fnames_slice)
        to_plot = squeeze(mean(ERPs.(fnames_slice{n, 1}), 1));
        sem_1=to_plot - (2*sem(ERPs.(fnames_slice{n, 1})));
        sem_2=to_plot + (2*sem(ERPs.(fnames_slice{n, 1})));
        
        plot(settings.timesVec,squeeze(to_plot), 'Color',[rand,rand,rand], 'LineWidth',1)
        plot(settings.timesVec,squeeze(sem_1), '--k')
        plot(settings.timesVec,squeeze(sem_2), '--k')
    end
    
    legend(conds_slice);
    xlim([settings.xlimdown settings.xlimup])
    ylim([settings.mlimitdown settings.mlimitup])
    title((titles_slice{1, 1}),'Fontsize',13)
    saveas(fig,[pathSaveData titles_slice{1,1} num2str(channels) '.png']);
    saveas(fig,[pathSaveData titles_slice{1,1} num2str(channels) '.fig']);
    close all
    clear fig conds_slice conds_slice2 titles_slice fnames_slice
end
end